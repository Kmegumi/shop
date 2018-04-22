package com.shop.primary.controller;

import com.shop.core.common.BaseController;
import com.shop.primary.entity.Goods;
import com.shop.primary.entity.GoodsRecommend;
import com.shop.primary.pojo.query.AdminQuery;
import com.shop.primary.service.GoodsRecommendService;
import com.shop.primary.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * @author megumi
 * @date 2018/4/22
 */
@RequestMapping(value = "/goodsRecommend")
@Controller
public class GoodsRecommendController extends BaseController {

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



}
