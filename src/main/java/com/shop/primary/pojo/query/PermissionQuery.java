package com.shop.primary.pojo.query;

/**
 * Created by Dell on 2017/8/16.
 */
public class PermissionQuery extends AdminQuery {

    private String permissionValue;

    private String permissionName;

    public String getPermissionValue() {
        return permissionValue;
    }

    public void setPermissionValue(String permissionValue) {
        this.permissionValue = permissionValue;
    }

    public String getPermissionName() {
        return permissionName;
    }

    public void setPermissionName(String permissionName) {
        this.permissionName = permissionName;
    }

    @Override
    public String toString() {
        return "PermissionQuery{" +
                "permissionValue='" + permissionValue + '\'' +
                ", permissionName='" + permissionName + '\'' +
                '}';
    }
}
