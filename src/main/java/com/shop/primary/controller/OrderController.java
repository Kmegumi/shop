package com.shop.primary.controller;

import com.shop.core.common.BaseController;
import com.shop.primary.entity.Order;
import com.shop.primary.enums.OrderStatusEnum;
import com.shop.primary.pojo.query.OrderQuery;
import com.shop.primary.pojo.vo.ResultCodeVO;
import com.shop.primary.service.OrderService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@RequestMapping(value = "order")
@Controller
public class OrderController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(OrderController.class);

    @Autowired
    private OrderService orderService;

    @RequestMapping(value = "list")
    public String adminList(OrderQuery orderQuery, ModelMap modelMap) {
        getLoginInfo();
        modelMap.addAttribute("page", orderService.rowBound(orderQuery));
        modelMap.addAttribute("form", orderQuery);
        return "/order/list";
    }


}
