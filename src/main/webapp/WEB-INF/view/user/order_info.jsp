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
<title>订单信息</title>
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
</style>
<script type="text/javascript">
	$(function(){
		getOrders();
	});
	
	function confirmOrder(){	
		$.ajax({
			url:"<%=path%>/user/clearCart.do",
			async:false,
			type:"post",
			dataType:"json",
		});
		$("#orders").empty();
		$("#total").empty();
		getOrders();
		alert("支付成功!");
	}
	
	function clearOrder(){
		if(confirm("您是否要取消订单？")){
			$.ajax({
				url:"<%=path%>/user/clearCart.do",
				async:false,
				type:"post",
				dataType:"json",
				success:function(result){
					if (result == "true"){
						alert("取消订单成功!");
					}else{
						alert("取消订单失败!");
					}
				}
			});
			$("#orders").empty();
			$("#total").empty();
			getOrders();
		}
	}
	
	function getOrders(){
		$.ajax({
			url:"<%=path %>/user/getOrders.do", 
			type:"post",
			dataType:"json",
			success:function(result){
				if(result.total == 0){
					$("#ordersShow").hide();
				}else{
					data = result.cartItems;
					$.each(data, function(index, item){
						var cart_pimage = $("<td></td>").append($("<input>").attr("type","hidden").attr("name","pid").attr("value",item.product.pid)).append($("<img>").attr("src",item.product.pimage).attr("width","45").attr("height","45"));
						var cart_pname = $("<td></td>").append($("<a></a>").append(item.product.pname).attr("target","_blank"));
						var cart_shopPrice =  $("<td></td>").append(item.product.shopPrice);
						var cart_buyNum =$("<td></td>").append(item.buyNum);
						var cart_subtotal = $("<td></td>").append(item.subtotal);
						$("<tr></tr>").addClass("active").append(cart_pimage)
						 													.append(cart_pname)
						 													.append(cart_shopPrice)
						 													.append(cart_buyNum)
						 													.append(cart_subtotal)
						 													.appendTo($("#orders"));
						
					});
					$("#total").append(result.total);
				}
			}
		});
	}
</script>
</head>
<body>
	<!-- 引入header.jsp -->
	<jsp:include page="header.jsp"></jsp:include>
	
	<div id="ordersShow" class="container">
		<div class="row">
			<div style="margin: 0 auto; margin-top: 10px; width: 950px;">
				<h4>订单详情</h4>
				<table class="table table-hover">
					
						<tr class="warning"><th colspan="5">订单编号:${order.oid }</th></tr>
						<tr class="warning"><th>图片</th><th>商品</th><th>价格</th><th>数量</th><th>小计</th></tr>	
						<tbody id="orders"></tbody>	
				</table>
			</div>

			<div style="text-align: right; margin-right: 120px;">
				商品金额: <strong id="total" style="color: #ff6600;">￥</strong>
			</div>

		</div>

		<div>
			<hr />
			<form id="orderForm" class="form-horizontal" action="<%=path %>/user/" method="post" style="margin-top: 5px; margin-left: 150px;">
				<!-- method的名字 通过表单提交 -->
				<input type="hidden" name="method" value="confirmOrder">
				<!-- 传递订单oid -->
				<input type="hidden" name="oid" value="${order.oid }">
				
				
				<div class="form-group">
					<label for="address" class="col-sm-1 control-label">地址</label>
					<div class="col-sm-5">
						<input type="text" class="form-control" id="address" name="address"  placeholder="请输收货地址" value="">
					</div>
				</div>
				<div class="form-group">
					<label for="name" class="col-sm-1 control-label">收货人</label>
					<div class="col-sm-5">
						<input type="text" class="form-control" id="name" name="name" placeholder="请输收货人" value="${user.name }">
					</div>
				</div>
				<div class="form-group">
					<label for="confirmpwd" class="col-sm-1 control-label">电话</label>
					<div class="col-sm-5">
						<input type="text" class="form-control" id="confirmpwd" name="telephone" placeholder="请输入联系方式"  value="${user.telephone }">
					</div>
				</div>
				<hr />
				<div style="margin-top: 5px; margin-left: 0px;">
					<strong>选择银行</strong>
					<p>
						<br /> 
						<input type="radio" name="pd_FrpId" value="ICBC-NET-B2C" checked="checked" />工商银行 <img src="/shop_pic/bank_img/icbc.bmp" align="middle" />&nbsp;&nbsp;&nbsp;&nbsp; 
						<input type="radio" name="pd_FrpId" value="BOC-NET-B2C" />中国银行 <img src="/shop_pic/bank_img/bc.bmp" align="middle" />&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="pd_FrpId" value="ABC-NET-B2C" />农业银行 <img src="/shop_pic/bank_img/abc.bmp" align="middle" /> <br /> <br /> 
						<input type="radio" name="pd_FrpId" value="BOCO-NET-B2C" />交通银行 <img src="/shop_pic/bank_img/bcc.bmp" align="middle" />&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="pd_FrpId" value="PINGANBANK-NET" />平安银行<img src="/shop_pic/bank_img/pingan.bmp" align="middle" />&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="pd_FrpId" value="CCB-NET-B2C" />建设银行 <img src="/shop_pic/bank_img/ccb.bmp" align="middle" /> <br /> <br /> 
						<input type="radio" name="pd_FrpId" value="CEB-NET-B2C" />光大银行 <img src="/shop_pic/bank_img/guangda.bmp" align="middle" />&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="pd_FrpId" value="CMBCHINA-NET-B2C" />招商银行<img src="/shop_pic/bank_img/cmb.bmp" align="middle" />
					</p>
					<hr />
					<p style="text-align: right; margin-right: 100px;">
						<button type="button" class="btn btn-link" onclick="clearOrder()" id="clear" class="clear">取消订单</button>
						<button type="button" onclick="confirmOrder()" class="btn btn-danger btn-lg" >确认订单</button>
					</p>
					<hr />
	
				</div>
			
			</form>
			
		</div>

	</div>

	<!-- 引入footer.jsp -->
	<jsp:include page="footer.jsp"></jsp:include>

</body>

</html>