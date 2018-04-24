package com.shop.primary.service;

import com.shop.core.exception.ServiceException;
import com.shop.primary.dao.GoodsDao;
import com.shop.primary.dao.OrderDao;
import com.shop.primary.entity.Order;
import com.shop.primary.enums.OrderStatusEnum;
import com.shop.primary.pojo.query.AdminQuery;
import com.shop.primary.pojo.query.OrderQuery;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.Predicate;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional(rollbackFor = Exception.class)
public class OrderService extends BaseService<OrderDao, Order> {

    private static final Logger logger = LoggerFactory.getLogger(OrderService.class);

    @Autowired
    private GoodsDao goodsDao;

    public Page<Order> rowBound(OrderQuery orderQuery) {
        if (orderQuery == null) {
            return null;
        }
        try {
            Page<Order> page = this.dao.findAll((root, query, builder) -> {
                List<Predicate> list = new ArrayList<>();
                if (orderQuery.getName() != null && !"".equals(orderQuery.getName())) {
                    list.add(builder.like(root.get("goods").get("goodsName"), "%"+orderQuery.getName()+"%"));
                    list.add(builder.like(root.get("customer").get("name"), "%"+orderQuery.getName()+"%"));
                    list.add(builder.like(root.get("orderNum"), "%"+orderQuery.getName()+"%"));
                    list.add(builder.like(root.get("shippingDetail"), "%"+orderQuery.getName()+"%"));
                }
                if (list.size() > 0) {
                    return builder.or(list.toArray(new Predicate[list.size()]));
                }
                return builder.and(list.toArray(new Predicate[list.size()]));
            }, orderQuery.getPageable());
            return page;
        }catch (Exception e) {
            logger.error(orderQuery.toString() + "_" + e.getMessage(), e);
        }
        return null;
    }

    @Transactional(rollbackFor = Exception.class)
    public Order createOrder(Order order){
        order = this.save(order);
        Integer count = goodsDao.buckleStrock(order.getGoodsNum(), order.getGoodsId());
        if (count != 1) {
            throw new ServiceException("下单失败请检查库存");
        }
        return order;
    }

    public Order findByOrderNum(String orderNum){
        return this.dao.findByOrderNum(orderNum);
    }

    public List<Order> findByOrderStatusAndCustomerId(OrderStatusEnum orderStatus, Long customerId) {
        if (orderStatus == null) {
            return this.dao.findByCustomerId(customerId);
        }
        return this.dao.findByOrderStatusEnumAndCustomerId(orderStatus, customerId);
    }
}
