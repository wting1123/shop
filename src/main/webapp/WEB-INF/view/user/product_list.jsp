<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>商品列表</title>
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="<%=path %>/static/js/jquery-3.3.1.js"></script>
<!--  Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="<%=path %>/static/css/bootstrap.min.css" >
<!-- Bootstrap 核心 JavaScript 文件 -->
<script src="<%=path %>/static/js/bootstrap.min.js" ></script>
<!-- 引入自定义css文件 style.css -->
<link rel="stylesheet" href="<%=path %>/static/css/style.css" />

<style>
a{
	text-decoration: none;
}

a:hover {
	text-decoration: none;
} 

body {
	margin-top: 20px;
	margin: 0 auto;
	width: 100%;
}

.carousel-inner .item img {
	width: 100%;
	height: 300px;
}
</style>
</head>
<body>
	<!-- 引入header.jsp -->
	<jsp:include page="header.jsp"></jsp:include>

	<div class="row" style="width: 1210px; margin: 0 auto;">
		<div class="col-md-12">
			<ol class="breadcrumb">
				<li><a href="<%=path%>/user/index.do">首页</a></li>
			</ol>
		</div>
		
		<!-- 分页商品信息展示 -->
		<div class="container-fluid">
			<div id="product_list" class="row text-center">
  			</div>
		</div>
		
		
	</div>

	<!-- 分页信息 -->
	<div id="page_nav" class="row text-center" style="width: 380px; margin: 0 auto; margin-top: 50px;">
		
	</div>


	<!--商品浏览记录-->
	<div style="width: 1210px; margin: 0 auto; padding: 0 9px; border: 1px solid #ddd; border-top: 2px solid #999; height: 246px;">

		<h4 style="width: 50%; float: left; font: 14px/30px 微软雅黑">浏览记录</h4>
		<div style="width: 50%; float: right; text-align: right;">
			<a href="">more</a>
		</div>
		<div style="clear: both;"></div>

		<div style="overflow: hidden;">

			<ul style="list-style: none;">
			</ul>

		</div>
	</div>
	<!-- 引入footer.jsp -->
	<jsp:include page="footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
var cid = ${requestScope.Cid};

$(function(){
	to_page(1);
});

function to_page(pn){
	$.ajax({
		url:"<%=path%>/user/productList.do",
		data:{"pn":pn,"cid":cid},
	    type:"post",
	    dataType:"json",
	    success:function(result){
	    	/* 清空表格 */
			$("#product_list").empty();
	    	build_product_list(result);
	    	
	    	/* 清空导航条 */
			$("#page_nav").empty();
	    	build_page_nav(result);
	    }
	});
}

function build_product_list(result){
	var list = result.list;
	$.each(list, function(index, item){
		var div = $("<div></div>").addClass("col-md-3");
		var img = $("<a></a>").append($("<img>").attr("src", item.pimage).attr("width", "170").attr("height", "170")).attr("href","<%=path %>/user/productInfo.do?pid=" + item.pid + "&cid=" + item.cid)
		var name = $("<p></p>").append($("<a></a>").append(item.pname).attr("href","<%=path %>/user/productInfo.do?pid=" + item.pid + "&cid=" + item.cid));
		var price = $("<p></p>").append($("<font></font>").append("商城价:" + item.shopPrice).attr("color", "red"));
		div.append(img);
		div.append(name);
		div.append(price);
		div.appendTo($("#product_list"));
	})
}

function build_page_nav(result){	
	/* 解析显示导航条 */
	var ul = $("<ul></ul>").addClass("pagination");
	
	/* 添加首页和上一页导航条 */
	/* 没有上一页则不能点击 */
	var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
	var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
	if (result.hasPreviousPage == false){
		firstPageLi.addClass("disabled");
		prePageLi.addClass("disabled");
	}
	else{
		/* 首页和上一页绑定事件 */
		firstPageLi.click(function(){
			to_page(1);
		});
		prePageLi.click(function(){
			to_page(result.pageNum - 1);
		});
	}

	/* 添加末页和下一页导航条 */
	/* 没有下一页则不能点击 */
	var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
	var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
	if (result.hasNextPage == false){
		nextPageLi.addClass("disabled");
		lastPageLi.addClass("disabled");
	}
	else{
		/* 末页和下一页绑定事件 */
		nextPageLi.click(function(){
			to_page(result.pageNum + 1);
		});
		lastPageLi.click(function(){
			to_page(result.pages);
		});
	}
	
	/* 首页和上一页添加到ul中 */
	ul.append(firstPageLi).append(prePageLi);
	
	
	$.each(result.navigatepageNums, function(index, item){
		var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
		if (result.pageNum == item){
			numLi.addClass("active");
		}
		numLi.click(function(){
			to_page(item);
		});
		
		ul.append(numLi);
	});
	
	/* 末页和下一页添加到ul中 */
	ul.append(nextPageLi).append(lastPageLi);
	
	var navElement = $("<nav></nav>").append(ul);
	
	navElement.appendTo("#page_nav");
}
</script>
</html>