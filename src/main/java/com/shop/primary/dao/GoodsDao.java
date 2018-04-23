package com.shop.primary.dao;

import com.shop.primary.entity.Goods;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GoodsDao extends JpaRepository<Goods, Long>, JpaSpecificationExecutor {

    List<Goods> findAllByIdNotIn(List<Long> list);

    List<Goods> findAllByColumnId(Long columnId);

    @Query(value = "update goods set goods_stock = goods_stock - ?1, last_update_time = now(), version = version + 1 where id = ?2 and goods_stock > (?1 - 1)", nativeQuery = true)
    @Modifying
    Integer buckleStrock(Integer num, Long goodsId);
}
