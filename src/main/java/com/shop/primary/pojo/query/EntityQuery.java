package com.shop.primary.pojo.query;

import com.shop.primary.entity.User;

/**
 * Created by Dell on 2017/8/16.
 */
public class EntityQuery {
    private Integer id;

    private User user;

    private Integer version;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    @Override
    public String toString() {
        return "EntityQuery{" +
                "id=" + id +
                ", user=" + user +
                ", version=" + version +
                '}';
    }
}
