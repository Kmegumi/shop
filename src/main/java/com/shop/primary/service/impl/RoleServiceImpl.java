package com.shop.primary.service.impl;

import com.shop.core.exception.LockException;
import com.shop.core.exception.ServiceException;
import com.shop.core.utils.CommonUtils;
import com.shop.core.utils.PageUtils;
import com.shop.primary.entity.*;
import com.shop.primary.mapper.RoleMapper;
import com.shop.primary.mapper.RolePermissionMapper;
import com.shop.primary.mapper.UserRoleMapper;
import com.shop.primary.pojo.dto.UserRolesDTO;
import com.shop.primary.pojo.query.RoleInfoQuery;
import com.shop.primary.pojo.query.RoleQuery;
import com.shop.primary.pojo.vo.RowBoundVO;
import com.shop.primary.service.PermissionService;
import com.shop.primary.service.RoleService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import javax.annotation.Resource;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;


@Service
public class RoleServiceImpl implements RoleService {

    private static final Logger logger = LoggerFactory.getLogger(RoleServiceImpl.class);

    @Resource
    private PermissionService permissionService;

    @Resource
    private UserRoleMapper userRoleMapper;

    @Resource
    private RoleMapper roleMapper;

    @Resource
    private RolePermissionMapper rolePermissionMapper;


    @Override
    public RowBoundVO<Role> rowBoundRole(RoleQuery roleQuery) {
        if (roleQuery == null) {
            return null;
        }
        RoleExample roleExample = new RoleExample();
        RoleExample.Criteria criteria = roleExample.createCriteria();
        if (roleQuery.getName() != null) {
            criteria.andRoleNameLike(CommonUtils.textBeLike(roleQuery.getName()));
        }
        RowBoundVO<Role> rowBoundVO = null;
        try {
            int count = roleMapper.countByExample(roleExample);
            rowBoundVO = PageUtils.getRowBoundVO(roleQuery, count);
            if (rowBoundVO == null) {
                return null;
            }
            roleExample.setOrderByClause(roleQuery.getLimitWithOrder("last_update_datetime desc"));
            List<Role> list = roleMapper.selectByExample(roleExample);
            rowBoundVO.setList(list);
        } catch (Exception e) {
            logger.error(roleQuery.toString() + "_" + e.getMessage(), e);
        }
        return rowBoundVO;
    }

    @Override
    public List<Role> listRoleByUserId(Integer id) {
        if (id == null) {
            return null;
        }
        UserRoleExample userRoleExample = new UserRoleExample();
        UserRoleExample.Criteria criteria  = userRoleExample.createCriteria();
        criteria.andUserIdEqualTo(id);

        RoleExample roleExample = new RoleExample();
        RoleExample.Criteria criteria1 = roleExample.createCriteria();
        List<Integer> userIdList = new ArrayList<>();
        try {
            List<UserRoleKey> userRolesList = userRoleMapper.selectByExample(userRoleExample);
            for (UserRoleKey userRoleKey : userRolesList) {
                userIdList.add(userRoleKey.getUserId());
            }
            criteria1.andIdIn(userIdList);
            List<Role> list = roleMapper.selectByExample(roleExample);
            return list;
        } catch (Exception e) {
            logger.error(id.toString() + "_" + e.getMessage(), e);
        }
        return null;
    }

    @Override
    public List<Role> listRoleByListRoleId(List<Integer> list) {
        if (list == null || list.size() < 1) {
            return null;
        }
        RoleExample roleExample = new RoleExample();
        RoleExample.Criteria criteria = roleExample.createCriteria();
        criteria.andIdIn(list);
        try {
            List<Role> roleList = roleMapper.selectByExample(roleExample);
            return roleList;
        } catch (Exception e) {
            logger.error(list.toString()+"_"+e.getMessage(), e);
        }
        return null;
    }

    @Override
    public boolean saveUserRoles(UserRolesDTO userRolesDTO) {
        if (userRolesDTO.getUserId() == null) {
            return false;
        }
        if (userRolesDTO.getRoleIdList() == null) {
            return false;
        }
        if (userRolesDTO.getRoleIdList().length == 0) {
            return true;
        }
        UserRoleExample userRoleExample = new UserRoleExample();
        UserRoleExample.Criteria criteria = userRoleExample.createCriteria();
        criteria.andUserIdEqualTo(userRolesDTO.getUserId());
        try {
            userRoleMapper.deleteByExample(userRoleExample);
        } catch (Exception e) {
            logger.error(userRolesDTO.toString() + "_" + e.getMessage(), e);
            return false;
        }

        List<UserRoleKey> list = new ArrayList<>();
        for(String roleId: userRolesDTO.getRoleIdList()) {
            UserRoleKey userRoleKey = new UserRoleKey();
            userRoleKey.setUserId(userRolesDTO.getUserId());
            try {
                userRoleKey.setRoleId(Integer.valueOf(roleId));
            } catch (NumberFormatException e){
                continue;
            }
            list.add(userRoleKey);
        }
        if (list.size()>0) {
            for (UserRoleKey userRoleKey : list) {
                try {
                    userRoleMapper.insert(userRoleKey);
                } catch (Exception e) {
                    logger.error(userRoleKey.toString() + "_" + e.getMessage(), e);
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    return false;
                }
            }
        }
        return true;
    }

    @Override
    public Role getRoleByRoleId(Integer roleId) {
        if (roleId == null) {
            return null;
        }
        Role role = null;
        try {
            role = roleMapper.selectByPrimaryKey(roleId);
        } catch (Exception e) {
            logger.error(roleId.toString() + "_" + e.getMessage(), e);
        }
        return role;
    }

    @Override
    public List<Permission> listPermissionByRole(Role role) {
        if (role == null) {
            return null;
        }
        return permissionService.listPermissionByRoleId(role.getId());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Role saveOrUpdateRole(RoleInfoQuery roleInfoQuery) {
        CommonUtils.checkEntityQuery(roleInfoQuery);
        Role role = null;
        if (roleInfoQuery.getId() != null) {
            try {
                role = this.getRoleByRoleId(roleInfoQuery.getId());
            } catch (Exception e) {
                logger.error(roleInfoQuery.toString()+"_"+e.getMessage(), e);
                return null;
            }
            if (role == null) {
                return null;
            }
        } else {
            role = new Role();
        }
        role.setRoleName(roleInfoQuery.getRoleName());
        role.setRoleSign(roleInfoQuery.getRoleSign());
        role.setDescription(roleInfoQuery.getRoleDescription());
        role.setVersion(roleInfoQuery.getVersion());
        role.setLastUpdateDatetime(Instant.now());
        role.setLastUpdateUserId(roleInfoQuery.getUser().getId());
        if (roleInfoQuery.getId() != null) {
            role.setId(roleInfoQuery.getId());
            return updateRole(role);
        }
        role.setCreateDatetime(Instant.now());
        role.setCreateUserId(roleInfoQuery.getUser().getId());
        return saveRole(role);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Role saveRole(Role role) {
        if (role == null) {
            throw new ServiceException("参数为空");
        }
        role.setVersion(0);
        try {
            int count = roleMapper.insert(role);
            if (count == 0) {
                return null;
            }
        } catch (Exception e) {
            logger.error(role.toString() + "role保存失败_" + e.getMessage(), e);
            return null;
        }
        return role;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Role updateRole(Role role) {
        if (role == null) {
            throw new ServiceException("参数为空");
        }
        if (role.getId() == null) {
            return null;
        }
        if (role.getVersion() == null) {
            return null;
        }
        RoleExample roleExample = new RoleExample();
        RoleExample.Criteria criteria = roleExample.createCriteria();
        criteria.andIdEqualTo(role.getId());
        criteria.andVersionEqualTo(role.getVersion());
        role.setVersion(role.getVersion().intValue() + 1);
        try {
            int count = roleMapper.updateByExampleSelective(role, roleExample);
            if (count == 0) {
                throw new LockException("update [Role] count error：0");
            }
        } catch (Exception e) {
            logger.error(role.toString()+"_"+e.getMessage(), e);
            return null;
        }
        return role;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteRoleById(Integer roleId) {
        if (roleId == null) {
            return false;
        }
        try {
            if (permissionService.deleteRolePermissionByRoleId(roleId)) {
                int count = roleMapper.deleteByPrimaryKey(roleId);
                if (count == 0) {
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    return false;
                }
            }
        } catch (Exception e) {
            logger.error(roleId.toString() + "_" + e.getMessage(), e);
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return false;
        }
        return true;
    }

    @Override
    public List<Role> listRoleByPermissionId(Integer permissionId) {
        if (permissionId == null) {
            return null;
        }
        RolePermissionExample rolePermissionExample = new RolePermissionExample();
        RolePermissionExample.Criteria criteria = rolePermissionExample.createCriteria();
        criteria.andPermissionIdEqualTo(permissionId);

        List<Integer> roleIdList = new ArrayList<>();
        RoleExample roleExample = new RoleExample();
        RoleExample.Criteria criteria1 = roleExample.createCriteria();
        try {
            List<RolePermissionKey> rolePermissionsList = rolePermissionMapper.selectByExample(rolePermissionExample);
            for (RolePermissionKey rolePermissionKey : rolePermissionsList) {
                roleIdList.add(rolePermissionKey.getRoleId());
            }
            criteria1.andIdIn(roleIdList);
            List<Role> list = roleMapper.selectByExample(roleExample);
            return list;
        } catch (Exception e) {
            logger.error(permissionId + "_" + e.getMessage(), e);
        }
        return null;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteUserRolesByUserId(Integer userId) {
        UserRoleExample userRoleExample = new UserRoleExample();
        UserRoleExample.Criteria criteria = userRoleExample.createCriteria();
        criteria.andUserIdEqualTo(userId);
        try {
            int count = userRoleMapper.deleteByExample(userRoleExample);
            if (count > 0) {
                return true;
            }
        } catch (Exception e) {
            logger.error(userId + "_" + e.getMessage(), e);
        }
        return false;
    }
}
