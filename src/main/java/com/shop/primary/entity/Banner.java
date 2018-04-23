package com.shop.primary.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Table(name = "banner")
@Entity
public class Banner extends BaseEntity{

    @Column(name = "name")
    private String name;

    @Column(name = "url")
    private String url;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Override
    public String toString() {
        return "Banner{" +
                "name='" + name + '\'' +
                ", url='" + url + '\'' +
                "} " + super.toString();
    }
}
