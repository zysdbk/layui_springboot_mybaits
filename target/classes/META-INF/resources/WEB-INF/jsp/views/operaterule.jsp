<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>layui.form小例子</title>
<%@include file="../NewFile.jsp"%>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="<%=basePath%>/css/layui.css">
<link rel="stylesheet" href="<%=basePath%>/css/view.css"/>     
<style>
	body {
		margin: 10px;
	}
	
	.demo-carousel {
		height: 200px;
		line-height: 200px;
		text-align: center;
	}
	
	.table_th_search+div.layui-table-view .layui-table-header div.layui-table-cell
		{
		height: auto;
	}
	
	.layui-table-cell, .layui-table-tool-panel li {
		overflow: visible !important;
	}
	
	.layui-form-select .layui-input {
		height: 30px;
	}
	
	.layui-table-box {
		overflow: visible !important;
	}
	
	.layui-table-body {
		overflow: visible !important;
	}
</style> 
</head>
<body >


<table class="layui-hide table_th_search"  id="demo" lay-filter="test"></table>



<script src="<%=basePath%>/js/layui.js"></script>
<script type="text/html" id="toolbarDemo">
  <div class="layui-btn-container">
	<button class="layui-btn layui-btn-sm" lay-event="save">保存</button>
    <button class="layui-btn layui-btn-sm" lay-event="add">添加</button>
    <button class="layui-btn layui-btn-sm" lay-event="delete">删除</button>
	<button class="layui-btn layui-btn-sm" lay-event="export">导出</button>
  </div>
</script>


<script type="text/html" id="selectTpl">

	<select name="role" class="layui-input type" lay-filter="type">
          <option value="">请选择角色</option>
          <option value="admin">admin</option>
          <option value="normalUser">normalUser</option>
	</select>      

</script>


<script>
layui.use(['layer', 'form', 'table'], function(){
	  var $ = layui.jquery;
	  var table = layui.table;
	  var form = layui.form;
	  var elment = layui.element;
	  var dataBak = [];
	  var editData = [];
	  var searchData = new Object();
	  var searchUsers = [];	
	  

	 	
	  //第一个实例
var ins1 = table.render({
	    elem: '#demo'
	    ,toolbar: '#toolbarDemo'
	    ,page:false
	    ,id:'demo'
	    ,url: '/allUser' //数据接口
	    ,cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
	    ,initSort: {
	        field: 'id' //排序字段，对应 cols 设定的各字段名
	            ,type: 'asc' //排序方式  asc: 升序、desc: 降序、null: 默认排序
	     }
	  	
	    ,cols: [[ //表头
	    	{type: 'checkbox'}
	      ,{field: 'id', title: 'ID',  fixed: 'left',hide:'true'}
	      ,{field: 'name', title: '用户名<br><input class="layui-input"  id="name" autocomplete="off">',sort:true,edit: 'text'}
	      ,{field: 'role',templet:'#selectTpl', title: '角色<br><input class="layui-input"  id="name" autocomplete="off">',sort:true}
	    ]]
	    ,parseData: function(res){ //res 即为原始返回的数据
	    	
	        return {
	            "code": res.status, //解析接口状态
	            "msg": res.message, //解析提示文本
	            "count": res.total, //解析数据长度
	            "data": res.data //解析数据列表
	          };
	        }
	    ,done: function(res, curr, count){
	    	this.where={};
	    	
            layui.each($('select'), function (index, item) {//对象（Array、Object、DOM 对象等）遍历，可用于取代for语句
                var elem = $(item);               
                
               elem.val(res.data[index].role);
            });
	    	form.render();
	        //如果是异步请求数据方式，res即为你接口返回的信息。
	        //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
	        /*console.log(res);
	        
	        //得到当前页码
	        console.log(curr); 
	        
	        //得到数据总量
	        console.log(count);*/
	      }
	    
	  });
	  
	form.on('select', function (obj) {
		
        var elem = $(obj.elem);
        var trElem = elem.parents('tr');
        var tableData = table.cache['demo'];
        
        // 更新到表格的缓存数据中，才能在获得选中行等等其他的方法中得到更新之后的值
        tableData[trElem.data('index')][elem.attr('name')] = obj.value;
        
	});

	  
});
</script>
</body>
</html>