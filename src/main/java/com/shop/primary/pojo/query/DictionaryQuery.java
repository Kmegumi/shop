package com.shop.primary.pojo.query;

import com.shop.primary.enums.DictionaryEnum;

/**
 * Created by Dell on 2017/8/16.
 */
public class DictionaryQuery extends AdminQuery {

    private DictionaryEnum dictionaryEnum;

    private Integer dictionaryGroupId;

    public DictionaryEnum getDictionaryEnum() {
        return dictionaryEnum;
    }

    public void setDictionaryEnum(DictionaryEnum dictionaryEnum) {
        this.dictionaryEnum = dictionaryEnum;
    }

    public Integer getDictionaryGroupId() {
        return dictionaryGroupId;
    }

    public void setDictionaryGroupId(Integer dictionaryGroupId) {
        this.dictionaryGroupId = dictionaryGroupId;
    }

    @Override
    public String toString() {
        return super.toString() + "DictionaryQuery{" +
                "dictionaryEnum=" + dictionaryEnum +
                ", dictionaryGroupId=" + dictionaryGroupId +
                '}';
    }
}
