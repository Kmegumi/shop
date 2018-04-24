package com.shop.primary.dao;

import com.shop.primary.entity.Collect;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CollectDao extends JpaRepository<Collect, Long>, JpaSpecificationExecutor {

    Collect findByCustomerIdAndGoodsId(Long customerId, Long goodsId);

    List<Collect> findByCustomerId(Long customerId);
}
