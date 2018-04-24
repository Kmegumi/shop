package com.shop.primary.dao;

import com.shop.primary.entity.Order;
import com.shop.primary.enums.OrderStatusEnum;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderDao extends JpaRepository<Order, Long>, JpaSpecificationExecutor {

    Order findByOrderNum(String orderNum);

    List<Order> findByOrderStatusEnumAndCustomerId(OrderStatusEnum orderStatus, Long customerId);

    List<Order> findByCustomerId(Long customerId);
}
