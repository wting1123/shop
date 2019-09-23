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
<title>商品信息</title>
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
	var pid = ${requestScope.Pid};
	var cid = ${requestScope.Cid};
	$(function(){		
		$.ajax({
			url:"<%=path%>/user/product_lnfo_display.do",
			data:{"pid":pid},
			type:"post",
			dataType:"json",
			success:function(result){
				$("#pro_pname").append(result.pname);
				$("#pro_pimage").attr("src", result.pimage);
				$("#pro_pid").append(result.pid);
				$("#pro_shopPrice").append(result.shopPrice);
				$("#pro_marketPrice").append(result.marketPrice);
				$("#pro_pdesc").append(result.pdesc);
			}
		});
		
		$.ajax({
			url:"<%=path%>/user/productOfCategory.do",
			data:{"cid":cid},
			type:"post",
			dataType:"json",
			success:function(result){
				$("#pro_category").append(result).attr("href", "<%=path %>/user/product.do?cid=" + cid);
			}
		});	
	});
	
	function addCart(){
		var buyNum = $("#buyNum").val();
		$.ajax({
			url:"<%=path%>/user/addProductToCart.do",
			async:false,
			data:{"pid":pid, "buyNum":buyNum},
			type:"post",
			dataType:"json",
			success:function(result){
				if (result == "true"){
					alert("添加购物车成功!");
				}else{
					alert("添加购物车失败!");
				}
			}
		});
	}
</script>
</head>
<body>
	<!-- 引入header.jsp -->
	<jsp:include page="header.jsp"></jsp:include>

	<div class="container">
		<div class="row">
			<div style="border: 1px solid #e4e4e4; width: 930px; margin-bottom: 10px; margin: 0 auto; padding: 10px; margin-bottom: 10px;">
				<a href="<%=path%>/user/index.do">首页</a>&nbsp;&nbsp;&gt;
				<a id="pro_category"></a>&nbsp;&nbsp;&gt;
				<a id="pro_pname"></a>
			</div>

			<div style="margin: 0 auto; width: 950px;">
				<div class="col-md-6">
					<img id="pro_pimage" style="opacity: 1; width: 400px; height: 350px;" title="" class="medium">
				</div>

				<div class="col-md-6">
					<div>
						<h4 id="pro_pname"></h4>
					</div>
					<div
						style="border-bottom: 1px dotted #dddddd; width: 350px; margin: 10px 0 10px 0;">
						<div id="pro_pid">编号：</div>
					</div>

					<div style="margin: 10px 0 10px 0;">
						折扣价：<span id="pro_shopPrice" style="color: #ef0101;">￥ </span><span style="color: #ef0101;">元</span> &nbsp;&nbsp;
						参 考 价：<del id="pro_marketPrice" style="color: #ef0101;">￥ </del><del style="color: #ef0101;">元</del>
					</div>

					<div style="margin: 10px 0 10px 0;">
						促销: <a target="_blank" title="限时抢购 (2014-07-30 ~ 2015-01-01)">限时抢购</a>
					</div>

					<div style="padding: 10px; border: 1px solid #e7dbb1; height: 200px;width: 330px; margin: 15px 0 10px 0; background-color: #fffee6;">
						<div style="margin: 5px 0 10px 0;">一款适合您的物品噢 ！</div> 
						<div style="margin: 5px 0 10px 0;">&nbsp;</div> 
									
						<div style="border-bottom: 1px solid #faeac7; margin-top: 20px; padding-left: 0px;">
							<%-- <input type="hidden" id="pid" name="pid" value="${requestScope.Pid}"> --%>
							<div class="col-sm-4">
								购买数量<input id="buyNum" name="buyNum" class="form-control" value="1" maxlength="4" type="text">
							</div>
						</div>

						<div style="margin: 20px 0 10px 0; text-align: center;">
							<button type="button" id="addCartBtn" class="btn btn-danger" onclick="addCart()" style="background: height: 36px; width: 127px;">加入购物车</button>
							&nbsp;&nbsp;收藏商品
						</div>

					</div>
				</div>
			</div>
			<div class="clear"></div>
			<div style="width: 950px; margin: 0 auto;">
				<div style="background-color: #d3d3d3; width: 930px; padding: 10px 10px; margin: 10px 0 10px 0;">
					<h4>商品介绍</h4>	
				</div>
				<div style="margin-top: 10px; width: 930px;">
					<table class="table table-hover">
						<tr><td id="pro_pdesc"></td></tr>
					</table>
				</div>

				<div>
					<img id="pro_pimage">
				</div>

				<div style="background-color: #d3d3d3; width: 930px; padding: 10px 10px; margin: 10px 0 10px 0;">
					<h4>商品参数</h4>
				</div>
				<div style="margin-top: 10px; width: 930px;">
					<table class="table table-hover">
						<tbody>
							<tr class="active">
								<th colspan="2">基本参数</th>
							</tr>
							<tr>
								<th width="10%">级别</th>
								<td width="30%">标准</td>
							</tr>
							<tr>
								<th width="10%">标重</th>
								<td>500</td>
							</tr>
							<tr>
								<th width="10%">浮动</th>
								<td>200</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div style="background-color: #d3d3d3; width: 930px;">
					<table class="table table-bordered">
						<tbody>
							<tr class="active">
								<th><h4>商品评论</h4></th>
							</tr>
							<tr class="warning">
								<th>暂无商品评论信息 <a>[发表商品评论]</a></th>
							</tr>
						</tbody>
					</table>
				</div>

				<div style="background-color: #d3d3d3; width: 930px;">
					<table class="table table-bordered">
						<tbody>
							<tr class="active">
								<th><h4>商品咨询</h4></th>
							</tr>
							<tr class="warning">
								<th>暂无商品咨询信息 <a>[发表商品咨询]</a></th>
							</tr>
						</tbody>
					</table>
				</div>
			</div>

		</div>
	</div>


	<!-- 引入footer.jsp -->
	<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>