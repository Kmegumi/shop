package com.shop.primary.pojo.dto;

import java.util.Arrays;

/**
 * Created by Dell on 2017/8/16.
 */
public class RolePermissionDTO {

    private Integer roleId;

    private String[] permissionList;

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String[] getPermissionList() {
        return permissionList;
    }

    public void setPermissionList(String[] permissionList) {
        this.permissionList = permissionList;
    }

    @Override
    public String toString() {
        return "RolePermissionDTO{" +
                "roleId=" + roleId +
                ", permissionList=" + Arrays.toString(permissionList) +
                '}';
    }
}
