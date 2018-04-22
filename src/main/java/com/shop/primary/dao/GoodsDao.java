package com.shop.primary.dao;

import com.shop.primary.entity.Goods;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GoodsDao extends JpaRepository<Goods, Long>, JpaSpecificationExecutor {

    List<Goods> findAllByIdNotIn(List<Long> list);

}
