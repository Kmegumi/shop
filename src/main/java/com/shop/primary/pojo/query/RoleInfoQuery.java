package com.shop.primary.pojo.query;

/**
 * Created by Dell on 2017/8/16.
 */
public class RoleInfoQuery extends EntityQuery {


    private String roleName;

    private String roleSign;

    private String roleDescription;

    private String permissionId;

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getRoleSign() {
        return roleSign;
    }

    public void setRoleSign(String roleSign) {
        this.roleSign = roleSign;
    }

    public String getRoleDescription() {
        return roleDescription;
    }

    public void setRoleDescription(String roleDescription) {
        this.roleDescription = roleDescription;
    }

    public String getPermissionId() {
        return permissionId;
    }

    public void setPermissionId(String permissionId) {
        this.permissionId = permissionId;
    }

    @Override
    public String toString() {
        return super.toString() + "RoleInfoQuery{" +
                ", roleName='" + roleName + '\'' +
                ", roleSign='" + roleSign + '\'' +
                ", roleDescription='" + roleDescription + '\'' +
                ", permissionId='" + permissionId + '\'' +
                '}';
    }
}
