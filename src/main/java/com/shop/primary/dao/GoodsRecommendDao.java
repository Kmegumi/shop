package com.shop.primary.dao;

import com.shop.primary.entity.GoodsRecommend;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface GoodsRecommendDao extends JpaRepository<GoodsRecommend, Long>, JpaSpecificationExecutor {
}
