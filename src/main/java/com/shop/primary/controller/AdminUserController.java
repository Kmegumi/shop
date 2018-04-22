package com.shop.primary.controller;

import com.shop.core.common.BaseController;
import com.shop.core.exception.ServiceException;
import com.shop.core.exception.UserNotFoundException;
import com.shop.primary.constant.Config;
import com.shop.primary.entity.User;
import com.shop.primary.enums.StatusEnum;
import com.shop.primary.pojo.query.AdminQuery;
import com.shop.primary.service.AdminService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;


/**
 * 后台用户管理控制器
 *
 * @author xutianhao
 * @date 2017/10/21
 */
@Controller
@RequestMapping("/admin")
public class AdminUserController extends BaseController {


    private static final Logger logger = LoggerFactory.getLogger(AdminUserController.class);

    @Autowired
    private AdminService adminService;

    @RequestMapping(value = "list")
    public String adminList(AdminQuery adminQuery, ModelMap modelMap) {
        getLoginInfo();
        modelMap.addAttribute("page", adminService.rowBoundForUser(adminQuery));
        modelMap.addAttribute("form", adminQuery);
        modelMap.addAttribute("statusList", StatusEnum.LIST);
        return "/admin/list";
    }

    @RequestMapping(value = "add", method = RequestMethod.GET)
    public String adminAdd(ModelMap modelMap){
        getLoginInfo();
        modelMap.addAttribute("statusEnum", StatusEnum.LIST);
        return "/admin/edit";
    }

    @RequestMapping(value = "edit/{id}", method = RequestMethod.GET)
    public String adminEdit(AdminQuery adminQuery, ModelMap modelMap) {
        getLoginInfo();
        User user = adminService.getById(adminQuery.getId());
        modelMap.addAttribute("user", user);
        modelMap.addAttribute("statusEnum", StatusEnum.LIST);
        return "/admin/edit";
    }

    @RequestMapping(value = "saveOrUpdateAdmin", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> saveOrUpdateAdmin(User user) {
        Map<String, String> map = new HashMap<>(4);
        try {
            user = adminService.saveOrUpdateAdmin(user, getLoginInfo().getId());
        } catch (ServiceException e) {
            map.put("code", "1002");
            map.put("msg", e.getMessage());
            return map;
        } catch (Exception e) {
            logger.error(user.toString()+"_"+e.getMessage(), e);
        }
        if (user == null) {
            map.put("code", "1002");
            if (user.getId() != null) {
                map.put("msg", "用户信息修改失败");
                return map;
            }
            map.put("msg", "用户信息保存失败");
            return map;
        }

        if (user.getId() != null) {
            map.put("code", "1001");
            map.put("msg", "用户信息修改成功");
        } else {
            map.put("code", "1000");
            map.put("msg", "用户信息添加成功");
        }
        return map;
    }

    @RequestMapping(value = "deleteAdmin", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> deleteAdmin(Long id) {
        getLoginInfo();
        Map<String, String> map = new HashMap<>(4);
        boolean result = false;
        try {
            adminService.deleteById(id);
        } catch (Exception e) {
            logger.error(id == null ? "null":id .toString()+ "_"+e.getMessage(), e);
            map.put("code", "1001");
            map.put("msg", "用户删除失败");
            return map;
        }
        map.put("code", "1000");
        map.put("msg", "用户删除成功");
        return map;
    }
}
