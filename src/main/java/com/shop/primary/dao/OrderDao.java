package com.shop.primary.dao;

import com.shop.primary.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderDao extends JpaRepository<Order, Long>, JpaSpecificationExecutor {
}
