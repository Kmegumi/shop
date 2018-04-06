package com.shop.primary.pojo.query;

import com.shop.primary.entity.User;
import com.shop.primary.enums.StatusEnum;
import com.shop.primary.pojo.BaseQuery;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * Created by Dell on 2017/7/28.
 */
public class AdminQuery extends BaseQuery {

    private Integer id;

    private User user;

    private StatusEnum statusEnum;

    public AdminQuery() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(@PathVariable Integer id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public StatusEnum getStatusEnum() {
        return statusEnum;
    }

    public void setStatusEnum(StatusEnum statusEnum) {
        this.statusEnum = statusEnum;
    }

    @Override
    public String toString() {
        return super.toString() + "AdminQuery{" +
                "id=" + id +
                ", user=" + user +
                ", statusEnum=" + statusEnum +
                '}';
    }
}
