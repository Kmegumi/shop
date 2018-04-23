package com.shop.primary.controller;

import com.shop.core.common.BaseController;
import com.shop.primary.pojo.query.AdminQuery;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CommonController extends BaseController {

    /**
     * 后台登录页
     * */
    @RequestMapping("admin/login")
    public String adminLogin(){
        return "login";
    }

    /**
     * 首页
     * @return
     */
    @RequestMapping("index")
    public String index(AdminQuery adminQuery, ModelMap modelMap){
        getLoginInfo();
        modelMap.addAttribute("admin", adminQuery.getUser());
        return "index";
    }

    /**
     * 404页面
     * @return
     */
    @RequestMapping("404")
    public String r404() {
        return "redirect:/static/404.html";
    }

    /**
     * 500页面
     * @return
     */
    @RequestMapping("500")
    public String r500() {
        return "redirect:/static/500.html";
    }

    /**
     * 登陆后欢迎页面
     * @return
     */
    @RequestMapping("main")
    public String welcome() {
        getLoginInfo();
        return "main";
    }
}