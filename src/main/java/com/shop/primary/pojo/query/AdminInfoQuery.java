package com.shop.primary.pojo.query;

import com.shop.primary.enums.StatusEnum;

/**
 * Created by Dell on 2017/8/15.
 */
public class AdminInfoQuery extends EntityQuery {

    private String username;

    private String password;

    private String name;

    private String mobile;

    private String email;

    private String roleId;

    private StatusEnum status;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public StatusEnum getStatus() {
        return status;
    }

    public void setStatus(StatusEnum status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return super.toString() + "AdminInfoQuery{" +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", name='" + name + '\'' +
                ", mobile='" + mobile + '\'' +
                ", email='" + email + '\'' +
                ", roleId='" + roleId + '\'' +
                ", status=" + status +
                '}';
    }
}
