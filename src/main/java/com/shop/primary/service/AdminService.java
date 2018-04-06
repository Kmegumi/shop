package com.shop.primary.service;

import com.shop.primary.entity.Role;
import com.shop.primary.entity.User;
import com.shop.primary.pojo.query.AdminInfoQuery;
import com.shop.primary.pojo.query.AdminLoginQuery;
import com.shop.primary.pojo.query.AdminQuery;
import com.shop.primary.pojo.vo.RowBoundVO;

import java.util.List;


public interface AdminService {

    User getUserByUserName(AdminLoginQuery adminLoginQuery);

    User userLoginCheck(AdminLoginQuery adminLoginQuery);

    RowBoundVO<User> rowBoundForUser(AdminQuery adminQuery);

    User getUserById(Integer id);

    List<Role> listRoleByAdminUser(User user);

    User saveOrUpdateAdmin(AdminInfoQuery adminInfoQuery);

    User saveAdmin(User user);

    User updateAdmin(User user);

    boolean deleteUserById(Integer userId);

    List<User> listUserByRoleId(Integer roleId);
}
