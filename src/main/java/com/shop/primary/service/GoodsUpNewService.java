package com.shop.primary.service;

import com.shop.primary.dao.GoodsUpNewDao;
import com.shop.primary.entity.GoodsRecommend;
import com.shop.primary.entity.GoodsUpNew;
import com.shop.primary.pojo.query.AdminQuery;
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
public class GoodsUpNewService extends BaseService<GoodsUpNewDao, GoodsUpNew> {

    private static final Logger logger = LoggerFactory.getLogger(GoodsUpNewService.class);

    public Page<GoodsUpNew> rowBound(AdminQuery adminQuery) {
        if (adminQuery == null) {
            return null;
        }
        try {
            Page<GoodsUpNew> page = this.dao.findAll((root, query, builder) -> {
                List<Predicate> list = new ArrayList<>();
                if (adminQuery.getName() != null && !"".equals(adminQuery.getName())) {
                    list.add(builder.like(root.get("goods").get("goodsName"), "%"+adminQuery.getName()+"%"));
                }
                return builder.and(list.toArray(new Predicate[list.size()]));
            }, adminQuery.getPageable());
            return page;
        }catch (Exception e) {
            logger.error(adminQuery.toString() + "_" + e.getMessage(), e);
        }
        return null;
    }

    public GoodsUpNew saveOrUpdate(GoodsUpNew goodsUpNew) {
        if (goodsUpNew == null) {
            return null;
        }
        if (goodsUpNew.getId() != null) {
            GoodsUpNew oldGoodsUpNew = null;
            oldGoodsUpNew = this.dao.findOne(goodsUpNew.getId());
            if (oldGoodsUpNew == null) {
                return null;
            }
            oldGoodsUpNew.setGoodsId(goodsUpNew.getGoodsId());
            oldGoodsUpNew.setVersion(goodsUpNew.getVersion());
            return this.update(oldGoodsUpNew);
        }
        return this.save(goodsUpNew);
    }

}
