package com.shop.core.common;

import com.shop.core.exception.CustomerNotFoundException;
import com.shop.core.exception.UserNotFoundException;
import com.shop.core.utils.HttpUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
public class BaseControllerAdvice {

    private static final Logger logger = LoggerFactory.getLogger(BaseControllerAdvice.class);

    @ExceptionHandler(value = {UserNotFoundException.class})
    @ResponseBody
    public Object userNotFoundExp(UserNotFoundException ex, HttpServletRequest request) {
        if (HttpUtil.isAjaxRequest(request)) {
            Map<String, String> map = new HashMap<>(4);
            map.put("code", "400");
            map.put("msg", ex.getMessage());
            return map;
        }
        //返回登录页
        return new ModelAndView("redirect:/rest/admin/login");
    }

    @ExceptionHandler(value = {CustomerNotFoundException.class})
    @ResponseBody
    public Object customerNotFoundExp(CustomerNotFoundException ex, HttpServletRequest request) {
        if (HttpUtil.isAjaxRequest(request)) {
            Map<String, String> map = new HashMap<>(4);
            map.put("code", "401");
            map.put("msg", "请登录用户");
            return map;
        }
        //返回登录页
        return new ModelAndView("redirect:/rest/front/commonLogin");
    }

}
