package com.shop.primary.service;

import com.shop.primary.dao.CollectDao;
import com.shop.primary.entity.Collect;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(rollbackFor = Exception.class)
public class CollectService extends BaseService<CollectDao, Collect> {

    public Collect findByCustomerIdAndGoodsId(Long customerId, Long goodsId){
        return this.dao.findByCustomerIdAndGoodsId(customerId, goodsId);
    }

    public List<Collect> findAllByCustomerId(Long customerId) {
        return this.dao.findByCustomerId(customerId);
    }
}
