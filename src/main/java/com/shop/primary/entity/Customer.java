package com.shop.primary.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import java.math.BigDecimal;

@Table(name = "customer")
@Entity
public class Customer extends BaseEntity {

    private String name;

    private String mobile;

    private BigDecimal money;

    private String headImg;

    private String nickName;

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

    public BigDecimal getMoney() {
        return money;
    }

    public void setMoney(BigDecimal money) {
        this.money = money;
    }

    public String getHeadImg() {
        return headImg;
    }

    public void setHeadImg(String headImg) {
        this.headImg = headImg;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    @Override
    public String toString() {
        return "Customer{" +
                "name='" + name + '\'' +
                ", mobile='" + mobile + '\'' +
                ", money=" + money +
                ", headImg='" + headImg + '\'' +
                ", nickName='" + nickName + '\'' +
                "} " + super.toString();
    }
}
