package com.wuxi.shop.dao;


import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.wuxi.shop.pojo.User;

@Repository
public interface UserMapper {
    int deleteByPrimaryKey(String uid);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(String uid);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

	int checkUsername(@Param("username") String username);

	User selectLogin(@Param("username") String username, @Param("password") String password);

}