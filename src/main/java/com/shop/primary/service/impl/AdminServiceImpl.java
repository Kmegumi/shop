package com.shop.primary.service.impl;

import com.shop.core.exception.DAOException;
import com.shop.core.exception.LockException;
import com.shop.core.exception.ServiceException;
import com.shop.core.utils.CoderUtil;
import com.shop.core.utils.CommonUtils;
import com.shop.core.utils.PageUtils;
import com.shop.primary.entity.*;
import com.shop.primary.mapper.UserMapper;
import com.shop.primary.mapper.UserRoleMapper;
import com.shop.primary.pojo.query.AdminInfoQuery;
import com.shop.primary.pojo.query.AdminLoginQuery;
import com.shop.primary.pojo.query.AdminQuery;
import com.shop.primary.pojo.vo.RowBoundVO;
import com.shop.primary.service.AdminService;
import com.shop.primary.service.RoleService;
import org.apache.commons.codec.CharEncoding;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;


@Service
public class AdminServiceImpl implements AdminService {

    private static final Logger logger = LoggerFactory.getLogger(AdminServiceImpl.class);

    @Resource
    private UserMapper userMapper;

    @Resource
    private RoleService roleService;

    @Resource
    private UserRoleMapper userRoleMapper;

    @Override
    public User getUserByUserName(AdminLoginQuery adminLoginQuery) {
        if (adminLoginQuery == null) {
            return null;
        }
        UserExample userExample = new UserExample();
        UserExample.Criteria userExampleCriteria = userExample.createCriteria();
        userExampleCriteria.andUsernameEqualTo(adminLoginQuery.getUsername());
        List<User> list = null;
        try {
            list = userMapper.selectByExample(userExample);
        } catch (Exception e) {
            logger.error(adminLoginQuery.toString() + "_" + e.getMessage(), e);
        }
        if (list != null && list.size() > 0) {
            return list.get(0);
        }
        return null;
    }

    @Override
    public User userLoginCheck(AdminLoginQuery adminLoginQuery) {
        User user = getUserByUserName(adminLoginQuery);
        if (Objects.equals(user.getPassword(), CoderUtil.sign(adminLoginQuery.getPassword(), CharEncoding.UTF_8))) {
            return user;
        }
        return null;
    }

    @Override
    public RowBoundVO<User> rowBoundForUser(AdminQuery adminQuery) {
        if (adminQuery == null) {
            return null;
        }
        UserExample userExample = new UserExample();
        UserExample.Criteria criteria = userExample.createCriteria();
        if (adminQuery.getName() != null) {
            criteria.andNameLike(CommonUtils.textBeLike(adminQuery.getName()));
        }
        if (adminQuery.getStatusEnum() != null) {
            criteria.andStatusEqualTo(adminQuery.getStatusEnum());
        }
        RowBoundVO<User> rowBoundVO = null;
        try {
            int count = userMapper.countByExample(userExample);
            rowBoundVO = PageUtils.getRowBoundVO(adminQuery, count);
            if (rowBoundVO == null) {
                return null;
            }
            userExample.setOrderByClause(adminQuery.getLimitWithOrder("last_update_datetime desc"));
            List<User> list = userMapper.selectByExample(userExample);
            rowBoundVO.setList(list);
        } catch (Exception e) {
            logger.error(adminQuery.toString() + "_" + e.getMessage(), e);
        }
        return rowBoundVO;
    }

    @Override
    public User getUserById(Integer id) {
        if (id == null) {
            return null;
        }
        try {
            User user = userMapper.selectByPrimaryKey(id);
            return user;
        } catch (Exception e) {
            logger.error(id.toString() + "_" + e.getMessage(), e);
            return null;
        }
    }

    @Override
    public List<Role> listRoleByAdminUser(User user) {
        if (user == null) {
            return null;
        }
        return roleService.listRoleByUserId(user.getId());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public User saveOrUpdateAdmin(AdminInfoQuery adminInfoQuery) {
        CommonUtils.checkEntityQuery(adminInfoQuery);
        User user = null;
        if (adminInfoQuery.getId() != null) {
            user = this.getUserById(adminInfoQuery.getId());
            if (user == null) {
                return null;
            }
        } else {
            user = new User();
        }
        user.setUsername(adminInfoQuery.getUsername());
        if (!Objects.equals(adminInfoQuery.getPassword(), user.getPassword())) {
            user.setPassword(CoderUtil.sign(adminInfoQuery.getPassword(), CharEncoding.UTF_8));
        }
        user.setName(adminInfoQuery.getName());
        user.setMobile(adminInfoQuery.getMobile());
        user.setEmail(adminInfoQuery.getEmail());
        user.setVersion(adminInfoQuery.getVersion());
        user.setStatus(adminInfoQuery.getStatus());
        user.setLastUpdateDatetime(Instant.now());
        user.setLastUpdateUserId(adminInfoQuery.getUser().getId());
        if (adminInfoQuery.getId() != null) {
            user.setId(adminInfoQuery.getId());
            return updateAdmin(user);
        }
        user.setCreateDatetime(Instant.now());
        user.setCreateUserId(adminInfoQuery.getUser().getId());
        return saveAdmin(user);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public User saveAdmin(User user) {
        if (user == null) {
            throw new ServiceException("参数为空");
        }
        user.setVersion(0);
        try {
            int count = userMapper.insert(user);
            if (count == 0) {
                return null;
            }
        } catch (Exception e) {
            logger.error(user.toString()+"user保存失败_"+e.getMessage(), e);
            return null;
        }
        return user;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public User updateAdmin(User user) {
        if (user == null) {
            throw new ServiceException("参数为空");
        }
        if (user.getId() == null) {
            return null;
        }
        if (user.getVersion() == null) {
            return null;
        }
        UserExample userExample = new UserExample();
        UserExample.Criteria criteria = userExample.createCriteria();
        criteria.andIdEqualTo(user.getId());
        criteria.andVersionEqualTo(user.getVersion());
        user.setVersion(user.getVersion().intValue() + 1);
        try {
            int count = userMapper.updateByExampleSelective(user, userExample);
            if (count == 0) {
                throw new LockException("update [User] count error: 0");
            }
            return user;
        } catch (Exception e) {
            logger.error(user.toString()+"_"+e.getMessage(), e);
            return null;
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteUserById(Integer userId) {
        if (userId == null) {
            return false;
        }
        try {
            if (roleService.deleteUserRolesByUserId(userId)) {
                int count = userMapper.deleteByPrimaryKey(userId);
                if (count > 0) {
                    return true;
                }
            }
        } catch (Exception e) {
            logger.error(userId.toString() + "_" + e.getMessage(), e);
        }
        return false;
    }

    @Override
    public List<User> listUserByRoleId(Integer roleId) {
        if (roleId == null) {
            return null;
        }
        UserRoleExample userRoleExample = new UserRoleExample();
        UserRoleExample.Criteria criteria = userRoleExample.createCriteria();
        criteria.andRoleIdEqualTo(roleId);
        List<UserRoleKey> userRolesList = userRoleMapper.selectByExample(userRoleExample);
        List<Integer> userIdList = new ArrayList<>();
        for (UserRoleKey userRoleKey : userRolesList) {
            userIdList.add(userRoleKey.getUserId());
        }
        UserExample userExample = new UserExample();
        UserExample.Criteria criteria1 = userExample.createCriteria();
        criteria1.andIdIn(userIdList);
        try {
            List<User> list = userMapper.selectByExample(userExample);
            return list;
        } catch (Exception e) {
            logger.error(roleId + "_" + e.getMessage(), e);
        }
        return null;
    }

}
