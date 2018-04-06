package com.shop.core.utils;

import com.shop.primary.pojo.BaseQuery;
import com.shop.primary.pojo.vo.RowBoundVO;


public class PageUtils {

    private PageUtils() {

    }

    public static RowBoundVO getRowBoundVO(BaseQuery baseQuery, int count) {
        int firstResult = baseQuery.getFirstResult();
        if (firstResult + 1 > count) {
            return null;
        }
        int pageTotalNum = (count + baseQuery.getPageSize().intValue() - 1) / baseQuery.getPageSize();
        return new RowBoundVO(baseQuery.getPageNo(), baseQuery.getPageSize(), firstResult, count, pageTotalNum);
    }


}
