<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>layui.form小例子</title>
    <%@include file="NewFile.jsp"%>
    <meta name="renderer" content="webkit">
 	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=basePath%>/css/layui.css">
    <link rel="stylesheet" href="<%=basePath%>/css/view.css"/>      
</head>
<body >

<table class="layui-hide"  id="demo" lay-filter="test"></table>



<script src="<%=basePath%>/js/layui.js"></script>
<script type="text/html" id="toolbarDemo">
  <div class="layui-btn-container">
	<button class="layui-btn layui-btn-sm" lay-event="save">保存</button>
    <button class="layui-btn layui-btn-sm" lay-event="add">添加</button>
    <button class="layui-btn layui-btn-sm" lay-event="delete">删除</button>
	<button class="layui-btn layui-btn-sm" lay-event="export">导出</button>
  </div>
</script>
<script>
layui.use('table', function(){
	  var $ = layui.jquery;
	  var table = layui.table;
	  var dataBak = [];
	  var editData = [];
	 
	  //第一个实例
var ins1 = table.render({
	    elem: '#demo'
	    ,toolbar: '#toolbarDemo'
	    ,height: 312
	    ,width: 500	    	
	    ,url: '/allUser' //数据接口
	    
	    ,initSort: {
	        field: 'id' //排序字段，对应 cols 设定的各字段名
	            ,type: 'asc' //排序方式  asc: 升序、desc: 降序、null: 默认排序
	     }
	  	
	    ,cols: [[ //表头
	    	{type: 'checkbox', fixed: 'left'}
	      ,{field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
	      ,{field: 'name', title: '用户名', width:200 , edit: 'text'}
	      ,{field: 'password', title: '密码', width:200, sort: true, edit: 'text'}
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
	        //如果是异步请求数据方式，res即为你接口返回的信息。
	        //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
	        console.log(res);
	        
	        //得到当前页码
	        console.log(curr); 
	        
	        //得到数据总量
	        console.log(count);
	      }
	  });
	  
	
	  table.on('toolbar(test)', function(obj){
		  var checkStatus = table.checkStatus(obj.config.id);
		  var tableBak = table.cache.demo;
		  var i = 0;
		  
		  
		  switch(obj.event){
	      case 'add':
	          var data = checkStatus.data;
	          layer.alert(JSON.stringify(data));
	          var index = layer.open({
	        	  type: 2,
	        	  content: '/addUser',//这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
	        	  area:['600px','350px']
	        	});

	        break;
	        case 'delete':
	          var data = checkStatus.data;
	          console.log(data);
	          for( i = 0; i < data.length; i++){
	        	  dataHandle("/delete","id="+data[i].id);	        	  
	          }
	          refresh();
	          
	        break;
	        case 'save':
	          //layer.msg(checkStatus.isAll ? '全选': '未全选')
	          for( i = 0; i < editData.length; i++){
	        	  dataHandle("/update",editData[i]);	    			
	          }
	          editData = [];
	          refresh();
	        break;
	        case 'export':
	        	for ( i = 0; i < tableBak.length; i++) {
		    	    dataBak.push(tableBak[i]);      //将之前的数组备份
		    	}
	        	table.exportFile(ins1.config.id, dataBak, 'xls');
		    break;
	        
		  };
		});
	  	
	  table.on('edit(test)', function(obj){ //注：edit是固定事件名，test是table原始容器的属性 lay-filter="对应的值"

		 
		  editData.push(obj.data);
		  console.log(editData);
		});
			  
	  	
	  function dataHandle(url,data){
			$.ajax({
	              url: url,
	              data:data,
	              type:"Post",
	              dataType:"text",
	              success:function(data){	    	                 
	                
	              },
	              error:function(data){
	            	  
	            	  layer.msg('服务器内部错误，请联系管理员');
	                  
	              }
	          	});
		  
	  }
			  
	   function refresh(){
		   
	    	table.reload('demo',{
	    		 
	    		url: '/allUser'
	    		
	    		,parseData: function(res){ //res 即为原始返回的数据
	    	    	
	    	        return {
	    	            "code": res.status, //解析接口状态
	    	            "msg": res.message, //解析提示文本
	    	            "count": res.total, //解析数据长度
	    	            "data": res.data //解析数据列表
	    	          };
	    	        }
	    	});
	   }
	  
});
</script>
</body>
</html>