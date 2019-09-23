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
<title>会员登录</title>
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

.container .row div {
	/* position:relative;
				 float:left; */
	
}

font {
	color: #666;
	font-size: 22px;
	font-weight: normal;
	padding-right: 17px;
}
</style>
<script type="text/javascript">
	$(function(){
		$("#username").blur(function(){
			//1.获取失去焦点用户名输入框的内容
			//三种写法
			//var usernameInput = $("#username").val();
			//var usernameInput = this.value;
			var usernameInput = $(this).val();
			/* alert(usernameInput); */	
			var ret = /^[a-z0-9_-]{3,16}$/;   //用户名正则表达式
			if (!ret.test(usernameInput)){
				$("#checkUsername").empty();
				$("#checkUsername").append("请输入3-16位由数字和字母组成的账号").attr("color", "red");
			}else{
				$("#checkUsername").empty();
			}
		});
		
		$("#password").blur(function(){
			var passwordInput = $("#password").val();
			var ret = /^[a-z0-9_-]{6,18}$/;   //密码正则表达式
			if (!ret.test(passwordInput)){
				$("#checkPassword").empty();
				$("#checkPassword").append("密码由6-18位的数字和字母组成").attr("color", "red");
			}else{
				$("#checkPassword").empty();
			}
		});
	});
</script>
</head>
<body>
	<!-- 引入header.jsp -->
	<jsp:include page="header.jsp"></jsp:include>
			
	<div class="container" style="width: 98%; height: 460px; background: #FF2C4C  no-repeat;">
		<div class="row">
			<div class="col-md-7">
				<img src="/shop_pic/images/loginbg.jpg" width="800" height="330" alt="会员登录" title="会员登录">
			</div>

			<div class="col-md-5">
				<div style="width: 450px; border: 1px solid #E7E7E7; padding: 20px 0 20px 30px; border-radius: 5px; margin-top: 60px; background: #fff;">
					<font>会员登录</font>USER LOGIN
					<div>&nbsp;</div>
					<form class="form-horizontal" method="post" action="<%=path %>/user/authLogin.do">
						
						<input type="hidden" name="method" value="login">
						
						<div class="form-group">
							<label for="username" class="col-sm-2 control-label">账号</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" id="username" name="username" placeholder="username">
								<span id="checkUsername"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="password" class="col-sm-2 control-label">密码</label>
							<div class="col-sm-6"> 
								<input type="password" class="form-control" id="password" name="password" placeholder="password">
								<span id="checkPassword"></span>
								<span id="checkLogin">${requestScope.Error}</span>
							</div>		
						</div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<div class="checkbox">
									<label> <input type="checkbox" name="autoLogin" value="autoLogin"> 自动登录
									</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <label> <input type="checkbox"> 记住密码</label>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<input type="submit" class="btn btn-danger" width="100" value="登录" name="submit" style="background: height: 35px; width: 190px;">
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- 引入footer.jsp -->
	<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>