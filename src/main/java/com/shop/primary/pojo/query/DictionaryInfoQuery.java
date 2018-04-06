package com.shop.primary.pojo.query;

/**
 * Created by Dell on 2017/8/17.
 */
public class DictionaryInfoQuery extends EntityQuery {

    private String code;
    private String name;
    private String shortName;
    private Integer groupId;
    private Integer sortCode;
    private String description;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
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

    public Integer getGroupId() {
        return groupId;
    }

    public void setGroupId(Integer groupId) {
        this.groupId = groupId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return super.toString() + "DictionaryInfoQuery{" +
                "code='" + code + '\'' +
                ", name='" + name + '\'' +
                ", shortName='" + shortName + '\'' +
                ", groupId=" + groupId +
                ", sortCode=" + sortCode +
                ", description='" + description + '\'' +
                '}';
    }
}
