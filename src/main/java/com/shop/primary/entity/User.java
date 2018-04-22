package com.shop.primary.entity;

import com.shop.primary.enums.StatusEnum;

import javax.persistence.*;
import javax.persistence.Column;

@Entity
@Table(name = "user")
public class User extends BaseEntity {

    @Column(name = "username")
    private String username;

    @Column(name = "password")
    private String password;

    @Column(name = "mobile")
    private String mobile;

    @Column(name = "name")
    private String name;

    @Column(name = "email")
    private String email;

    @Column(name = "status")
    @Enumerated(EnumType.STRING)
    private StatusEnum status;

    @Column(name = "sort_id")
    private Integer sortId;

    @Column(name = "create_user_id")
    private Long createUserId;

    @Column(name = "last_update_user_id")
    private Long lastUpdateUserId;

    @ManyToOne(targetEntity=User.class ,fetch = FetchType.LAZY)
    @JoinColumn(name="create_user_id", updatable=false, insertable=false)
    private User createUser;

    @ManyToOne(targetEntity=User.class,cascade= CascadeType.REFRESH,fetch = FetchType.LAZY)
    @JoinColumn(name="last_update_user_id", updatable = false, insertable = false)
    private User lastUpdateUser;

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

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public StatusEnum getStatus() {
        return status;
    }

    public void setStatus(StatusEnum status) {
        this.status = status;
    }

    public Integer getSortId() {
        return sortId;
    }

    public void setSortId(Integer sortId) {
        this.sortId = sortId;
    }

    public Long getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Long createUserId) {
        this.createUserId = createUserId;
    }

    public Long getLastUpdateUserId() {
        return lastUpdateUserId;
    }

    public void setLastUpdateUserId(Long lastUpdateUserId) {
        this.lastUpdateUserId = lastUpdateUserId;
    }

    public User getCreateUser() {
        return createUser;
    }

    public void setCreateUser(User createUser) {
        this.createUser = createUser;
    }

    public User getLastUpdateUser() {
        return lastUpdateUser;
    }

    public void setLastUpdateUser(User lastUpdateUser) {
        this.lastUpdateUser = lastUpdateUser;
    }

    @Override
    public String toString() {
        return "User{" +
                "username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", mobile='" + mobile + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", status=" + status +
                ", sortId=" + sortId +
                ", createUserId=" + createUserId +
                ", lastUpdateUserId=" + lastUpdateUserId +
                "} " + super.toString();
    }
}