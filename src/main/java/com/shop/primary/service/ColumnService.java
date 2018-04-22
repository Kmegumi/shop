package com.shop.primary.service;

import com.shop.primary.dao.ColumnDao;
import com.shop.primary.entity.GoodsColumn;
import com.shop.primary.pojo.query.AdminQuery;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.Predicate;
import java.util.ArrayList;
import java.util.List;

@Service
public class ColumnService extends BaseService<ColumnDao, GoodsColumn> {

    private static final Logger logger = LoggerFactory.getLogger(GoodsService.class);

    public Page<GoodsColumn> rowBound(AdminQuery adminQuery) {
        if (adminQuery == null) {
            return null;
        }
        try {
            Page<GoodsColumn> page = this.dao.findAll((root, query, builder) -> {
                List<Predicate> list = new ArrayList<>();
                if (adminQuery.getName() != null && !"".equals(adminQuery.getName())) {
                    list.add(builder.like(root.get("columnName"), "%"+adminQuery.getName()+"%"));
                }
                return builder.and(list.toArray(new Predicate[list.size()]));
            }, adminQuery.getPageable());
            return page;
        }catch (Exception e) {
            logger.error(adminQuery.toString() + "_" + e.getMessage(), e);
        }
        return null;
    }

    public GoodsColumn saveOrUpdate(GoodsColumn goodsColumn) {
        if (goodsColumn == null) {
            return null;
        }
        if (goodsColumn.getId() != null) {
            GoodsColumn oldGoodsColumn = this.getById(goodsColumn.getId());
            oldGoodsColumn.setColumnName(goodsColumn.getColumnName());
            oldGoodsColumn.setVersion(goodsColumn.getVersion());
            return this.update(oldGoodsColumn);
        }
        goodsColumn.setVersion(0L);
        return this.save(goodsColumn);
    }
}
