package com.shop.primary.controller.front;

import com.shop.core.common.BaseController;
import com.shop.primary.entity.Banner;
import com.shop.primary.entity.GoodsColumn;
import com.shop.primary.entity.GoodsRecommend;
import com.shop.primary.service.BannerService;
import com.shop.primary.service.ColumnService;
import com.shop.primary.service.GoodsRecommendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@RequestMapping("/front")
@Controller
public class FrontIndexController extends BaseController {

    @Autowired
    private BannerService bannerService;
    @Autowired
    private ColumnService columnService;
    @Autowired
    private GoodsRecommendService goodsRecommendService;

    @RequestMapping(value = "index")
    public String index(ModelMap modelMap){
        List<Banner> list = bannerService.listAll();
        List<GoodsColumn> goodsColumnList = columnService.findListForIndex();
        List<GoodsRecommend> goodsRecommendList = goodsRecommendService.listAll();
        modelMap.addAttribute("bannerList",list);
        modelMap.addAttribute("columnList", goodsColumnList);
        modelMap.addAttribute("goodsRecommendList", goodsRecommendList);
        return "front/index";
    }

}
