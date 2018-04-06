package com.shop.core.utils;

import com.shop.core.exception.ServiceException;
import com.shop.primary.pojo.query.EntityQuery;


public class CommonUtils {

    private CommonUtils(){

    }

    public static void checkEntityQuery(EntityQuery entityQuery) {
        if (entityQuery == null) {
            throw new ServiceException("参数为空");
        }

        if (entityQuery.getId() != null && entityQuery.getId().intValue() < 1) {
            throw new ServiceException("Id不合法");
        }

        if (entityQuery.getId() != null && entityQuery.getVersion() == null) {
            throw new ServiceException("缺少版本参数");
        }
    }

    public static String textBeLike(String text){
        return new StringBuilder("%").append(text).append("%").toString();
    }

}
