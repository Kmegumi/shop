package com.shop.primary.service;

import com.shop.primary.entity.Permission;
import com.shop.primary.pojo.dto.RolePermissionDTO;
import com.shop.primary.pojo.query.PermissionInfoQuery;
import com.shop.primary.pojo.query.PermissionQuery;
import com.shop.primary.pojo.vo.RowBoundVO;

import java.util.List;


public interface PermissionService {

    List<Permission> listPermissionByRoleId(Integer roleId);

    RowBoundVO<Permission> rowBoundPermission(PermissionQuery permissionQuery);

    List<Permission> listPermissionByListPermissionId(List<Integer> listPermissionId);

    boolean saveRolePermission(RolePermissionDTO rolePermissionDTO);

    Permission getPermissionByPermissionId(Integer permissionId);

    Permission saveOrUpdatePermission(PermissionInfoQuery permissionInfoQuery);

    Permission savePermission(Permission permission);

    Permission updatePermission(Permission permission);

    boolean deletePermissionById(Integer permissionId);

    boolean deleteRolePermissionByRoleId(Integer roleId);
}
