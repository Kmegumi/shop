package com.shop.primary.controller;

import com.shop.core.common.AdminCoreController;
import com.shop.core.exception.ServiceException;
import com.shop.primary.pojo.query.AdminLoginQuery;
import com.shop.primary.pojo.vo.ResultCodeVO;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * 后台登录管理控制器
 *
 * @author yuweilun
 * @date 2017/8/16
 */
@Controller
@RequestMapping("/login")
public class LoginController extends AdminCoreController {

    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

    /**
     * shiro转发默认login页
     * @return
     */
    @RequestMapping(value = "index",method = RequestMethod.GET)
    public String index() {
        Subject subject = SecurityUtils.getSubject();
        // 已登陆则 跳到首页
        if (subject.isAuthenticated()) {
            return "redirect:/rest/index";
        }
        return "login";
    }


    /**
     * 登录请求
     * @return
     */
    @RequestMapping(value = "login",method = RequestMethod.POST)
    @ResponseBody
    public ResultCodeVO login(AdminLoginQuery adminLoginQuery) {
        try {
            Subject subject = SecurityUtils.getSubject();
            // 已登陆则先退出
            if (subject.isAuthenticated()) {
                subject.logout();
            }
            if (StringUtils.isBlank(adminLoginQuery.getUsername()) || StringUtils.isBlank(adminLoginQuery.getPassword())) {
                return ResultCodeVO.PASSWORD_NULL;
            }
            // shiro身份验证
            subject.login(new UsernamePasswordToken(adminLoginQuery.getUsername(), adminLoginQuery.getPassword()));
        } catch (AuthenticationException e) {
            // 身份验证失败
            logger.info(adminLoginQuery.toString()+"_"+e.getMessage()+"_"+getClientIp(), e);
            return ResultCodeVO.PASSWORD_ERROR;
        } catch (ServiceException e) {
            return new ResultCodeVO("0", e.getMessage());
        } catch (Exception e) {
            logger.error(adminLoginQuery.toString()+"_"+e.getMessage()+"_"+getClientIp(), e);
            return ResultCodeVO.ACCOUNT_ERR;
        }
        return ResultCodeVO.LOGIN_SUCCESS;
    }

    /**
     * 退出
     * @return
     */
    @RequestMapping(value = "logout", method = RequestMethod.GET)
    public String logout() {
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        return "login";
    }
}
