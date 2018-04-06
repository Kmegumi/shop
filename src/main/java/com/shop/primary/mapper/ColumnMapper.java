package com.shop.primary.mapper;

import com.shop.primary.entity.Column;
import com.shop.primary.entity.ColumnExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ColumnMapper {
    int countByExample(ColumnExample example);

    int deleteByExample(ColumnExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Column record);

    int insertSelective(Column record);

    List<Column> selectByExample(ColumnExample example);

    Column selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Column record, @Param("example") ColumnExample example);

    int updateByExample(@Param("record") Column record, @Param("example") ColumnExample example);

    int updateByPrimaryKeySelective(Column record);

    int updateByPrimaryKey(Column record);
}