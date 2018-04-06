package com.shop.primary.pojo.dto;

import java.util.Arrays;

/**
 * Created by Dell on 2017/8/16.
 */
public class UserRolesDTO {

    private Integer userId;

    private String[] roleIdList;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String[] getRoleIdList() {
        return roleIdList;
    }

    public void setRoleIdList(String[] roleIdList) {
        this.roleIdList = roleIdList;
    }

    @Override
    public String toString() {
        return "UserRolesDTO{" +
                "userId=" + userId +
                ", roleIdList=" + Arrays.toString(roleIdList) +
                '}';
    }
}
