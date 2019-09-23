<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<!--声明文档兼容性-->
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<!--设置视口宽度，值为设备宽度-->
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>商城首页</title>
		<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
		<script src="<%=path %>/static/js/jquery-3.3.1.js"></script>
		<!--  Bootstrap 核心 CSS 文件 -->
		<link rel="stylesheet" href="<%=path %>/static/css/bootstrap.min.css" >
		<!-- Bootstrap 核心 JavaScript 文件 -->
		<script src="<%=path %>/static/js/bootstrap.min.js" ></script>
		<style type="text/css">
			a{
				text-decoration: none;
			}
			a:hover {
				text-decoration: none;
			} 
		</style>
	</head>

	<body>
		<div class="container-fluid">

			<!-- 引入header.jsp -->
			<jsp:include page="header.jsp"></jsp:include>

			<!-- 轮播图 -->
			<div class="container-fluid">
				<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
					<!-- 轮播图的中的小点 -->
					<ol class="carousel-indicators">
						<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
						<li data-target="#carousel-example-generic" data-slide-to="1"></li>
						<li data-target="#carousel-example-generic" data-slide-to="2"></li>
					</ol>
					<!-- 轮播图的轮播图片 -->
					<div class="carousel-inner" role="listbox">
						<div class="item active">
							<img src="/shop_pic/img/1+/1.jpg">
							<div class="carousel-caption">
								<!-- 轮播图上的文字 -->
							</div>
						</div>
						<div class="item">
							<img src="/shop_pic/img/1+/2.jpg">
							<div class="carousel-caption">
								<!-- 轮播图上的文字 -->
							</div>
						</div>
						<div class="item">
							<img src="/shop_pic/img/1+/3.jpg">
							<div class="carousel-caption">
								<!-- 轮播图上的文字 -->
							</div>
						</div>
					</div>

					<!-- 上一张 下一张按钮 -->
					<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
						<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a>
					<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
						<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
			</div>
			
			<!-- 热门商品 -->
			<div class="container-fluid">
				<div class="col-md-12">
					<h2>热门商品&nbsp;&nbsp;<small>根据你的喜好精心为您推荐！</small></h2>
				</div>
						
				<div class="col-md-6">
					<div class="col-md-12" style="text-align:center;height:300px;padding:0px;">
						<a href="#">
							<img src="/shop_pic/products/hao/shop4.jpg" width="600px" height="300px" style="display: inline-block;">
						</a>
					</div>				
				</div>
				
				<div class="col-md-6">
					<div class="col-md-12" style="text-align:center;height:300px;padding:0px;">
						<a href="#">
							<img src="/shop_pic/products/hao/shop5.jpg" width="600px" height="300px" style="display: inline-block;">
						</a>
					</div>				
				</div>

			</div>
			
			<!-- 最新商品 -->
			<div class="container-fluid">
				<div class="col-md-12">
					<h2>最新商品&nbsp;&nbsp;<small>根据你的喜好精心为您推荐！</small></h2>
				</div>
				
				<div class="col-md-6">
					<div class="col-md-12" style="text-align:center;height:300px;padding:0px;">
						<a href="#">
							<img src="/shop_pic/products/hao/shop6.jpg" width="600px" height="300px" style="display: inline-block;">
						</a>
					</div>
				</div>
				
				<div class="col-md-6">
					<div class="col-md-12" style="text-align:center;height:300px;padding:0px;">
						<a href="#">
							<img src="/shop_pic/products/hao/shop7.jpg" width="600px" height="300px" style="display: inline-block;">
						</a>
					</div>
				</div>
			</div>			
			
			<!-- 引入footer.jsp -->
			<jsp:include page="footer.jsp"></jsp:include>
			
		</div>
	</body>

</html>