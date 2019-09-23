package com.wuxi.shop.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.wuxi.shop.pojo.Category;

@Repository
public interface CategoryMapper {
    int deleteByPrimaryKey(String cid);

    int insert(Category record);

    int insertSelective(Category record);

    Category selectByPrimaryKey(String cid);

    int updateByPrimaryKeySelective(Category record);

    int updateByPrimaryKey(Category record);

	List<Category> allCategoryList();

	Category selectCategoryByCid(String cid);

}