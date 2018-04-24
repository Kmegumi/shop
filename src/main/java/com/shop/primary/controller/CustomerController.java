package com.shop.primary.controller;

import com.shop.core.common.BaseController;
import com.shop.primary.entity.Customer;
import com.shop.primary.pojo.query.AdminQuery;
import com.shop.primary.pojo.query.OrderQuery;
import com.shop.primary.pojo.vo.ResultCodeVO;
import com.shop.primary.service.CustomerService;
import com.shop.primary.service.OrderService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.math.BigDecimal;

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

    @RequestMapping(value = "payMoney")
    @ResponseBody
    public ResultCodeVO payMoney(Long id, BigDecimal money) {
        if (id == null || money == null) {
            return new ResultCodeVO("400", "参数有误，充值失败");
        }
        Customer customer = customerService.getById(id);
        customer.setMoney(customer.getMoney().add(money));
        try {
            customerService.update(customer);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return new ResultCodeVO("400", "充值失败");
        }
        return new ResultCodeVO("200", "充值成功");
    }


}
