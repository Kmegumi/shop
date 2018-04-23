package com.shop.primary.controller.front;

import com.shop.core.common.BaseController;
import com.shop.core.utils.DateUtils;
import com.shop.primary.entity.Collect;
import com.shop.primary.entity.Customer;
import com.shop.primary.entity.Goods;
import com.shop.primary.entity.GoodsColumn;
import com.shop.primary.pojo.query.AdminQuery;
import com.shop.primary.pojo.vo.ResultCodeVO;
import com.shop.primary.service.CollectService;
import com.shop.primary.service.ColumnService;
import com.shop.primary.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * @author megumi
 * @date 2018/4/23
 */
@RequestMapping(value = "/front")
@Controller
public class FrontGoodsController extends BaseController {

    @Autowired
    private ColumnService columnService;
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private CollectService collectService;

    @RequestMapping(value = "goodsList", method = RequestMethod.GET)
    public String goodsList(Long columnId, ModelMap modelMap){
        List<GoodsColumn> columnList = columnService.listAll();
        modelMap.addAttribute("columnList", columnList);
        if (columnId == null) {
            List<Goods> list = goodsService.listAll();
            modelMap.addAttribute("goodsList", list);
        } else {
            List<Goods> list = goodsService.findAllByColumnId(columnId);
            modelMap.addAttribute("goodsList", list);
        }
        return "front/goods/list";
    }

    @RequestMapping(value = "goodsList", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView goodsList(Long columnId){
        ModelAndView modelAndView = new ModelAndView("front/goods/listTeam");
        List<GoodsColumn> columnList = columnService.listAll();
        modelAndView.addObject("columnList", columnList);
        if (columnId == null || columnId == 0) {
            List<Goods> list = goodsService.listAll();
            modelAndView.addObject("goodsList", list);
        } else {
            List<Goods> list = goodsService.findAllByColumnId(columnId);
            modelAndView.addObject("goodsList", list);
        }
        return modelAndView;
    }

    /**
     * 商品详情
     * */
    @RequestMapping("goods/{id}")
    public String goodsDetail(AdminQuery adminQuery, ModelMap modelMap){
        Customer customer = getCustomerInfo();
        //判断该商品类型
        Goods goods = goodsService.getById(adminQuery.getId());
        if (goods == null) {
            return "redirect:/rest/front/notExists";
        }
        if (customer != null) {
            Collect collect = collectService.findByCustomerIdAndGoodsId(customer.getId(), adminQuery.getId());
            if (collect != null) {
                modelMap.addAttribute("collect", true);
            } else {
                modelMap.addAttribute("collect", false);
            }
        } else {
            modelMap.addAttribute("collect", false);
        }
        modelMap.addAttribute("goods", goods);
        modelMap.addAttribute("time", System.currentTimeMillis());
        if (goods.getGoodsStock() <= 0L) {
            modelMap.addAttribute("sellOut", true);
            return "front/goods/goodsDetail";
        } else {
            modelMap.addAttribute("sellOut", false);
        }
        if (goods.getStartTime().isAfter(LocalDateTime.now())) {
            //未开始倒计时
            modelMap.addAttribute("startFlag", false);
            modelMap.addAttribute("startTime", DateUtils.getInstantFromLocalDateTime(goods.getStartTime()).toEpochMilli());
        } else {
            modelMap.addAttribute("startFlag", true);
        }
        return "front/goods/goodsDetail";
    }

    @RequestMapping(value = "goodsCollect")
    @ResponseBody
    public ResultCodeVO goodsCollect(Long id, Boolean type){
        Customer customer = checkCustomerInfo();
        if (type == null) {
            return ResultCodeVO.PARAM_ERR;
        }
        if (type) {
            try {
                Collect collect = new Collect();
                collect.setCustomerId(customer.getId());
                collect.setGoodsId(id);
                collectService.save(collect);
            } catch (Exception e) {
                return new ResultCodeVO("400","收藏失败！");
            }
            return ResultCodeVO.LOGIN_SUCCESS;
        }
        Collect collect = collectService.findByCustomerIdAndGoodsId(customer.getId(), id);
        if (collect == null) {
            return new ResultCodeVO("400","取消收藏失败，你尚未收藏该商品！");
        }
        try {
            collectService.deleteById(collect.getId());
        } catch (Exception e) {
            return new ResultCodeVO("400","取消收藏失败！");
        }
        return new ResultCodeVO("201","");
    }

}
