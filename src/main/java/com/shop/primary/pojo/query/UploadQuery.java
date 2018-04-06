package com.shop.primary.pojo.query;

import com.shop.primary.enums.UploadTypeEnum;

/**
 * Created by Dell on 2017/9/16.
 */
public class UploadQuery extends AdminQuery {

    private UploadTypeEnum uploadTypeEnum;

    public UploadTypeEnum getUploadTypeEnum() {
        return uploadTypeEnum;
    }

    public void setUploadTypeEnum(UploadTypeEnum uploadTypeEnum) {
        this.uploadTypeEnum = uploadTypeEnum;
    }

    @Override
    public String toString() {
        return super.toString() + "UplodeQuery{" +
                "uploadTypeEnum=" + uploadTypeEnum +
                '}';
    }
}
