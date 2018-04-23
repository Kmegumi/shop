package com.shop.primary.controller;

import com.shop.core.common.BaseController;
import com.shop.primary.entity.Goods;
import com.shop.primary.entity.GoodsRecommend;
import com.shop.primary.entity.GoodsUpNew;
import com.shop.primary.entity.User;
import com.shop.primary.pojo.query.AdminQuery;
import com.shop.primary.pojo.vo.ResultCodeVO;
import com.shop.primary.service.GoodsRecommendService;
import com.shop.primary.service.GoodsService;
import com.shop.primary.service.GoodsUpNewService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping(value = "/goodsUpNew")
@Controller
public class GoodsUpNewController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(GoodsUpNewController.class);

    @Autowired
    private GoodsUpNewService goodsUpNewService;
    @Autowired
    private GoodsService goodsService;

    @RequestMapping(value = "list")
    public String adminList(AdminQuery adminQuery, ModelMap modelMap) {
        getLoginInfo();
        modelMap.addAttribute("page", goodsUpNewService.rowBound(adminQuery));
        modelMap.addAttribute("form", adminQuery);
        return "/goodsUpNew/list";
    }

    @RequestMapping("add")
    public String add(Long id, ModelMap modelMap) {
        getLoginInfo();
        List<Goods> list = goodsService.listGoodsNotInGoodsUpNewList(id);
        modelMap.addAttribute("list", list);
        if (id != null) {
            GoodsUpNew goodsUpNew = goodsUpNewService.getById(id);
            modelMap.addAttribute("goodsUpNew", goodsUpNew);
        }
        return "goodsUpNew/add";
    }


    @RequestMapping("saveOrUpdate")
    @ResponseBody
    public ResultCodeVO save(GoodsUpNew goodsUpNew){
        User user = getLoginInfo();
        try {
            goodsUpNew = goodsUpNewService.saveOrUpdate(goodsUpNew);
        } catch (Exception e) {
            logger.error(user.toString()+"_"+e.getMessage(), e);
        }
        if (goodsUpNew == null) {
            return new ResultCodeVO("400", "保存失败");
        }
        return new ResultCodeVO("200", "保存成功");
    }

    @RequestMapping(value = "delete", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> deleteAdmin(Long id) {
        getLoginInfo();
        Map<String, String> map = new HashMap<>(4);
        try {
            goodsUpNewService.deleteById(id);
        } catch (Exception e) {
            logger.error(id == null ? "null":id .toString()+ "_"+e.getMessage(), e);
            map.put("code", "400");
            map.put("msg", "上新商品删除失败");
            return map;
        }
        map.put("code", "200");
        map.put("msg", "上新商品删除成功");
        return map;
    }
}
