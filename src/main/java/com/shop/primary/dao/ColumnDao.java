package com.shop.primary.dao;

import com.shop.primary.entity.GoodsColumn;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ColumnDao extends JpaRepository<GoodsColumn, Long>, JpaSpecificationExecutor {
}
