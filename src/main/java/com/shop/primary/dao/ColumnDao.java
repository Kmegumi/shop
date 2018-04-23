package com.shop.primary.dao;

import com.shop.primary.entity.GoodsColumn;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ColumnDao extends JpaRepository<GoodsColumn, Long>, JpaSpecificationExecutor {

    @Query(value = "select * from goods_column a limit 4", nativeQuery = true)
    List<GoodsColumn> findListForIndex();
}
