package com.shop.primary.service;

import com.shop.primary.dao.BannerDao;
import com.shop.primary.entity.Banner;
import com.shop.primary.entity.GoodsColumn;
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
public class BannerService extends BaseService<BannerDao, Banner> {

    private static final Logger logger = LoggerFactory.getLogger(BannerService.class);

    public Page<Banner> rowBound(AdminQuery adminQuery) {
        if (adminQuery == null) {
            return null;
        }
        try {
            Page<Banner> page = this.dao.findAll((root, query, builder) -> {
                List<Predicate> list = new ArrayList<>();
                if (adminQuery.getName() != null && !"".equals(adminQuery.getName())) {
                    list.add(builder.like(root.get("name"), "%"+adminQuery.getName()+"%"));
                }
                return builder.and(list.toArray(new Predicate[list.size()]));
            }, adminQuery.getPageable());
            return page;
        }catch (Exception e) {
            logger.error(adminQuery.toString() + "_" + e.getMessage(), e);
        }
        return null;
    }

    public Banner saveOrUpdate(Banner banner) {
        if (banner == null) {
            return null;
        }
        if (banner.getId() != null) {
            Banner oldBanner = this.getById(banner.getId());
            oldBanner.setName(banner.getName());
            oldBanner.setUrl(banner.getUrl());
            oldBanner.setVersion(banner.getVersion());
            return this.update(oldBanner);
        }
        banner.setVersion(0L);
        return this.save(banner);
    }
}
