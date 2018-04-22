package com.shop.primary.service;

import com.shop.core.utils.CoderUtil;
import com.shop.primary.dao.UserDao;
import com.shop.primary.entity.User;
import com.shop.primary.pojo.query.AdminLoginQuery;
import com.shop.primary.pojo.query.AdminQuery;
import org.apache.commons.codec.CharEncoding;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.Predicate;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
@Transactional(rollbackFor = Exception.class)
public class AdminService extends BaseService<UserDao, User> {

    private static final Logger logger = LoggerFactory.getLogger(AdminService.class);

    public User getUserByUserName(AdminLoginQuery adminLoginQuery) {
        if (adminLoginQuery == null) {
            return null;
        }
        try {
            User user = this.dao.findByUsername(adminLoginQuery.getUsername());
            return user;
        } catch (Exception e) {
            logger.error(adminLoginQuery.toString() + "_" + e.getMessage(), e);
        }
        return null;
    }

    public User userLoginCheck(AdminLoginQuery adminLoginQuery) {
        User user = getUserByUserName(adminLoginQuery);
        if (Objects.equals(user.getPassword(), CoderUtil.sign(adminLoginQuery.getPassword(), CharEncoding.UTF_8))) {
            return user;
        }
        return null;
    }

    public Page<User> rowBoundForUser(AdminQuery adminQuery) {
        if (adminQuery == null) {
            return null;
        }
        try {
            Page<User> page = this.dao.findAll((root, query, builder) -> {
                List<Predicate> list = new ArrayList<>();
                if (adminQuery.getStatusEnum() != null) {
                    list.add(builder.equal(root.get("status"), adminQuery.getStatusEnum()));
                }
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

    @Transactional(rollbackFor = Exception.class)
    public User saveOrUpdateAdmin(User user, Long userId) {
        if (userId == null) {
            return null;
        }
        if (user.getId() != null) {
            User oldUser = null;
            oldUser = this.dao.findOne(user.getId());
            if (oldUser == null) {
                return null;
            }
            oldUser.setUsername(user.getUsername());
            if (!Objects.equals(oldUser.getPassword(), user.getPassword())) {
                oldUser.setPassword(CoderUtil.sign(user.getPassword(), CharEncoding.UTF_8));
            }
            oldUser.setName(user.getName());
            oldUser.setMobile(user.getMobile());
            oldUser.setEmail(user.getEmail());
            oldUser.setVersion(user.getVersion());
            oldUser.setStatus(user.getStatus());
            oldUser.setLastUpdateUserId(userId);
            return this.update(oldUser);
        }
        return this.save(user);
    }

}
