package com.shop.primary.controller.front;

import com.shop.core.common.BaseController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/front")
public class FrontUserController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(FrontUserController.class);

    @RequestMapping("personal")
    public String  personal(ModelMap modelMap){
        modelMap.addAttribute("customer", checkCustomerInfo());
        return "front/personal";
    }

    @RequestMapping("userInfo")
    public String  userInfo(ModelMap modelMap){
        modelMap.addAttribute("customer", checkCustomerInfo());
        return "front/user/userInfo";
    }


}
