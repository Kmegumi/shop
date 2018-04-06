package com.shop.primary.enums;

import java.util.ArrayList;
import java.util.List;

/**
 * 上传类型枚举
 * Created with IntelliJ IDEA.
 * User: wuyou
 * Date: 13-7-8
 * Time: 上午9:04
 * To change this template use File | Settings | File Templates.
 */
public enum UploadTypeEnum {
    TEST("TEST","测试类型","TEST/");

    private String code;
    private String description;
    private String path;          //相对路径

    public static List<UploadTypeEnum> getList(){
        List<UploadTypeEnum> demoList = new ArrayList<UploadTypeEnum>();
        for(UploadTypeEnum demo : UploadTypeEnum.values()){
            demoList.add(demo);
        }
        return demoList;
    }

    private UploadTypeEnum(String code, String description, String path) {
        this.code = code;
        this.description = description;
        this.path = path;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }
}
