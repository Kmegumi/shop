package com.shop.primary.pojo.query;

/**
 * Created by Dell on 2017/8/17.
 */
public class DictionaryGroupInfoQuery extends EntityQuery {

    private String name;
    private String code;
    private Integer sortCode;
    private String groupDescription;

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

    public String getGroupDescription() {
        return groupDescription;
    }

    public void setGroupDescription(String groupDescription) {
        this.groupDescription = groupDescription;
    }

    @Override
    public String toString() {
        return super.toString() + "DictionaryGroupInfoQuery{" +
                "name='" + name + '\'' +
                ", code='" + code + '\'' +
                ", sortCode=" + sortCode +
                ", groupDescription='" + groupDescription + '\'' +
                '}';
    }
}
