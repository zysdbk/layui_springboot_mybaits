<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <%@include file="NewFile.jsp"%>
    <link rel="stylesheet" href="<%=basePath%>/css/layui.css">
    <link rel="stylesheet" href="<%=basePath%>/css/admin.css">
    <link rel="icon" href="/favicon.ico">
    <title>管理后台</title>
</head>
<body class="layui-layout-body">
    <div class="layui-layout layui-layout-admin">
        <div class="layui-header custom-header">
            
            <ul class="layui-nav layui-layout-left">
                <li class="layui-nav-item slide-sidebar" lay-unselect>
                    <a href="javascript:;" class="icon-font"><i class="ai ai-menufold"></i></a>
                </li>
            </ul>

            <ul class="layui-nav layui-layout-right">
                <li class="layui-nav-item">
                    <a href="javascript:;">${sessionScope.name}</a>
                    <dl class="layui-nav-child">
                        <dd><a href="">帮助中心</a></dd>
                        <dd><a href="${pageContext.request.contextPath}/logout">退出</a></dd>
                    </dl>
                </li>
            </ul>
        </div>

        <div class="layui-side custom-admin">
            <div class="layui-side-scroll">

                <div class="custom-logo">
                    <img src="<%=basePath%>/images/logo.png" alt=""/>
                    <h1>Admin Pro</h1>
                </div>
                <ul id="Nav" class="layui-nav layui-nav-tree">
                    <li class="layui-nav-item">
                        <a href="javascript:;">
                            <i class="layui-icon">&#xe609;</i>
                            <em>主页</em>
                        </a>
                        <dl class="layui-nav-child">
                            <dd><a href="console">控制台</a></dd>
                        </dl>
                    </li>
                    <li class="layui-nav-item">
                        <a href="javascript:;">
                            <i class="layui-icon">&#xe857;</i>
                            <em>组件</em>
                        </a>
                        <dl class="layui-nav-child">
                            <dd><a href="form">表单</a></dd>
                            <dd>
                                <a href="filesUpload">文件上传</a>
                            </dd>
                        </dl>
                    </li>
                    <li class="layui-nav-item" id="admin" >
                        <a href="javascript:;">
                            <i class="layui-icon">&#xe612;</i>
                            <em>用户</em>
                        </a>
                        <dl class="layui-nav-child">
                            <dd><a href="users">用户组</a></dd>
                            <dd><a href="operaterule">权限配置</a></dd>
                        </dl>
                    </li>
                </ul>

            </div>
        </div>

        <div class="layui-body">
             <div class="layui-tab app-container" lay-allowClose="true" lay-filter="tabs">
                <ul id="appTabs" class="layui-tab-title custom-tab"></ul>
                <div id="appTabPage" class="layui-tab-content"></div>
            </div>
        </div>

        <div class="layui-footer">
            <p>annotation</p>
        </div>

        <div class="mobile-mask"></div>
    </div>

    <script src="<%=basePath%>/js/layui.js"></script>
    <script src="<%=basePath%>/js/index.js" data-main="<%=basePath%>/js/home"></script>

	<script type="text/javascript">
	layui.use(['jquery', 'layer'], function(){	
		var $ = layui.$;
		var role = "<%=session.getAttribute("role")%>";
		if(role == "admin"){
			
			
		}else{
			
			$('#admin').hide();
		}
	})
	</script>
</body>
</html>