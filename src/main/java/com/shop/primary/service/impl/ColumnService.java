package com.shop.primary.service.impl;

import com.shop.primary.entity.Column;
import com.shop.primary.mapper.ColumnMapper;
import com.shop.primary.mapper.GoodsMapper;
import com.shop.primary.service.GoodsService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class ColumnService {

    private static final Logger logger = LoggerFactory.getLogger(GoodsService.class);

    @Resource
    private ColumnMapper columnMapper;

    public Column save(Column column){
        int count = 0;
        try {
            count = columnMapper.insert(column);
        } catch (Exception e) {
            logger.error(e.getMessage()+column.toString(), e);
            throw new RuntimeException("cha ru shibai ");
        }
        if (count == 0) {
            return null;
        }
        else if (count == 1) {
            return column;
        }
        else if (count > 1) {
            throw new RuntimeException("sql zhurule ");
        }
        else {
            return null;
        }
    }
}
