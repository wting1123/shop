package com.wuxi.shop.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wuxi.shop.common.ServerResponse;
import com.wuxi.shop.pojo.Cart;
import com.wuxi.shop.pojo.CartItem;
import com.wuxi.shop.pojo.Category;
import com.wuxi.shop.pojo.Product;
import com.wuxi.shop.pojo.User;
import com.wuxi.shop.service.IUserService;
import com.wuxi.shop.utils.CommonsUtils;
import com.wuxi.shop.utils.GetMessageCode;


@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	 IUserService userService;
	
	@RequestMapping("/login")
	public ModelAndView login()
	{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("user/login");
		return mv;
	}
	
	@RequestMapping("/register")
	public ModelAndView register()
	{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("user/register");
		return mv;
	}
	
	@RequestMapping("index")
	public ModelAndView index(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("user/index");
		return mv;
	}
	
	@RequestMapping("cart")
	public ModelAndView cart(HttpSession session,ModelMap map){
		ModelAndView mv = new ModelAndView();
		map.put("Username", session.getAttribute("Username"));
		mv.setViewName("user/cart");
		return mv;
	}
	
	@RequestMapping("myOrders")
	public ModelAndView myOrders(HttpSession session,ModelMap map){
		ModelAndView mv = new ModelAndView();
		map.put("Username", session.getAttribute("Username"));
		mv.setViewName("user/order_info");
		return mv;
	}
	
	@RequestMapping("/authLogin")
	public ModelAndView authLogin(String username,String password,HttpSession session,ModelMap map)
	{
		ServerResponse<User> response = userService.login(username, password);
		ModelAndView mv = new ModelAndView();
		if(response.isSuccess()){
			session.setAttribute("Username", username);
			map.put("Username", username);
			mv.setViewName("user/index");
		}else{
			map.put("Error", response.getMsg());
			mv.setViewName("user/login");
		}
		return mv;
	}
	
	@RequestMapping("/checkUsername")
	@ResponseBody
	public String checkUsername(String username){
		if (userService.checkUsername(username)){
			return "true";
		}else{
			return "false";
		}
	}
	
	@RequestMapping("/categoryList")
	@ResponseBody
	public List<Category> categoryList(){
		List<Category> categoryList = new ArrayList<Category>();
		categoryList = userService.allCategory();
		return categoryList;
	}
	
	@RequestMapping("/sendSMS")
	@ResponseBody
	public String sendSMS(String telephone){
		//System.out.println(telephone);
		return GetMessageCode.getCode(telephone);
	}
	
	@RequestMapping("/toRegister")
	public ModelAndView toRegister(String username, String password, String email, String name, String sex, String telephone, ModelMap map){
		User user = new User(CommonsUtils.getUUID(), username, password, name, email, telephone, sex);
		ModelAndView mv = new ModelAndView();
		ServerResponse<User> response = userService.register(user);
		if (response.isSuccess()){
			mv.setViewName("user/login");
		}else{
			map.put("Error", response.getMsg());
			mv.setViewName("user/register");
		}
		return mv;
	}
	
	@RequestMapping("/productList")
	@ResponseBody
	public PageInfo<Product> productList(@RequestParam(value="pn",defaultValue="1") Integer pn, @RequestParam(value="cid",defaultValue="1") String cid){
		PageHelper.startPage(pn, 8);
		List<Product>  product_list= userService.allProductList(cid);
		PageInfo<Product> page = new PageInfo<Product>(product_list,5);
		return page;
	}
	
	@RequestMapping("/product")
	public ModelAndView product(@RequestParam(value="cid",defaultValue="1") String cid, HttpSession session, ModelMap map){
		ModelAndView mv = new ModelAndView();
		map.put("Username", session.getAttribute("Username"));
		session.setAttribute("Cid", cid);
		map.put("Cid", cid);
		mv.setViewName("user/product_list");
		return mv;
	}
	
	@RequestMapping("/productInfo")
	public ModelAndView productInfo(String pid, String cid, HttpSession session,ModelMap map){
		ModelAndView mv = new ModelAndView();
		map.put("Username", session.getAttribute("Username"));
		map.put("Pid", pid);
		map.put("Cid", cid);
		mv.setViewName("user/product_info");
		return mv;
	}
	
	@RequestMapping("/product_lnfo_display")
	@ResponseBody
	public Product product_lnfo_display(String pid){
		System.out.println(pid);
		return userService.selectProductByPid(pid);
	}
	
	@RequestMapping("/productOfCategory")
	@ResponseBody
	public String productOfCategory(String cid){
		return userService.selectProductCategory(cid);
	}
	
	@RequestMapping("/addProductToCart")
	@ResponseBody
	public String addProductToCart(String pid, Integer buyNum, HttpSession session){
		//int num = Integer.parseInt("buyNum");
		Product product = userService.selectProductByPid(pid);
		double subtotal = product.getShopPrice()*buyNum;
		
		//封装CartItem
		CartItem item = new CartItem();
		item.setProduct(product);
		item.setBuyNum(buyNum);
		item.setSubtotal(subtotal);
		
		//获得购物车---判断是否在session中已经存在购物车
		Cart cart = (Cart) session.getAttribute("cart");
		if(cart==null){
			cart = new Cart();
		}
		//将购物项放到车中---key是pid
		//先判断购物车中是否已将包含此购物项了 ----- 判断key是否已经存在
		//如果购物车中已经存在该商品----将现在买的数量与原有的数量进行相加操作
		Map<String, CartItem> cartItems = cart.getCartItems();

		double newsubtotal = 0.0;

		if(cartItems.containsKey(pid)){
			//取出原有商品的数量
			CartItem cartItem = cartItems.get(pid);
			int oldBuyNum = cartItem.getBuyNum();
			oldBuyNum+=buyNum;
			cartItem.setBuyNum(oldBuyNum);
			cart.setCartItems(cartItems);
			//修改小计
			//原来该商品的小计
			double oldsubtotal = cartItem.getSubtotal();
			//新买的商品的小计
			newsubtotal = buyNum*product.getShopPrice();
			cartItem.setSubtotal(oldsubtotal+newsubtotal);

		}else{
			//如果车中没有该商品
			cart.getCartItems().put(product.getPid(), item);
			newsubtotal = buyNum*product.getShopPrice();
		}

		//计算总计
		double total = cart.getTotal()+newsubtotal;
		cart.setTotal(total);

		//将车再次访问session
		session.setAttribute("cart", cart);
		return "true";
	}
	
	@RequestMapping("/getCart")
	@ResponseBody
	public Cart getCart(	HttpSession session){
		Cart cart = (Cart) session.getAttribute("cart");
		return cart;
	}
	
	@RequestMapping("/deleteProduct")
	@ResponseBody
	public String deleteProduct(String pid, HttpSession session){
		Cart cart = (Cart) session.getAttribute("cart");
		if(cart!=null){
			Map<String, CartItem> cartItems = cart.getCartItems();
			//需要修改总价
			cart.setTotal(cart.getTotal()-cartItems.get(pid).getSubtotal());
			//删除
			cartItems.remove(pid);
			cart.setCartItems(cartItems);

		}
		session.setAttribute("cart", cart);
		return "true";
	}
	
	@RequestMapping("/clearCart")
	@ResponseBody
	public String clearCart(HttpSession session){
		session.removeAttribute("cart");
		return "true";
	}
	
	@RequestMapping("/getOrders")
	@ResponseBody
	public Cart getOrders(	HttpSession session){
		Cart cart = (Cart) session.getAttribute("cart");
		return cart;
	}
}
