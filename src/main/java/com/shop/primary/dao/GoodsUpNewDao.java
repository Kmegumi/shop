package com.shop.primary.dao;

import com.shop.primary.entity.GoodsUpNew;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface GoodsUpNewDao extends JpaRepository<GoodsUpNew, Long>, JpaSpecificationExecutor {
}
