package com.shop.primary.service;

import com.shop.primary.dao.GoodsRecommendDao;
import com.shop.primary.entity.GoodsRecommend;
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
public class GoodsRecommendService extends BaseService<GoodsRecommendDao, GoodsRecommend> {

    private static final Logger logger = LoggerFactory.getLogger(GoodsRecommendService.class);

    public Page<GoodsRecommend> rowBound(AdminQuery adminQuery) {
        if (adminQuery == null) {
            return null;
        }
        try {
            Page<GoodsRecommend> page = this.dao.findAll((root, query, builder) -> {
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

    @Transactional(rollbackFor = Exception.class)
    public GoodsRecommend saveOrUpdate(GoodsRecommend goodsRecommend) {
        if (goodsRecommend == null) {
            return null;
        }
        if (goodsRecommend.getId() != null) {
            GoodsRecommend oldGoodsRecommend = null;
            oldGoodsRecommend = this.dao.findOne(goodsRecommend.getId());
            if (oldGoodsRecommend == null) {
                return null;
            }
            oldGoodsRecommend.setGoodsId(goodsRecommend.getGoodsId());
            oldGoodsRecommend.setVersion(goodsRecommend.getVersion());
            return this.update(oldGoodsRecommend);
        }
        return this.save(goodsRecommend);
    }

}
