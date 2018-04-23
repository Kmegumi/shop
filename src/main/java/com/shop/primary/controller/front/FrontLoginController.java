package com.shop.primary.controller.front;

import com.shop.core.common.BaseController;
import com.shop.primary.constant.Config;
import com.shop.primary.entity.Customer;
import com.shop.primary.pojo.vo.ResultCodeVO;
import com.shop.primary.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.math.BigDecimal;

@RequestMapping("/front")
@Controller
public class FrontLoginController extends BaseController {

    @Autowired
    private CustomerService customerService;

    @RequestMapping(value = "loginStatus")
    @ResponseBody
    private ResultCodeVO loginStatus(){
        Customer customer = getCustomerInfo();
        if (customer == null) {
            return ResultCodeVO.UN_LOGIN_CODE;
        }
        return ResultCodeVO.LOGIN_SUCCESS;
    }

    @RequestMapping(value = "login")
    @ResponseBody
    public ResultCodeVO login(String checkCode, String tel) {
        if ("123456".equalsIgnoreCase(checkCode)){
            Customer customer = customerService.getCustomerByTel(tel);
            if (customer == null) {
                customer = new Customer();
                customer.setMobile(tel);
                customer.setMoney(new BigDecimal(0));
                customer.setName("未知");
                customerService.save(customer);
            }
            request.getSession().setAttribute(Config.CUSTOMER_INFO, customer);
            return ResultCodeVO.LOGIN_SUCCESS;
        }
        return ResultCodeVO.UN_LOGIN_CODE;
    }

    @RequestMapping("commonLogin")
    public String commonLogin(){
        return "front/login";
    }
}
