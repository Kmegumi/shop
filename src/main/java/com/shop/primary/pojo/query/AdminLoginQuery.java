package com.shop.primary.pojo.query;

/**
 * Created by Dell on 2017/7/28.
 */
public class AdminLoginQuery {

    private String username;

    private String password;

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

    @Override
    public String toString() {
        return new StringBuilder("AdminLoginQuery{")
                .append("username='").append(username).append("'")
                .append(", password='").append(password)
                .append("'}").toString();
    }
}
