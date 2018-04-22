package com.shop.primary.service;

import com.shop.core.exception.ServiceException;
import com.shop.primary.entity.BaseEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

public class BaseService<Dao extends JpaRepository<T, Long>, T extends BaseEntity> {

    @Autowired
    protected Dao dao;

    public List<T> listAll() {
        return dao.findAll();
    }

    public T getById(Long id) {
        if (id == null || id.intValue() < 1) {
            throw new ServiceException("id 有误");
        }
        return dao.getOne(id);
    }

    @Transactional(rollbackFor = Exception.class)
    public T save(T t) {
        t.setId(null);
        t.setVersion(0L);
        LocalDateTime now = LocalDateTime.now();
        t.setCreateTime(now);
        t.setLastUpdateTime(now);
        return dao.save(t);
    }

    @Transactional(rollbackFor = Exception.class)
    public T update(T t) {
        if (t.getId() == null || t.getId() < 1) {
            throw new ServiceException("缺少对象id");
        }
        if (t.getVersion() == null) {
            throw new ServiceException("缺少版本号");
        }
        t.setLastUpdateTime(LocalDateTime.now());
        return dao.save(t);
    }

    @Transactional(rollbackFor = Exception.class)
    public void deleteById(Long id) {
        if (id == null || id.intValue() < 1) {
            throw new ServiceException("id 有误");
        }
        dao.delete(id);
    }

}
