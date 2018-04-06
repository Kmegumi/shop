package com.shop.primary.controller;


import com.shop.primary.entity.Goods;
import com.shop.primary.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("goods")
public class GoodsController {

    @Autowired
    private GoodsService goodsService;

    @RequestMapping("add")
    public String add() {
        return "goods/add";
    }
    @RequestMapping("save")
    @ResponseBody
    public Map save(Goods goods){
        Map map=new HashMap();
        try {
            goods = goodsService.save(goods);
        } catch (RuntimeException e) {
            map.put("msg", e.getMessage());
            return map;
        }
        if(goods==null){
            map.put("msg","插入失败！");
        }
        else {
            map.put("msg","插入成功");
        }
        return map;
    }

}
