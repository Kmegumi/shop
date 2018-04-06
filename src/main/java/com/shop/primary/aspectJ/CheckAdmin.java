package com.shop.primary.aspectJ;

import com.shop.core.exception.UserValidateException;
import com.shop.primary.entity.User;
import com.shop.primary.pojo.query.AdminQuery;
import com.shop.primary.pojo.query.EntityQuery;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;


@Aspect
@Component
public class CheckAdmin {

    @Autowired
    protected HttpServletRequest request;


    @Pointcut("execution(* com.shop.primary.controller.*.*(..))")
    public void adminCheckPoint(){

    }

    /**
     * adminList查询处理
     * */

    @Before(value = "adminCheckPoint()&&args(adminQuery,..)")
    private void checkAdminList(AdminQuery adminQuery){

        if (adminQuery != null) {
            adminQuery.setUser(getUser());
        }

    }

    /**
     * adminList查询处理
     * */

    @Before(value = "adminCheckPoint()&&args(entityQuery,..)")
    private void checkAdminEntity(EntityQuery entityQuery){

        if (entityQuery != null) {
            //从session中获取booker对象
            entityQuery.setUser(getUser());
        }

    }

    private User getUser(){
        Subject subject = SecurityUtils.getSubject();
        User user = (User) subject.getPrincipal();
        if (user != null) {
            return user;
        } else {
            throw new UserValidateException("登录超时，请重新登录");
        }
    }
}
