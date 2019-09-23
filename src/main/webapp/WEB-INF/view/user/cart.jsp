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
		<title>购物车</title>
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
			}
			
			.carousel-inner .item img {
				width: 100%;
				height: 300px;
			}
			
			font {
				color: #3164af;
				font-size: 18px;
				font-weight: normal;
				padding: 0 10px;
			}
		</style>
		
		
		<script type="text/javascript">
			$(function(){
				getCart();
			});
			
			function getCart(){
				$.ajax({
					url:"<%=path %>/user/getCart.do", 
					type:"post",
					dataType:"json",
					success:function(result){
						if(result.total == 0){
							$("#cartShow").hide();
							$("<div></div>").addClass("text-center").append($("<h2></h2>").append($("<small></small>").append($("<em></em>").append("您的购物车空空如也!"))));
						}else{
							data = result.cartItems;
							$.each(data, function(index, item){
								var cart_pimage = $("<td></td>").append($("<input>").attr("type","hidden").attr("name","pid").attr("value",item.product.pid)).append($("<img>").attr("src",item.product.pimage).attr("width","45").attr("height","45"));
								var cart_pname = $("<td></td>").append($("<a></a>").append(item.product.pname).attr("target","_blank"));
								var cart_shopPrice =  $("<td></td>").append(item.product.shopPrice);
								var cart_buyNum =$("<td></td>").append(item.buyNum);
								var cart_subtotal = $("<td></td>").append(item.subtotal);
								var cart_deleteBtn = $("<td></td>").append($("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append("删除").attr("pid",item.product.pid))
								$("<tr></tr>").addClass("active").append(cart_pimage)
								 													.append(cart_pname)
								 													.append(cart_shopPrice)
								 													.append(cart_buyNum)
								 													.append(cart_subtotal)
								 													.append(cart_deleteBtn)
								 													.appendTo($("#cart"));
								
							});
						}
					}
				});
			}
			
			/* 点击删除 */
			$(document).on("click",".delete_btn",function(){
				if (confirm("确认删除该商品吗?")){
					var pid = $(this).parents("tr").find("input").val();
					$.ajax({
						url:"<%=path%>/user/deleteProduct.do",
						async:false,
						data:{"pid":pid},
						type:"post",
						dataType:"json",
						success:function(result){
							if (result == "true"){
								alert("删除商品成功!");
							}else{
								alert("删除商品失败!");
							}
						}
					});
					$("#cart").empty();
					getCart();
				}
			});
			
			function clearCart(){
				if(confirm("您是否要清空购物车？")){
					$.ajax({
						url:"<%=path%>/user/clearCart.do",
						async:false,
						type:"post",
						dataType:"json",
						success:function(result){
							if (result == "true"){
								alert("清空购物车成功!");
							}else{
								alert("清空购物车失败!");
							}
						}
					});
					$("#cart").empty();
					getCart();
				}
			}
			
			function submitOrder(){
				if (confirm("是否提交订单?")){
					location.href="<%=path%>/user/myOrders.do";
					$("#cart").empty();
				}
			}
		</script>
		
	</head>

	<body>
		<!-- 引入header.jsp -->
		<jsp:include page="header.jsp"></jsp:include>
		
			<div id="cartShow" class="container">
				<div class="row">
					<div style="margin:0 auto; margin-top:10px;width:950px;">
						<h4>订单详情</h4>
						<table class="table table-hover">
							<thead>
								<tr class="warning">
									<th>图片</th><th>商品</th><th>价格</th><th>数量</th><th>小计</th><th>操作</th>
								</tr>							
							</thead>
							<tbody id="cart" ></tbody>
						</table>
					</div>
				</div>
				<div style="margin-right:130px;">
					<div style="text-align:right;margin-top:10px;margin-bottom:10px;">
						<button type="button" class="btn btn-link" onclick="clearCart()" id="clear" class="clear">清空购物车</button>
						<button type="button" class="btn btn-primary btn-lg"  onclick="submitOrder()" id="clear"  style="background: height:35px;width:100px;">提交订单</button>
					</div>
				</div>
			</div>
		<!-- 引入footer.jsp -->
		<jsp:include page="footer.jsp"></jsp:include>

	</body>

</html>