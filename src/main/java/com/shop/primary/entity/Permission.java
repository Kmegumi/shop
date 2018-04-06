package com.shop.primary.entity;

import java.time.Instant;

public class Permission {
    private Integer id;

    private String description;

    private String permissionName;

    private String permissionSign;

    private Integer sortId;

    private Integer version;

    private Integer createUserId;

    private Integer lastUpdateUserId;

    private Instant createDatetime;

    private Instant lastUpdateDatetime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

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

    public Integer getSortId() {
        return sortId;
    }

    public void setSortId(Integer sortId) {
        this.sortId = sortId;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    public Integer getLastUpdateUserId() {
        return lastUpdateUserId;
    }

    public void setLastUpdateUserId(Integer lastUpdateUserId) {
        this.lastUpdateUserId = lastUpdateUserId;
    }

    public Instant getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Instant createDatetime) {
        this.createDatetime = createDatetime;
    }

    public Instant getLastUpdateDatetime() {
        return lastUpdateDatetime;
    }

    public void setLastUpdateDatetime(Instant lastUpdateDatetime) {
        this.lastUpdateDatetime = lastUpdateDatetime;
    }

    @Override
    public String toString() {
        return "Permission{" +
                "id=" + id +
                ", description='" + description + '\'' +
                ", permissionName='" + permissionName + '\'' +
                ", permissionSign='" + permissionSign + '\'' +
                ", sortId=" + sortId +
                ", version=" + version +
                ", createUserId=" + createUserId +
                ", lastUpdateUserId=" + lastUpdateUserId +
                ", createDatetime=" + createDatetime +
                ", lastUpdateDatetime=" + lastUpdateDatetime +
                '}';
    }
}