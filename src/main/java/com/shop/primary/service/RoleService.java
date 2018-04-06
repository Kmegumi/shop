package com.shop.primary.service;

import com.shop.primary.entity.Permission;
import com.shop.primary.entity.Role;
import com.shop.primary.pojo.dto.UserRolesDTO;
import com.shop.primary.pojo.query.RoleInfoQuery;
import com.shop.primary.pojo.query.RoleQuery;
import com.shop.primary.pojo.vo.RowBoundVO;

import java.util.List;


public interface RoleService {

    RowBoundVO<Role> rowBoundRole(RoleQuery roleQuery);

    List<Role> listRoleByUserId(Integer id);

    List<Role> listRoleByListRoleId(List<Integer> list);

    boolean saveUserRoles(UserRolesDTO userRolesDTO);

    Role getRoleByRoleId(Integer roleId);

    List<Permission> listPermissionByRole(Role role);

    Role saveOrUpdateRole(RoleInfoQuery roleInfoQuery);

    Role saveRole(Role role);

    Role updateRole(Role role);

    boolean deleteRoleById(Integer roleId);

    List<Role> listRoleByPermissionId(Integer permissionId);

    boolean deleteUserRolesByUserId(Integer userId);

}
