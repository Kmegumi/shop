package com.shop.core.security;


import com.shop.core.exception.ServiceException;
import com.shop.primary.entity.*;
import com.shop.primary.enums.StatusEnum;
import com.shop.primary.mapper.PermissionMapper;
import com.shop.primary.mapper.RoleMapper;
import com.shop.primary.mapper.RolePermissionMapper;
import com.shop.primary.mapper.UserRoleMapper;
import com.shop.primary.pojo.query.AdminLoginQuery;
import com.shop.primary.service.AdminService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 用户身份验证,授权 Realm 组件
 *
 **/
@Component(value = "securityRealm")
public class SecurityRealm extends AuthorizingRealm {

    @Resource
    private AdminService adminService;

    @Resource
    private UserRoleMapper userRoleMapper;

    @Resource
    private RolePermissionMapper rolePermissionMapper;

    @Resource
    private PermissionMapper permissionMapper;

    /**
     * 权限检查
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        User user = (User) principals.getPrimaryPrincipal();

        UserRoleExample userRoleExample = new UserRoleExample();
        UserRoleExample.Criteria criteria = userRoleExample.createCriteria();
        criteria.andUserIdEqualTo(user.getId());
        List<UserRoleKey> userRolesList = userRoleMapper.selectByExample(userRoleExample);
        List<Integer> roleIdList = new ArrayList<>();
        for (UserRoleKey userRoleKey : userRolesList) {
            roleIdList.add(userRoleKey.getRoleId());
        }

        RolePermissionExample rolePermissionExample = new RolePermissionExample();
        RolePermissionExample.Criteria criteria1 = rolePermissionExample.createCriteria();
        criteria1.andRoleIdIn(roleIdList);
        List<RolePermissionKey> rolePermissionsList = rolePermissionMapper.selectByExample(rolePermissionExample);
        List<Integer> permissionIdList = new ArrayList<>();
        for (RolePermissionKey rolePermissionKey : rolePermissionsList) {
            permissionIdList.add(rolePermissionKey.getPermissionId());
        }

        PermissionExample permissionExample = new PermissionExample();
        PermissionExample.Criteria criteria2 = permissionExample.createCriteria();
        criteria2.andIdIn(permissionIdList);
        List<Permission> permissionList = permissionMapper.selectByExample(permissionExample);

        for (Permission permission : permissionList) {
            authorizationInfo.addStringPermission(permission.getPermissionSign());
        }
        return authorizationInfo;
    }

    /**
     * 登录验证
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        String username = String.valueOf(token.getPrincipal());
        String password = new String((char[]) token.getCredentials());
        // 通过数据库进行验证
        AdminLoginQuery adminLoginQuery = new AdminLoginQuery();
        adminLoginQuery.setUsername(username);
        adminLoginQuery.setPassword(password);
        User authentication = adminService.userLoginCheck(adminLoginQuery);
        if (authentication == null) {
            throw new AuthenticationException("用户名或密码错误.");
        }
        if(authentication.getStatus().name().equals(StatusEnum.N.name())){
            throw new ServiceException("该账号被禁用,请联系管理员！");
        }
        SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(authentication, password, getName());
        return authenticationInfo;
    }

}
