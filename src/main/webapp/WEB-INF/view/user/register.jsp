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
<link rel="stylesheet" href="<%=path %>/static/css/style.css" type="text/css" />

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

.error{
	color:red
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
			if (ret.test(usernameInput)){
				$.ajax({
					url:"<%=path%>/user/checkUsername.do",
					async:true,
					type:"post",
					data:{"username":usernameInput},
					dataType:"json",
					success:function(data){
						//alert(data);
						if (data == "true"){
							$("#usernameCheck").empty();
							$("#usernameCheck").append("账号已存在").attr("color", "red");
						}else{
							$("#usernameCheck").empty();
							$("#usernameCheck").append("账号可以使用").attr("color", "green");
						}
					}
				});
			}else{
				$("#usernameCheck").empty();
				$("#usernameCheck").append("请输入3-16位由数字和字母组成的账号").attr("color", "red");
			}
		});
		
		$("#password").blur(function(){
			var passwordInput = $("#password").val();
			var ret = /^[a-z0-9_-]{6,18}$/;   //密码正则表达式
			if (ret.test(passwordInput)){
				$("#passwordCheck").empty();
				$("#passwordCheck").append("密码格式正确").attr("color", "green");
			}else{
				$("#passwordCheck").empty();
				$("#passwordCheck").append("密码由6-18位的数字和字母组成").attr("color", "red");
			}
		});
		
		$("#confirmpwd").blur(function(){
			var passwordInput = $("#password").val();
			var confirmpwdInput = $("#confirmpwd").val();
			
			if (passwordInput != confirmpwdInput){
				$("#confirmpwdCheck").empty();
				$("#confirmpwdCheck").append("密码不一致").attr("color", "red");
			}else{
				$("#confirmpwdCheck").empty();
				$("#confirmpwdCheck").append("密码一致").attr("color", "green");
			}
		});
				
		$("#email").blur(function(){
			var emailInput = $("#email").val();
			var ret = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (ret.test(emailInput)){
				$("#emailCheck").empty();
				$("#emailCheck").append("邮箱格式正确").attr("color", "green");
			}else{
				$("#emailCheck").empty();
				$("#emailCheck").append("这不是一个有效的邮箱").attr("color", "red");
			}
		});
		
		$("#telephone").blur(function(){
			var emailInput = $("#telephone").val();
			var ret = /^[\d]{5,20}$/;
			if (ret.test(emailInput)){
				$("#telephoneCheck").empty();
				$("#telephoneCheck").append("手机格式正确").attr("color", "green");
			}else{
				$("#telephoneCheck").empty();
				$("#telephoneCheck").append("这不是一个有效的手机号").attr("color", "red");
			}
		});
		
		var InterValObj; //timer变量，控制时间
	    var count = 10; //间隔函数，1秒执行
	    var curCount;//当前剩余秒数
	    function sendMessage(){
	    	curCount = count;
	        $("#sendCode").attr("disabled", "true");
	        $("#sendCode").val(curCount + "秒后可重新发送");
	        InterValObj = window.setInterval(SetRemainTime, 1000); //启动计时器，1秒执行一次请求后台发送验证码 TODO
	    }
	    //timer处理函数
	    function SetRemainTime() {
	        if (curCount == 0) {
	            window.clearInterval(InterValObj);//停止计时器
	            $("#sendCode").removeAttr("disabled");//启用按钮
	            $("#sendCode").val("重新发送验证码");
	        }
	        else {
	            curCount--;
	            $("#sendCode").val(curCount + "秒后可重新发送");
	        }
	    }
		
		var sms = "";
		$("#sendCode").click(function(){	
			sendMessage();
			SetRemainTime();
			var telephone=$("#telephone").val();
			if (telephone == ""){
				$("#codeCheck").empty();
				$("#codeCheck").append("手机号不能为空").attr("color", "red");
			}else{
				$.ajax({
	                url:"<%=path%>/user/sendSMS.do",
	                type:"post",
	                data:{"telephone":telephone},
	                dataType:"json",
	                success:function(result){
	                	//alert(result);
	                    if(result != ""){
	                        sms=result;
	                    }
	                }
	            });
			}
		});
		
		$("#code").blur(function(){
			var codeInput = $("#code").val();
			if (sms == codeInput){
				$("#codeCheck").empty();
				$("#codeCheck").append("验证码正确").attr("color", "green");
				$("#submit").removeClass("disabled");
			}else{
				$("#codeCheck").empty();
				$("#codeCheck").append("验证码错误").attr("color", "red");
			}
		});
	});
</script>
</head>
<body>

	<!-- 引入header.jsp -->
	<jsp:include page="header.jsp"></jsp:include>

	<div class="container"
		style="width: 98%; background: url('/shop_pic/image/regist_bg.jpg');">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8"
				style="background: #fff; padding: 40px 80px; margin: 30px; border: 7px solid #ccc;">
				<font>会员注册</font>USER REGISTER
				<form id="myform" class="form-horizontal" action="<%=path %>/user/toRegister.do" method="post" style="margin-top: 5px;">
					<div class="form-group">
						<label for="username" class="col-sm-2 control-label">账号</label>
						<div class="col-sm-6">
							<input type="text" class="form-control" id="username" name="username" placeholder="Username">
							<span id="usernameCheck"></span>
						</div>
					</div>
					<div class="form-group">
						<label for="password" class="col-sm-2 control-label">密码</label>
						<div class="col-sm-6">
							<input type="password" class="form-control" id="password" name="password" placeholder="Password">
							<span id="passwordCheck"></span>
						</div>
					</div>
					<div class="form-group">
						<label for="confirmpwd" class="col-sm-2 control-label">确认密码</label>
						<div class="col-sm-6">
							<input type="password" class="form-control" id="confirmpwd" name="repassword" placeholder="Repassword">
							<span id="confirmpwdCheck"></span>
						</div>
					</div>
					<div class="form-group">
						<label for="email" class="col-sm-2 control-label">Email</label>
						<div class="col-sm-6">
							<input type="email" class="form-control" id="email" name="email" placeholder="Email">
							<span id="emailCheck"></span>
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">姓名</label>
						<div class="col-sm-6">
							<input type="text" class="form-control" id="name" name="name" placeholder="Name">
						</div>
					</div>
					<div class="form-group opt">
						<label for="inlineRadio1" class="col-sm-2 control-label">性别</label>
						<div class="col-sm-6">
							<label class="radio-inline"> 
								<input type="radio" name="sex" id="sex1" value="male" >男
							</label> 
							<label class="radio-inline"> 
								<input type="radio" name="sex" id="sex2" value="female">女
							</label>
							<label class="error" for="sex" style="display:none ">您没有第三种选择</label>
						</div>
					</div>
					<div class="form-group">
						<label for="telephone" class="col-sm-2 control-label">手机号</label>
						<div class="col-sm-6">
							<input type="text" class="form-control" id="telephone" name="telephone" placeholder="Telephone">
							<span id="telephoneCheck"></span>
						</div>
					</div>

					<div class="form-group">
						<label for="date" class="col-sm-2 control-label">验证码</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="code" name="code" style="background: height: 35px; width: 200px; ">
							<span id="codeCheck"></span>
						</div>
						<div class="col-sm-3">
							<input type="button" class="btn btn-info" id="sendCode" name="sendCode" value="发送验证码" style="background: height: 35px; width: 180px; ">
						</div>
							<span id="checkRegister">${requestScope.Error}</span>
					</div>

					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" class="btn btn-primary disabled" width="100" value="注册" id="submit" name="submit" style="background: height: 35px; width: 200px; ">								
							<input type="reset" class="btn btn-primary" width="100" value="重置" id="reset" name="reset" style="background: height: 35px; width: 200px; ">
						</div>
					</div>
				</form>
			</div>

			<div class="col-md-2"></div>

		</div>
	</div>

	<!-- 引入footer.jsp -->
	<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>




