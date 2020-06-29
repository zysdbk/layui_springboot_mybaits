<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>layui.form小例子</title>
<%
if(session.getAttribute("sessionId") != null){
	
	response.sendRedirect("mainSheet");
}
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
    
    <link rel="stylesheet" href="<%=basePath%>/css/layui.css">
    <link rel="stylesheet" href="<%=basePath%>/css/view.css"/>
    
    
</head>
<body class="layui-view-body" 
background="<%=basePath%>/images/background.jpg"";
style="height:500px; width:500px; margin:200px auto auto auto;">
<div class="layui-content" >	
	<div class="layui-row">
	<div class="layui-card" >
	<div class="layui-card-header">注册</div>
	<form class="layui-form layui-card-body "  method="post">
		<!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
		<div class="layui-form-item" >
			<label class="layui-form-label">用户名</label>
			<div class="layui-input-block">
				<input  type="text" name="name" lay-verify="name|required" class="layui-input" placeholder="">
			</div>
			
		</div>
				<div class="layui-form-item" >
			<label class="layui-form-label">密码</label>
			<div class="layui-input-block">
				<input  type="password" name="password" lay-verify="password|required" class="layui-input" placeholder="">
			</div>
			
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button><br>
			</div>
		</div>

	</form>
	</div>
	</div>
</div>
	<script src="<%=basePath%>/js/layui.js"></script>
<script>
	layui.use('form', function() {
		var form = layui.form;
		var $$ = layui.jquery;
		
		//监听提交
		form.on('submit(formDemo)', function(data) {
			console.log(data.field)
			var user=new Object();
			user.name=data.field.name;
			user.password=data.field.password;
			

            
			$$.ajax({
              url:"/add",
              data:user,
              type:"Post",
              dataType:"text",
              success:function(data){
                console.log(data);
                if(data == "success"){  
                	alert('注册成功');
                	window.location.href="${pageContext.request.contextPath}/mainSheet";
                	
                }else{
                	
                	layer.msg('该用户名已被注册');
                	
                }
                 
                
              },
              error:function(data){
            	  
            	  layer.msg('服务器内部错误，请联系管理员');
                  
              }
          	});
			 return false;        
			
			
		});
		
		
		form.verify({
			  name:[
				    /^[\S]{5,12}$/  
				    ,'用户名必须6到12位，且不能出现空格'
				  ] 

			  ,password: [
			    /^[\S]{5,12}$/  
			    ,'密码必须6到12位，且不能出现空格'
			  ] 
			});   
	});
</script>
</body>
</html>