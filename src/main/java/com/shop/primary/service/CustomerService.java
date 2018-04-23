package com.shop.primary.service;

import com.shop.primary.dao.CustomerDao;
import com.shop.primary.dao.OrderDao;
import com.shop.primary.entity.Customer;
import com.shop.primary.entity.Order;
import com.shop.primary.pojo.query.AdminQuery;
import com.shop.primary.pojo.query.OrderQuery;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.Predicate;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional(rollbackFor = Exception.class)
public class CustomerService extends BaseService<CustomerDao, Customer> {

    private static final Logger logger = LoggerFactory.getLogger(CustomerService.class);

    public Page<Customer> rowBound(AdminQuery adminQuery) {
        if (adminQuery == null) {
            return null;
        }
        try {
            Page<Customer> page = this.dao.findAll((root, query, builder) -> {
                List<Predicate> list = new ArrayList<>();
                if (adminQuery.getName() != null && !"".equals(adminQuery.getName())) {
                    list.add(builder.like(root.get("name").get("goodsName"), "%"+adminQuery.getName()+"%"));
                    list.add(builder.like(root.get("mobile").get("name"), "%"+adminQuery.getName()+"%"));
                    list.add(builder.like(root.get("nickName"), "%"+adminQuery.getName()+"%"));
                }
                return builder.or(list.toArray(new Predicate[list.size()]));
            }, adminQuery.getPageable());
            return page;
        }catch (Exception e) {
            logger.error(adminQuery.toString() + "_" + e.getMessage(), e);
        }
        return null;
    }

    public Customer getCustomerByTel(String tel) {
        return this.dao.findByMobile(tel);
    }

}
