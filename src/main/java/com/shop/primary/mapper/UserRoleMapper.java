package com.shop.primary.mapper;

import com.shop.primary.entity.UserRoleExample;
import com.shop.primary.entity.UserRoleKey;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRoleMapper {
    int countByExample(UserRoleExample example);

    int deleteByExample(UserRoleExample example);

    int deleteByPrimaryKey(UserRoleKey key);

    int insert(UserRoleKey record);

    int insertSelective(UserRoleKey record);

    List<UserRoleKey> selectByExample(UserRoleExample example);

    int updateByExampleSelective(@Param("record") UserRoleKey record, @Param("example") UserRoleExample example);

    int updateByExample(@Param("record") UserRoleKey record, @Param("example") UserRoleExample example);
}