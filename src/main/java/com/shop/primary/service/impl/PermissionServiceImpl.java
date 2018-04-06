package com.shop.primary.service.impl;

import com.shop.core.exception.LockException;
import com.shop.core.exception.ServiceException;
import com.shop.core.utils.CommonUtils;
import com.shop.core.utils.PageUtils;
import com.shop.primary.entity.Permission;
import com.shop.primary.entity.PermissionExample;
import com.shop.primary.entity.RolePermissionExample;
import com.shop.primary.entity.RolePermissionKey;
import com.shop.primary.mapper.PermissionMapper;
import com.shop.primary.mapper.RolePermissionMapper;
import com.shop.primary.pojo.dto.RolePermissionDTO;
import com.shop.primary.pojo.query.PermissionInfoQuery;
import com.shop.primary.pojo.query.PermissionQuery;
import com.shop.primary.pojo.vo.RowBoundVO;
import com.shop.primary.service.PermissionService;
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
public class PermissionServiceImpl implements PermissionService {

    private static final Logger logger = LoggerFactory.getLogger(PermissionServiceImpl.class);

    @Resource
    private PermissionMapper permissionMapper;

    @Resource
    private RolePermissionMapper rolePermissionMapper;

    @Override
    public List<Permission> listPermissionByRoleId(Integer roleId) {
        if (roleId == null) {
            return null;
        }
        RolePermissionExample rolePermissionExample = new RolePermissionExample();
        RolePermissionExample.Criteria criteria = rolePermissionExample.createCriteria();
        criteria.andRoleIdEqualTo(roleId);
        List<Permission> list = null;
        List<Integer> permissionIdList = new ArrayList<>();
        PermissionExample permissionExample = new PermissionExample();
        PermissionExample.Criteria criteria1 = permissionExample.createCriteria();
        try {
            List<RolePermissionKey> rolePermissionsList = rolePermissionMapper.selectByExample(rolePermissionExample);
            for (RolePermissionKey rolePermissionKey : rolePermissionsList) {
                permissionIdList.add(rolePermissionKey.getPermissionId());
            }
            criteria1.andIdIn(permissionIdList);
            list = permissionMapper.selectByExample(permissionExample);
        } catch (Exception e) {
            logger.error(roleId.toString() + "_" + e.getMessage(), e);
            return null;
        }
        return list;
    }

    @Override
    public RowBoundVO<Permission> rowBoundPermission(PermissionQuery permissionQuery) {
        if (permissionQuery == null) {
            return null;
        }
        PermissionExample permissionExample = new PermissionExample();
        PermissionExample.Criteria criteria = permissionExample.createCriteria();
        if (permissionQuery.getName() != null) {
            criteria.andPermissionNameLike(CommonUtils.textBeLike(permissionQuery.getName()));
        }
        RowBoundVO<Permission> rowBoundVO = null;
        try {
            int count = permissionMapper.countByExample(permissionExample);
            rowBoundVO = PageUtils.getRowBoundVO(permissionQuery, count);
            if (rowBoundVO == null) {
                return null;
            }
            permissionExample.setOrderByClause(permissionQuery.getLimitWithOrder("last_update_datetime desc"));
            List<Permission> list = permissionMapper.selectByExample(permissionExample);
            rowBoundVO.setList(list);
            return rowBoundVO;
        }catch (Exception e) {
            logger.error(permissionQuery.toString() + "_" + e.getMessage(), e);
        }
        return null;
    }

    @Override
    public List<Permission> listPermissionByListPermissionId(List<Integer> listPermissionId) {
        if (listPermissionId == null || listPermissionId.size() < 1) {
            return null;
        }
        PermissionExample permissionExample = new PermissionExample();
        PermissionExample.Criteria criteria = permissionExample.createCriteria();
        criteria.andIdIn(listPermissionId);
        try {
            List<Permission> permissionList = permissionMapper.selectByExample(permissionExample);
            return permissionList;
        } catch (Exception e) {
            logger.error(listPermissionId.toString()+"_"+e.getMessage(), e);
        }
        return null;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean saveRolePermission(RolePermissionDTO rolePermissionDTO) {
        if (rolePermissionDTO.getRoleId() == null) {
            return false;
        }
        if (rolePermissionDTO.getPermissionList() == null) {
            return false;
        }
        if (rolePermissionDTO.getPermissionList().length == 0) {
            return true;
        }

        try {
            RolePermissionExample rolePermissionExample = new RolePermissionExample();
            RolePermissionExample.Criteria criteria = rolePermissionExample.createCriteria();
            criteria.andRoleIdEqualTo(rolePermissionDTO.getRoleId());
            rolePermissionMapper.deleteByExample(rolePermissionExample);
        } catch (Exception e) {
            logger.error(rolePermissionDTO.toString() + "_" + e.getMessage(), e);
            return false;
        }

        List<RolePermissionKey> list = new ArrayList<>();
        for(String permissionId: rolePermissionDTO.getPermissionList()) {
            RolePermissionKey rolePermissionKey = new RolePermissionKey();
            rolePermissionKey.setRoleId(rolePermissionDTO.getRoleId());
            try {
                rolePermissionKey.setPermissionId(Integer.valueOf(permissionId));
            } catch (NumberFormatException e){
                continue;
            }
            list.add(rolePermissionKey);
        }
        if (list.size()>0) {
            for (RolePermissionKey rolePermissionKey : list) {
                try {
                    int count = rolePermissionMapper.insert(rolePermissionKey);
                    if (count == 0) {
                        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                        return false;
                    }
                } catch (Exception e) {
                    logger.error(list.toString() + "_" + e.getMessage(), e);
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    return false;
                }
            }
        }
        return true;
    }

    @Override
    public Permission getPermissionByPermissionId(Integer permissionId) {
        if (permissionId == null) {
            return null;
        }
        Permission permission = null;
        try {
            permission = permissionMapper.selectByPrimaryKey(permissionId);
        } catch (Exception e) {
            logger.error(permissionId.toString() + "_" + e.getMessage(), e);
            return null;
        }
        return permission;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Permission saveOrUpdatePermission(PermissionInfoQuery permissionInfoQuery) {
        CommonUtils.checkEntityQuery(permissionInfoQuery);
        Permission permission = null;
        if (permissionInfoQuery.getId() != null) {
            permission = this.getPermissionByPermissionId(permissionInfoQuery.getId());
            if (permission == null) {
                return null;
            }
        } else {
            permission = new Permission();
        }
        permission.setPermissionName(permissionInfoQuery.getPermissionName());
        permission.setPermissionSign(permissionInfoQuery.getPermissionSign());
        permission.setDescription(permissionInfoQuery.getPermissionDescription());
        permission.setVersion(permissionInfoQuery.getVersion());
        permission.setLastUpdateDatetime(Instant.now());
        permission.setLastUpdateUserId(permissionInfoQuery.getUser().getId());
        if (permissionInfoQuery.getId() != null) {
            permission.setId(permissionInfoQuery.getId());
            return updatePermission(permission);
        }
        permission.setCreateDatetime(Instant.now());
        permission.setCreateUserId(permissionInfoQuery.getUser().getId());
        return savePermission(permission);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Permission savePermission(Permission permission) {
        if (permission == null) {
            throw new ServiceException("参数为空");
        }
        permission.setVersion(0);
        try {
            int count = permissionMapper.insert(permission);
            if (count == 0) {
                return null;
            }
        } catch (Exception e) {
            logger.error(permission.toString()+ "permission保存失败_" + e.getMessage(), e);
            return null;
        }
        return permission;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Permission updatePermission(Permission permission) {
        if (permission == null) {
            throw new ServiceException("参数为空");
        }
        if (permission.getId() == null) {
            return null;
        }
        if (permission.getVersion() == null) {
            return null;
        }
        PermissionExample permissionExample = new PermissionExample();
        PermissionExample.Criteria criteria = permissionExample.createCriteria();
        criteria.andIdEqualTo(permission.getId());
        criteria.andVersionEqualTo(permission.getVersion());
        permission.setVersion(permission.getVersion().intValue() + 1);
        try {
            int count = permissionMapper.updateByExampleSelective(permission, permissionExample);
            if (count == 0) {
                throw new LockException("update [Permission] count error：0");
            }
        } catch (Exception e) {
            logger.error(permission.toString()+"_"+e.getMessage(), e);
            return null;
        }
        return permission;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deletePermissionById(Integer permissionId) {
        if (permissionId == null) {
            return false;
        }
        try {
            int count = permissionMapper.deleteByPrimaryKey(permissionId);
            if (count == 0) {
                return false;
            }
        } catch (Exception e) {
            logger.error(permissionId.toString() + "_" + e.getMessage(), e);
            return false;
        }
        return true;
    }

    @Override
    public boolean deleteRolePermissionByRoleId(Integer roleId) {
        RolePermissionExample rolePermissionExample = new RolePermissionExample();
        RolePermissionExample.Criteria criteria = rolePermissionExample.createCriteria();
        criteria.andRoleIdEqualTo(roleId);
        try {
            int count = rolePermissionMapper.deleteByExample(rolePermissionExample);
            if (count > 0) {
                return true;
            }
        } catch (Exception e) {
            logger.error(roleId + "删除角色权限关联_" + e.getMessage(), e);
        }
        return false;
    }
}
