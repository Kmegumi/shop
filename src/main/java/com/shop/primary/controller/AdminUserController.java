package com.shop.primary.controller;

import com.shop.core.common.AdminCoreController;
import com.shop.core.exception.ServiceException;
import com.shop.primary.entity.Role;
import com.shop.primary.entity.User;
import com.shop.primary.enums.StatusEnum;
import com.shop.primary.pojo.dto.UserRolesDTO;
import com.shop.primary.pojo.query.AdminInfoQuery;
import com.shop.primary.pojo.query.AdminQuery;
import com.shop.primary.pojo.vo.RowBoundVO;
import com.shop.primary.service.AdminService;
import com.shop.primary.service.RoleService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 后台用户管理控制器
 *
 * @author xutianhao
 * @date 2017/10/21
 */
@Controller
@RequestMapping("/admin")
public class AdminUserController extends AdminCoreController {


    private static final Logger logger = LoggerFactory.getLogger(AdminUserController.class);

    @Resource
    private AdminService adminService;

    @Resource
    private RoleService roleService;

    @RequestMapping(value = "list")
    @RequiresPermissions("admin:list")
    public String adminList(AdminQuery adminQuery, ModelMap modelMap) {
        RowBoundVO<User> rowBoundVO = adminService.rowBoundForUser(adminQuery);
        modelMap.addAttribute("dome", rowBoundVO);
        modelMap.addAttribute("form", adminQuery);
        modelMap.addAttribute("statusList", StatusEnum.getList());
        return "/admin/list";
    }

    @RequestMapping(value = "add", method = RequestMethod.GET)
    @RequiresPermissions("admin:add")
    public String adminAdd(ModelMap modelMap){
        modelMap.addAttribute("statusEnum", StatusEnum.getList());
        return "/admin/edit";
    }

    @RequestMapping(value = "edit/{id}", method = RequestMethod.GET)
    @RequiresPermissions("admin:edit")
    public String adminEdit(AdminQuery adminQuery, ModelMap modelMap) {
        User user = adminService.getUserById(adminQuery.getId());
        List<Role> list = adminService.listRoleByAdminUser(user);
        String[] roleIdArr = new String[list.size()];
        String[] roleNameArr = new String[list.size()];
        for (int i = 0; i < list.size(); i++) {
            Role role = list.get(i);
            roleIdArr[i] = String.valueOf(role.getId());
            roleNameArr[i] = String.valueOf(role.getRoleName());
        }
        modelMap.addAttribute("user", user);
        modelMap.addAttribute("roleId", String.join(",", roleIdArr));
        modelMap.addAttribute("roleName", String.join(",", roleNameArr));
        modelMap.addAttribute("statusEnum", StatusEnum.getList());
        return "/admin/edit";
    }

    @RequestMapping(value = "saveOrUpdateAdmin", method = RequestMethod.POST)
    @RequiresPermissions("admin:saveOrUpdateAdmin")
    @ResponseBody
    public Map<String, String> saveOrUpdateAdmin(AdminInfoQuery adminInfoQuery) {
        Map<String, String> map = new HashMap<>(4);
        User user = null;
        try {
            user = adminService.saveOrUpdateAdmin(adminInfoQuery);
        } catch (ServiceException e) {
            map.put("code", "1002");
            map.put("msg", e.getMessage());
            return map;
        } catch (Exception e) {
            logger.error(adminInfoQuery.toString()+"_"+e.getMessage(), e);
        }
        if (user == null) {
            map.put("code", "1002");
            if (adminInfoQuery.getId() != null) {
                map.put("msg", "用户信息修改失败");
                return map;
            }
            map.put("msg", "用户信息保存失败");
            return map;
        }

        if (adminInfoQuery.getId() != null) {
            map.put("code", "1001");
            map.put("msg", "用户信息修改成功，角色信息保存失败");
        } else {
            map.put("code", "1000");
            map.put("msg", "用户信息添加成功，角色信息保存失败");
        }

        if (adminInfoQuery.getRoleId() == null) {
            return map;
        }

        UserRolesDTO userRolesDTO = new UserRolesDTO();
        userRolesDTO.setUserId(user.getId());
        userRolesDTO.setRoleIdList(adminInfoQuery.getRoleId().split(","));
        boolean result = false;
        try {
            result = roleService.saveUserRoles(userRolesDTO);
        } catch (Exception e) {
            logger.error(userRolesDTO.toString()+"_"+e.getMessage(),e);
        }
        if (result) {
            if (adminInfoQuery.getId() != null) {
                map.put("msg", "用户信息修改成功");
                return map;
            }
            map.put("msg", "用户信息添加成功");
            return map;
        }
        return map;
    }

    @RequestMapping(value = "deleteAdmin", method = RequestMethod.POST)
    @RequiresPermissions("admin:deleteAdmin")
    @ResponseBody
    public Map<String, String> deleteAdmin(Integer id) {
        Map<String, String> map = new HashMap<>(4);
        boolean result = false;
        try {
            result = adminService.deleteUserById(id);
        } catch (Exception e) {
            logger.error(id == null ? "null":id .toString()+ "_"+e.getMessage(), e);
        }
        if (result) {
            map.put("code", "1000");
            map.put("msg", "用户删除成功");
            return map;
        }
        map.put("code", "1001");
        map.put("msg", "用户删除失败");
        return map;
    }

    public static void main(String[] args) {
        Map map = new HashMap(3);
        map.put("","");
    }
}
