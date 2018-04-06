package com.shop.primary.enums;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Dell on 2017/8/16.
 */
public enum DictionaryEnum {

    GROUP("字典分组"),
    INFO("字典数据");

    private String desc;

    DictionaryEnum(String desc) {
        this.desc = desc;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public static List<DictionaryEnum> getList(){
        List<DictionaryEnum> list = new ArrayList<DictionaryEnum>();
        for(DictionaryEnum demo : DictionaryEnum.values()){
            list.add(demo);
        }
        return list;
    }
}
