package com.shop.primary.pojo.query;

/**
 * Created by Dell on 2017/8/11.
 */
public class RoleQuery extends AdminQuery{

    private String roleValue;

    private String roleName;

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getRoleValue() {
        return roleValue;
    }

    public void setRoleValue(String roleValue) {
        this.roleValue = roleValue;
    }

    @Override
    public String toString() {
        return super.toString()+"RoleQuery{" +
                "roleValue='" + roleValue + '\'' +
                ", roleName='" + roleName + '\'' +
                '}';
    }
}
