package com.shop.primary.service;

import com.shop.primary.entity.Goods;
import com.shop.primary.entity.User;
import com.shop.primary.mapper.GoodsMapper;
import com.shop.primary.mapper.UserMapper;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;

@Service
public class GoodsService {
    private static final Logger logger = LoggerFactory.getLogger(GoodsService.class);

    @Resource
    private GoodsMapper goodsMapper;

    @Transactional
    public Goods save(Goods goods){
        Subject subject = SecurityUtils.getSubject();
        User user = (User) subject.getPrincipal();
        goods.setCreateTime(new Date());
        goods.setCreateUserId(user.getId());
        goods.setLastUpdateTime(new Date());
        goods.setLastUpdateUserId(user.getId());
        goods.setVersion(0);
        int count = 0;
        try {
            count = goodsMapper.insert(goods);
        } catch (Exception e) {
            logger.error(e.getMessage()+goods.toString(), e);
            throw new RuntimeException("cha ru shibai ");
        }
        if (count == 0) {
            return null;
        }
        else if (count == 1) {
            return goods;
        }
        else if (count > 1) {
            throw new RuntimeException("sql zhurule ");
        }
        else {
            return null;
        }
    }

}
