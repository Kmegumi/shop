package com.shop.primary.pojo.vo;

/**
 * Created by Dell on 2017/8/17.
 */
public class DictionaryVO {

    private Integer id;

    private String code;

    private String name;

    private Integer sortCode;

    private String shortName;

    private String groupName;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getSortCode() {
        return sortCode;
    }

    public void setSortCode(Integer sortCode) {
        this.sortCode = sortCode;
    }

    public String getShortName() {
        return shortName;
    }

    public void setShortName(String shortName) {
        this.shortName = shortName;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    @Override
    public String toString() {
        return "DictionaryVO{" +
                "id=" + id +
                ", code='" + code + '\'' +
                ", name='" + name + '\'' +
                ", sortCode=" + sortCode +
                ", shortName='" + shortName + '\'' +
                ", groupName='" + groupName + '\'' +
                '}';
    }
}
