package com.shop.primary.enums;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by cc on 15/6/16.
 */
public enum StatusEnum {
    D("启用"),
    N("无效");

    private String desc;

    StatusEnum(String desc) {
        this.desc = desc;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public static List<StatusEnum> getList(){
        List<StatusEnum> list = new ArrayList<StatusEnum>();
        for(StatusEnum demo : StatusEnum.values()){
            list.add(demo);
        }
        return list;
    }
}
