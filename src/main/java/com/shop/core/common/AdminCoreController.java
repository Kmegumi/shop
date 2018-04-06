package com.shop.core.common;

import com.shop.core.exception.UserValidateException;
import com.shop.core.utils.HttpUtil;
import com.shop.primary.pojo.vo.ResultCodeVO;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.authz.UnauthenticatedException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;


public class AdminCoreController extends BaseController {


    private static final Logger logger = LoggerFactory.getLogger(AdminCoreController.class);

    @ExceptionHandler(value = {UserValidateException.class})
    @ResponseBody
    public Object userLoginExp(UserValidateException ex, HttpServletRequest request) {
        if (HttpUtil.isAjaxRequest(request)) {
            Map<String, String> map = new HashMap<String, String>();
            map.put("code", ex.getMessage());
            return map;
        }
        //返回登录页
        return new ModelAndView("redirect:/rest/login/index");
    }


    //shiro权限出错
    @ExceptionHandler(value = {UnauthenticatedException.class, AuthorizationException.class})
    @ResponseBody
    public Object noPermission(Exception ex, HttpServletRequest request) {
        logger.info("noPermissionEx", ex);
        if (HttpUtil.isAjaxRequest(request)) {
            return ResultCodeVO.NO_PERMISSION;
        }
        //返回登录页
        return new ModelAndView("redirect:/static/401.html");
    }

}
