package com.wuxi.shop.dao;

import org.springframework.stereotype.Repository;

import com.wuxi.shop.pojo.Orderitem;

@Repository
public interface OrderitemMapper {
    int deleteByPrimaryKey(String itemid);

    int insert(Orderitem record);

    int insertSelective(Orderitem record);

    Orderitem selectByPrimaryKey(String itemid);

    int updateByPrimaryKeySelective(Orderitem record);

    int updateByPrimaryKey(Orderitem record);
}