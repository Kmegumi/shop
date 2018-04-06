package com.shop.primary.controller;

import com.shop.core.common.AdminCoreController;
import com.shop.core.exception.ServiceException;
import com.shop.core.utils.NumUtil;
import com.shop.primary.entity.Permission;
import com.shop.primary.entity.Role;
import com.shop.primary.entity.User;
import com.shop.primary.pojo.dto.RolePermissionDTO;
import com.shop.primary.pojo.query.AdminQuery;
import com.shop.primary.pojo.query.RoleInfoQuery;
import com.shop.primary.pojo.query.RoleQuery;
import com.shop.primary.pojo.vo.RowBoundVO;
import com.shop.primary.service.AdminService;
import com.shop.primary.service.PermissionService;
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
 * 后台角色管理控制器
 *
 * @author yuweilun
 * @date 2017/8/16
 */
@Controller
@RequestMapping("/role")
public class RoleController extends AdminCoreController {

    private static final Logger logger = LoggerFactory.getLogger(RoleController.class);

    @Resource
    private RoleService roleService;

    @Resource
    private PermissionService permissionService;

    @Resource
    private AdminService adminService;


    @RequestMapping(value = "list")
    @RequiresPermissions("role:list")
    public String roleList(RoleQuery roleQuery, ModelMap modelMap) {
        RowBoundVO<Role> rowBoundVO = roleService.rowBoundRole(roleQuery);
        modelMap.addAttribute("dome", rowBoundVO);
        modelMap.addAttribute("form", roleQuery);
        return "/role/list";
    }

    @RequestMapping(value = "add", method = RequestMethod.GET)
    @RequiresPermissions("role:add")
    public String roleAdd(){
        return "/role/edit";
    }

    @RequestMapping(value = "edit/{id}", method = RequestMethod.GET)
    @RequiresPermissions("role:edit")
    public String roleEdit(AdminQuery adminQuery, ModelMap modelMap) {
        Role role = roleService.getRoleByRoleId(adminQuery.getId());
        List<Permission> list = roleService.listPermissionByRole(role);

        if (list != null && list.size() > 0) {
            String[] permissionIdArr = new String[list.size()];
            String[] permissionNameArr = new String[list.size()];
            for(int i = 0; i < list.size(); i++) {
                Permission permission = list.get(i);
                permissionIdArr[i] = String.valueOf(permission.getId());
                permissionNameArr[i] = permission.getPermissionName();
            }
            modelMap.addAttribute("permissionId", String.join(",", permissionIdArr));
            modelMap.addAttribute("permissionName", String.join(",", permissionNameArr));
        }
        modelMap.addAttribute("role", role);
        return "/role/edit";
    }

    @RequestMapping(value = "saveOrUpdateRole", method = RequestMethod.POST)
    @RequiresPermissions("admin:saveOrUpdateRole")
    @ResponseBody
    public Map<String, String> saveOrUpdateRole(RoleInfoQuery roleInfoQuery) {
        Map<String, String> map = new HashMap<>(4);
        Role role = null;
        try {
            role = roleService.saveOrUpdateRole(roleInfoQuery);
        } catch (ServiceException e) {
            map.put("code", "1002");
            map.put("msg", e.getMessage());
            return map;
        } catch (Exception e) {
            logger.error(roleInfoQuery.toString()+"_"+e.getMessage(), e);
        }
        if (role == null) {
            map.put("code", "1002");
            if (roleInfoQuery.getId() != null) {
                map.put("msg", "角色信息修改失败");
                return map;
            }
            map.put("msg", "角色信息保存失败");
            return map;
        }

        if (roleInfoQuery.getId() != null) {
            map.put("code", "1001");
            map.put("msg", "角色信息修改成功，权限信息保存失败");
        } else {
            map.put("code", "1000");
            map.put("msg", "角色信息添加成功，权限信息保存失败");
        }

        if (roleInfoQuery.getPermissionId() == null) {
            return map;
        }

        RolePermissionDTO rolePermissionDTO = new RolePermissionDTO();
        rolePermissionDTO.setRoleId(role.getId());
        rolePermissionDTO.setPermissionList(roleInfoQuery.getPermissionId().split(","));
        boolean result = false;
        try {
            result = permissionService.saveRolePermission(rolePermissionDTO);
        } catch (Exception e) {
            logger.error(rolePermissionDTO.toString()+"_"+e.getMessage(),e);
        }
        if (result) {
            if (roleInfoQuery.getId() != null) {
                map.put("msg", "角色信息修改成功");
                return map;
            }
            map.put("msg", "角色信息添加成功");
            return map;
        }
        return map;
    }

    @RequestMapping(value = "deleteRole", method = RequestMethod.POST)
    @RequiresPermissions("admin:deleteRole")
    @ResponseBody
    public Map<String, String> deleteRole(Integer id) {
        Map<String, String> map = new HashMap<>(4);
        map.put("code", "1001");
        boolean result = false;
        List<User> list = adminService.listUserByRoleId(id);
        if (list != null) {
            if (list.size() == 0) {
                try {
                    result = roleService.deleteRoleById(id);
                } catch (Exception e) {
                    logger.error(id + "_" + e.getMessage(), e);
                }
                if (result) {
                    map.put("code", "1000");
                    map.put("msg", "角色删除成功");
                    return map;
                }
            }
            String[] userNameArr = new String[list.size()];
            for (int i = 0; i < list.size(); i++) {
                User user = list.get(i);
                userNameArr[i] = user.getUsername();
            }
            map.put("msg", "用户：[" + String.join(",", userNameArr) + "]拥有该角色，无法删除");
            return map;
        }
        map.put("msg", "角色删除失败");
        return map;
    }

    @RequestMapping("roleCheck")
    @RequiresPermissions("admin:role")
    public String roleCheck(RoleQuery roleQuery, ModelMap modelMap) {
        RowBoundVO<Role> rowBoundVO = roleService.rowBoundRole(roleQuery);
        List<Integer> roleList = NumUtil.stringToArr(roleQuery.getRoleValue());

        List<Role> list = roleService.listRoleByListRoleId(roleList);
        if (list != null && list.size() > 0) {
            String[] roleNameArr = new String[list.size()];
            for (int i = 0; i < list.size(); i++) {
                Role role = list.get(i);
                roleNameArr[i] = role.getRoleName();
            }
            roleQuery.setRoleName(String.join(",", roleNameArr));
        }
        modelMap.addAttribute("dome", rowBoundVO);
        modelMap.addAttribute("form", roleQuery);
        return "/role/roleCheckList";
    }
}
