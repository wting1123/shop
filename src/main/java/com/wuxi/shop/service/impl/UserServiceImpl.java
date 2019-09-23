package com.wuxi.shop.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wuxi.shop.common.ServerResponse;
import com.wuxi.shop.dao.CategoryMapper;
import com.wuxi.shop.dao.ProductMapper;
import com.wuxi.shop.dao.UserMapper;
import com.wuxi.shop.pojo.Category;
import com.wuxi.shop.pojo.Product;
import com.wuxi.shop.pojo.User;
import com.wuxi.shop.service.IUserService;

@Service
public class UserServiceImpl implements IUserService{
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private CategoryMapper categoryMapper;
	@Autowired
	private ProductMapper productMapper;
	
	@Override
	public ServerResponse<User> login(String username, String password) {
		int resultCount = userMapper.checkUsername(username);
		if(resultCount==0){
			return ServerResponse.createByErrorMessage("用户不存在");
		}
		//todo md5
		User user = userMapper.selectLogin(username, password);
		System.out.println(user);
		if(user == null){
			return ServerResponse.createByErrorMessage("用户名或密码错误");
		}
		user.setPassword(org.apache.commons.lang3.StringUtils.EMPTY);
		return ServerResponse.createBySuccess("登录成功", user);
	}

	@Override
	public List<Category> allCategory() {
		List<Category> catagoryList = new ArrayList<Category>();
		catagoryList = categoryMapper.allCategoryList();
		
		/*Category category1 = new Category("1", "手机数码");
		catagoryList.add(category1);
		Category category2 = new Category("2", "电脑办公");
		catagoryList.add(category2);
		Category category3 = new Category("3", "家具家居");
		catagoryList.add(category3);
		Category category4 = new Category("4", "鞋靴箱包");
		catagoryList.add(category4);
		Category category5 = new Category("5", "图书音像");
		catagoryList.add(category5);
		Category category6 = new Category("6", "母婴孕婴");
		catagoryList.add(category6);
		Category category7 = new Category("7", "运动户外");
		catagoryList.add(category7);
		Category category8 = new Category("9", "汽车用品");
		catagoryList.add(category8);*/
		
		return catagoryList;
	}

	@Override
	public boolean checkUsername(String username) {
		int resultCount = userMapper.checkUsername(username);
		if (resultCount == 0){
			return false;
		}else{
			return true;
		}	
	}

	@Override
	public ServerResponse<User> register(User user) {
		int resultCount = userMapper.insertSelective(user);
		if (resultCount == 1){
			return ServerResponse.createBySuccessMessage("注册成功");
		}
		else{
			return ServerResponse.createByErrorMessage("注册失败");
		}
	}

	@Override
	public List<Product> allProductList(String cid) {
		List<Product> productList = new ArrayList<Product>();
		productList = productMapper.selectByCid(cid);
		return productList;
	}

	@Override
	public Product selectProductByPid(String pid) {
		Product product = null;
		product = productMapper.selectByPrimaryKey(pid);
		return product;
	}

	@Override
	public String selectProductCategory(String cid) {
		Category category = categoryMapper.selectCategoryByCid(cid);
		return category.getCname();
	}
}
