package com.shop.core.common;


import com.shop.core.exception.CustomerNotFoundException;
import com.shop.core.exception.UserNotFoundException;
import com.shop.primary.constant.Config;
import com.shop.primary.entity.Customer;
import com.shop.primary.entity.User;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;


public class BaseController {


    @Autowired
    protected HttpServletRequest request;

    /**
     * 获取客户端ip
     * */
    protected String getClientIp() {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("X-Forwarded-For");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        ip = "0:0:0:0:0:0:0:1".equals(ip) ? "127.0.0.1" : ip;
        if (ip != null) {
            ip = ip.split(",")[0];
        } else {
            ip = "";
        }
        return ip;
    }

    protected User getLoginInfo(){
        User loginInfo = (User) request.getSession().getAttribute(Config.USER_INFO);
        if (loginInfo == null) {
            throw new UserNotFoundException("缺少登录信息");
        }
        return loginInfo;
    }

    protected Customer checkCustomerInfo(){
        Customer customer = (Customer) request.getSession().getAttribute(Config.CUSTOMER_INFO);
        if (customer == null) {
            throw new CustomerNotFoundException("缺少登录信息");
        }
        return customer;
    }

    protected Customer getCustomerInfo(){
        Customer customer = (Customer) request.getSession().getAttribute(Config.CUSTOMER_INFO);
        return customer;
    }
}
