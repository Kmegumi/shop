package com.shop.primary.enums;

import java.util.ArrayList;
import java.util.List;

/**
 * 常用状态
 *
 * @author yuweilun
 * @date 2017/5/8
 */
public enum StatusEnum {
    D("启用"),
    N("无效");

    private String description;

    public static final List<StatusEnum> LIST = init();

    StatusEnum(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    private static List<StatusEnum> init() {
        List<StatusEnum> list = new ArrayList<>();
        for(StatusEnum demo : StatusEnum.values()){
            list.add(demo);
        }
        return list;
    }


}
