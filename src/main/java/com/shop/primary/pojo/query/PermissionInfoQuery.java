package com.shop.primary.pojo.query;

/**
 * Created by Dell on 2017/8/16.
 */
public class PermissionInfoQuery extends EntityQuery {

    private String permissionName;

    private String permissionSign;

    private String permissionDescription;

    public String getPermissionName() {
        return permissionName;
    }

    public void setPermissionName(String permissionName) {
        this.permissionName = permissionName;
    }

    public String getPermissionSign() {
        return permissionSign;
    }

    public void setPermissionSign(String permissionSign) {
        this.permissionSign = permissionSign;
    }

    public String getPermissionDescription() {
        return permissionDescription;
    }

    public void setPermissionDescription(String permissionDescription) {
        this.permissionDescription = permissionDescription;
    }

    @Override
    public String toString() {
        return super.toString() + "PermissionInfoQuery{" +
                "permissionName='" + permissionName + '\'' +
                ", permissionSign='" + permissionSign + '\'' +
                ", permissionDescription='" + permissionDescription + '\'' +
                '}';
    }
}
