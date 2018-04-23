package com.shop.primary.service;

import com.shop.core.exception.ServiceException;
import com.shop.primary.entity.Customer;
import com.shop.primary.entity.Order;
import com.shop.primary.enums.OrderStatusEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
public class PayService {

    @Autowired
    private OrderService orderService;
    @Autowired
    private CustomerService customerService;

    @Transactional(rollbackFor = Exception.class)
    public void payOrder(Order order, Long customerId){
        Customer customer = customerService.getById(customerId);
        if (customer == null) {
            throw new ServiceException("查询不到当前账户");
        }
        if (customer.getMoney().compareTo(order.getGoodsTotalMoney()) == -1) {
            throw new ServiceException("当前账户余额不足");
        }
        order.setOrderStatusEnum(OrderStatusEnum.SEND_WAIT);
        order.setPayTime(LocalDateTime.now());
        customer.setMoney(customer.getMoney().subtract(order.getGoodsTotalMoney()));
        orderService.update(order);
        customerService.update(customer);
    }
}
