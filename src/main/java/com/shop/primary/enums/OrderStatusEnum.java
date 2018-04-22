package com.shop.primary.enums;

import java.util.ArrayList;
import java.util.List;

public enum OrderStatusEnum {
    PAY_WAIT("待付款"),
    SEND_WAIT("待发货"),
    CLOSE("交易关闭"),
    OK("完成");

    private String description;

    public static final List<StatusEnum> LIST = init();

    OrderStatusEnum(String description) {
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
