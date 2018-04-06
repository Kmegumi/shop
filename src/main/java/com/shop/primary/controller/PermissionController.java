package com.shop.primary.controller;

import com.shop.core.common.AdminCoreController;
import com.shop.core.exception.ServiceException;
import com.shop.core.utils.NumUtil;
import com.shop.primary.entity.Permission;
import com.shop.primary.entity.Role;
import com.shop.primary.pojo.query.AdminQuery;
import com.shop.primary.pojo.query.PermissionInfoQuery;
import com.shop.primary.pojo.query.PermissionQuery;
import com.shop.primary.pojo.vo.RowBoundVO;
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
 * 后台权限管理控制器
 *
 * @author yuweilun
 * @date 2017/8/16
 */
@Controller
@RequestMapping("/permission")
public class PermissionController extends AdminCoreController {

    private static final Logger logger = LoggerFactory.getLogger(PermissionController.class);

    @Resource
    private PermissionService permissionService;

    @Resource
    private RoleService roleService;

    @RequestMapping(value = "list")
    @RequiresPermissions("permission:list")
    public String permissionList(PermissionQuery permissionQuery, ModelMap modelMap) {
        RowBoundVO<Permission> rowBoundVO = permissionService.rowBoundPermission(permissionQuery);
        modelMap.addAttribute("dome", rowBoundVO);
        modelMap.addAttribute("form", permissionQuery);
        return "/permission/list";
    }

    @RequestMapping(value = "add", method = RequestMethod.GET)
    @RequiresPermissions("permission:add")
    public String permissionAdd(){
        return "/permission/edit";
    }

    @RequestMapping(value = "edit/{id}", method = RequestMethod.GET)
    @RequiresPermissions("permission:edit")
    public String permissionEdit(AdminQuery adminQuery, ModelMap modelMap) {
        Permission permission = permissionService.getPermissionByPermissionId(adminQuery.getId());
        modelMap.addAttribute("permission", permission);
        return "/permission/edit";
    }

    @RequestMapping(value = "saveOrUpdatePermission", method = RequestMethod.POST)
    @RequiresPermissions("admin:saveOrUpdatePermission")
    @ResponseBody
    public Map<String, String> saveOrUpdatePermission(PermissionInfoQuery permissionInfoQuery) {
        Map<String, String> map = new HashMap<>(4);
        Permission permission = null;
        try {
            permission = permissionService.saveOrUpdatePermission(permissionInfoQuery);
        } catch (ServiceException e) {
            map.put("code", "1002");
            map.put("msg", e.getMessage());
            return map;
        } catch (Exception e) {
            logger.error(permissionInfoQuery.toString()+"_"+e.getMessage(), e);
        }
        if (permission == null) {
            map.put("code", "1002");
            if (permissionInfoQuery.getId() != null) {
                map.put("msg", "权限信息修改失败");
                return map;
            }
            map.put("msg", "权限信息保存失败");
            return map;
        }

        if (permissionInfoQuery.getId() != null) {
            map.put("code", "1001");
            map.put("msg", "权限信息修改成功");
            return map;
        }
        map.put("code", "1000");
        map.put("msg", "权限信息添加成功");
        return map;
    }

    @RequestMapping(value = "deletePermission", method = RequestMethod.POST)
    @RequiresPermissions("admin:deletePermission")
    @ResponseBody
    public Map<String, String> deletePermission(Integer id) {
        Map<String, String> map = new HashMap<>(4);
        map.put("code", "1001");
        boolean result = false;
        List<Role> list = roleService.listRoleByPermissionId(id);
        if (list != null) {
            if (list.size() == 0) {
                try {
                    result = permissionService.deletePermissionById(id);
                } catch (Exception e) {
                    logger.error(id + "_" + e.getMessage(), e);
                }
                if (result) {
                    map.put("code", "1000");
                    map.put("msg", "权限删除成功");
                    return map;
                }
            }
            String[] roleNameArr = new String[list.size()];
            for (int i = 0; i < list.size(); i++) {
                Role role = list.get(i);
                roleNameArr[i] = role.getRoleName();
            }
            map.put("msg", "角色：[" + String.join(",", roleNameArr) + "]拥有该权限，无法删除");
            return map;
        }
        map.put("msg", "权限删除失败");
        return map;
    }

    @RequestMapping("permissionCheck")
    @RequiresPermissions("admin:permission")
    public String roleCheck(PermissionQuery permissionQuery, ModelMap modelMap) {
        RowBoundVO<Permission> rowBoundVO = permissionService.rowBoundPermission(permissionQuery);
        List<Integer> permissionList = NumUtil.stringToArr(permissionQuery.getPermissionValue());
        List<Permission> list = permissionService.listPermissionByListPermissionId(permissionList);

        if (list != null && list.size() > 0) {
            String[] permissionNameArr = new String[list.size()];
            for (int i = 0; i < list.size(); i++) {
                Permission permission = list.get(i);
                permissionNameArr[i] = permission.getPermissionName();
            }
            permissionQuery.setPermissionName(String.join(",", permissionNameArr));
        }
        modelMap.addAttribute("dome", rowBoundVO);
        modelMap.addAttribute("form", permissionQuery);
        return "/permission/permissionCheckList";
    }


}
