package com.shop.primary.controller;

import com.shop.core.common.BaseController;
import com.shop.primary.constant.Config;
import com.shop.primary.entity.User;
import com.shop.primary.enums.StatusEnum;
import com.shop.primary.pojo.query.AdminLoginQuery;
import com.shop.primary.pojo.vo.ResultCodeVO;
import com.shop.primary.service.AdminService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/login")
public class LoginController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

    @Autowired
    private AdminService adminService;

    /**
     * 登录请求
     * @return
     */
    @RequestMapping(value = "login",method = RequestMethod.POST)
    @ResponseBody
    public ResultCodeVO login(AdminLoginQuery adminLoginQuery) {
        try {
            if (StringUtils.isEmpty(adminLoginQuery.getUsername()) || StringUtils.isEmpty(adminLoginQuery.getPassword())) {
                return ResultCodeVO.PASSWORD_NULL;
            }
            User authentication = adminService.userLoginCheck(adminLoginQuery);
            if (authentication == null) {
                return ResultCodeVO.PASSWORD_ERROR;
            }
            if(authentication.getStatus().name().equals(StatusEnum.N.name())){
                return new ResultCodeVO("400","该账号被禁用,请联系管理员！");
            }
            request.getSession().setAttribute(Config.USER_INFO, authentication);
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
        request.getSession().setAttribute(Config.USER_INFO, null);
        return "login";
    }
}
