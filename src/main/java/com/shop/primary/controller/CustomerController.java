package com.shop.primary.controller;

import com.shop.core.common.BaseController;
import com.shop.primary.pojo.query.AdminQuery;
import com.shop.primary.pojo.query.OrderQuery;
import com.shop.primary.service.CustomerService;
import com.shop.primary.service.OrderService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping(value = "customer")
@Controller
public class CustomerController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(CustomerController.class);

    @Autowired
    private CustomerService customerService;

    @RequestMapping(value = "list")
    public String adminList(AdminQuery adminQuery, ModelMap modelMap) {
        getLoginInfo();
        modelMap.addAttribute("page", customerService.rowBound(adminQuery));
        modelMap.addAttribute("form", adminQuery);
        return "/customer/list";
    }


}
