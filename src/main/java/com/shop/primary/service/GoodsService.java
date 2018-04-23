package com.shop.primary.service;

import com.shop.primary.dao.GoodsDao;
import com.shop.primary.dao.GoodsRecommendDao;
import com.shop.primary.dao.GoodsUpNewDao;
import com.shop.primary.entity.BaseEntity;
import com.shop.primary.entity.Goods;
import com.shop.primary.entity.GoodsRecommend;
import com.shop.primary.entity.GoodsUpNew;
import com.shop.primary.pojo.query.AdminQuery;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.Predicate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional(rollbackFor = Exception.class)
public class GoodsService extends BaseService<GoodsDao, Goods> {

    private static final Logger logger = LoggerFactory.getLogger(GoodsService.class);

    @Autowired
    private GoodsRecommendDao goodsRecommendDao;
    @Autowired
    private GoodsUpNewDao goodsUpNewDao;

    public Page<Goods> rowBound(AdminQuery adminQuery) {
        if (adminQuery == null) {
            return null;
        }
        try {
            Page<Goods> page = this.dao.findAll((root, query, builder) -> {
                List<Predicate> list = new ArrayList<>();
                if (adminQuery.getName() != null && !"".equals(adminQuery.getName())) {
                    list.add(builder.like(root.get("goodsName"), "%"+adminQuery.getName()+"%"));
                }
                return builder.and(list.toArray(new Predicate[list.size()]));
            }, adminQuery.getPageable());
            return page;
        }catch (Exception e) {
            logger.error(adminQuery.toString() + "_" + e.getMessage(), e);
        }
        return null;
    }

    public Goods saveOrUpdate(Goods goods) {
        if (goods == null) {
            return null;
        }
        if (goods.getId() != null) {
            Goods oldGoods = this.getById(goods.getColumnId());
            oldGoods.setColumnId(goods.getColumnId());
            oldGoods.setGoodsCode(goods.getGoodsCode());
            oldGoods.setGoodsImg(goods.getGoodsImg());
            oldGoods.setGoodsInfo(goods.getGoodsInfo());
            oldGoods.setGoodsName(goods.getGoodsName());
            oldGoods.setGoodsIntro(goods.getGoodsIntro());
            oldGoods.setGoodsPrice(goods.getGoodsPrice());
            oldGoods.setGoodsStock(goods.getGoodsStock());
            oldGoods.setLastUpdateUserId(goods.getLastUpdateUserId());
            oldGoods.setSortNum(goods.getSortNum());
            oldGoods.setStartTime(goods.getStartTime());
            oldGoods.setVersion(goods.getVersion());
            return this.update(oldGoods);
        }
        goods.setVersion(0L);
        return this.save(goods);
    }

    public List<Goods> listGoodsNotInGoodsRecommendList(Long goodsId){
        List<GoodsRecommend> list = goodsRecommendDao.findAll();
        List<Long> idList = list.parallelStream().filter(i->!i.getGoodsId().equals(goodsId)).map(BaseEntity::getId).collect(Collectors.toList());
        if(idList != null && idList.size() > 0) {
            return this.dao.findAllByIdNotIn(idList);
        } else {
            return this.dao.findAll();
        }
    }

    public List<Goods> listGoodsNotInGoodsUpNewList(Long goodsId){
        List<GoodsUpNew> list = goodsUpNewDao.findAll();
        List<Long> idList = list.parallelStream().filter(i->!i.getGoodsId().equals(goodsId)).map(BaseEntity::getId).collect(Collectors.toList());
        if(idList != null && idList.size() > 0) {
            return this.dao.findAllByIdNotIn(idList);
        } else {
            return this.dao.findAll();
        }
    }

    public List<Goods> findAllByColumnId(Long columnId){
        return this.dao.findAllByColumnId(columnId);
    }
}
