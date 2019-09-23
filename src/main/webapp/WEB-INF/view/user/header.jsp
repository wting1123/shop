<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<!-- <script type="text/javascript">
$(function(){
	alert(1);
	var username = ${requestScope.Username};
	if (username != ""){
		$("#login").show();
		$("#register").show();
	}else{
		$("#login").hide();
		$("#register").hide();
	}
});
</script> -->
<!-- 登录 注册 购物车... -->
<div class="container-fluid">
	<div class="col-md-4">
		<img src="/shop_pic/img/logo1.jpg"/>
	</div>
	<div class="col-md-5">
		<!-- <img src="/shop_pic/img/header.jpg" /> -->
	</div>
	<div class="col-md-3" style="padding-top:20px">
		<ol class="list-inline">
				<li id="login"><a href="<%=path%>/user/login.do">登录</a></li>
				<li id="register"><a href="<%=path%>/user/register.do">注册</a></li>
				<li style="color:red">${requestScope.Username}</li>
				<li><a href="<%=path%>/user/index.do">退出</a></li>
				<li><a href="<%=path%>/user/cart.do">购物车</a></li>
				<li><a href="<%=path%>/user/myOrders.do">我的订单</a></li>
		</ol>
	</div>
</div>

<!-- 导航条 -->
<div class="container-fluid">
	<nav class="navbar">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="<%=path%>/user/index.do">首页</a>
			</div>

			<!-- 显示商品类别 -->
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav" id="categoryUl">
					
				</ul>
				<form class="navbar-form navbar-right" role="search">
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Search">
					</div>
					<button type="submit" class="btn btn-default">Submit</button>
				</form>
			</div>
		</div>
		
		<script type="text/javascript">
			$(function(){
				$.ajax({
					url:"<%=path %>/user/categoryList.do",
					async:true,
					type:"post",
					dataType:"json",
					success:function(data){
						$.each(data, function(index, item){
							var li = $("<li></li>").append($("<a></a>").append(item.cname).attr("href","<%=path %>/user/product.do?cid=" + item.cid));
							$("#categoryUl").append(li);
						});
					}
				});
			});	
		</script>
		
	</nav>
</div>