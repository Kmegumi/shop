package com.shop.primary.controller;

import com.shop.core.common.AdminCoreController;
import com.shop.core.utils.NumUtil;
import com.shop.primary.pojo.query.AdminQuery;
import com.shop.primary.pojo.vo.ResultCodeVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * 后台通用管理控制器（无安全拦截管理）
 *
 * @author yuweilun
 * @date 2017/8/16
 */
@Controller
public class CommonController extends AdminCoreController {


    /**
     * 首页
     * @param request
     * @return
     */
    @RequestMapping("index")
    public String index(AdminQuery adminQuery, ModelMap modelMap){
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
        return "main";
    }



}