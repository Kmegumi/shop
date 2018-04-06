package com.shop.primary.controller;


import com.shop.primary.entity.Column;
import com.shop.primary.entity.Goods;
import com.shop.primary.service.GoodsService;
import com.shop.primary.service.impl.ColumnService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("column")
public class ColumnController {
    @Autowired
    private ColumnService columnService;

    @RequestMapping("add")

    public String add(){
        return "column/add";
    }
    @RequestMapping("save")
    @ResponseBody
    public Map save(Column column){
        Map map=new HashMap();
        try {
            column = columnService.save(column);
        } catch (RuntimeException e) {
            map.put("msg", e.getMessage());
            return map;
        }
        if(column==null){
            map.put("msg","插入失败！");
        }
        else {
            map.put("msg","插入成功");
        }
        return map;
    }
}
