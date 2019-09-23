package com.wuxi.shop.dao;

import org.springframework.stereotype.Repository;

import com.wuxi.shop.pojo.Orders;

@Repository
public interface OrdersMapper {
    int deleteByPrimaryKey(String oid);

    int insert(Orders record);

    int insertSelective(Orders record);

    Orders selectByPrimaryKey(String oid);

    int updateByPrimaryKeySelective(Orders record);

    int updateByPrimaryKey(Orders record);
}