<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>ChinaZ</title>
<%
if(session.getAttribute("sessionId") != null){
	
	response.sendRedirect("mainSheet");
}
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<script src="<%=basePath%>/js/vue.min.js"></script>
<script src="<%=basePath%>/js/vue-resource.min.js"></script>
<link href="<%=basePath%>/css/style.css" rel='stylesheet' type='text/css' />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="App Loction Form,Login Forms,Sign up Forms,Registration Forms,News latter Forms,Elements"./>
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
</script>

</head>
<body>
	<h1>App Location Form</h1>
		<div class="app-location"  id="app">
			<h2>Welcome to Locaticus</h2>
			<div class="line"><span></span></div>
			<div class="location"><img src="<%=basePath%>/images/logo.png" class="img-responsive" alt="" /></div>
		 	
				<input v-model.trim="name" type="text" class="text"  >
				<input v-model.trim="password" type="password" >
				<div style="color: white" v-model.trim="message">{{ message }}</div>
				<div class="submit"><input type="submit" @click="logon" value="登录" ></div>
				<div class="clear"></div>				
				<div class="new">
					<h3><a href="#">忘记密码 ?</a></h3>
					<h4><a href="/register">注册</a></h4>
					<div class="clear"></div>
				</div>
			

	</div>
	<!--start-copyright-->
   		<div class="copy-right">
				<p>Copyright &copy; 2015.Company name All rights reserved.</p>
		</div>
	<!--//end-copyright-->
	
	<script>

var vm = new Vue({
	el: '#app',
	  data: {
		  //初始值
		  
			  name:'',
			  password:'',
			  message:''
			  
			  
	  },
		methods:{
			

			
			logon:function(){
				var _this = this;
				var Check = /^\w{6,16}$/;
				
		       if(Check.test(_this.name) && Check.test(_this.password)) {
					var user=new Object();
					user.name=_this.name;
					user.password=_this.password;
					alert("user："+JSON.stringify(user));
					//var str=JSON.stringify(user);
		            this.$http.post('/logon',user,{emulateJSON:true})
		            .then(function(res){
	                    console.log(res.text());
	                    _this.message = "";	                    
	                    window.location.href="${pageContext.request.contextPath}/mainSheet";
	                },function(res){
	                    console.log(res.status);
	                    return _this.message = "用户名或密码错误";
	                })
		           	
		
		       }else{
		    	   
		    	   
		    	   return _this.message = '请输入6-16位由数字、字母、下划线组成的用户名和密码';
		    	   
		       }

			}
		}
	})



</script>
	
</body>
</html>