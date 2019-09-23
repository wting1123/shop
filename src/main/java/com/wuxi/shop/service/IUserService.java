package com.wuxi.shop.service;

import java.util.List;

import com.wuxi.shop.common.ServerResponse;
import com.wuxi.shop.pojo.Category;
import com.wuxi.shop.pojo.Product;
import com.wuxi.shop.pojo.User;

public interface IUserService {

	ServerResponse<User> login(String username, String password);

	List<Category> allCategory();

	boolean checkUsername(String username);

	ServerResponse<User> register(User user);

	List<Product> allProductList(String cid);

	Product selectProductByPid(String pid);

	String selectProductCategory(String cid);
}
