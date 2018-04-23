package com.shop.primary.controller;

import com.shop.core.common.BaseController;
import com.shop.primary.entity.Goods;
import com.shop.primary.entity.GoodsRecommend;
import com.shop.primary.entity.User;
import com.shop.primary.pojo.query.AdminQuery;
import com.shop.primary.pojo.vo.ResultCodeVO;
import com.shop.primary.service.GoodsRecommendService;
import com.shop.primary.service.GoodsService;
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

@RequestMapping(value = "/goodsRecommend")
@Controller
public class GoodsRecommendController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(GoodsRecommendController.class);

    @Autowired
    private GoodsRecommendService goodsRecommendService;
    @Autowired
    private GoodsService goodsService;

    @RequestMapping(value = "list")
    public String adminList(AdminQuery adminQuery, ModelMap modelMap) {
        getLoginInfo();
        modelMap.addAttribute("page", goodsRecommendService.rowBound(adminQuery));
        modelMap.addAttribute("form", adminQuery);
        return "/goodsRecommend/list";
    }

    @RequestMapping("add")
    public String add(Long id, ModelMap modelMap) {
        getLoginInfo();
        List<Goods> list = goodsService.listGoodsNotInGoodsRecommendList(id);
        modelMap.addAttribute("list", list);
        if (id != null) {
            GoodsRecommend goodsRecommend = goodsRecommendService.getById(id);
            modelMap.addAttribute("goodsRecommend", goodsRecommend);
        }
        return "goodsRecommend/add";
    }


    @RequestMapping("saveOrUpdate")
    @ResponseBody
    public ResultCodeVO save(GoodsRecommend goodsRecommend){
        User user = getLoginInfo();
        try {
            goodsRecommend = goodsRecommendService.saveOrUpdate(goodsRecommend);
        } catch (Exception e) {
            logger.error(user.toString()+"_"+e.getMessage(), e);
        }
        if (goodsRecommend == null) {
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
            goodsRecommendService.deleteById(id);
        } catch (Exception e) {
            logger.error(id == null ? "null":id .toString()+ "_"+e.getMessage(), e);
            map.put("code", "400");
            map.put("msg", "推荐商品删除失败");
            return map;
        }
        map.put("code", "200");
        map.put("msg", "推荐商品删除成功");
        return map;
    }
}
