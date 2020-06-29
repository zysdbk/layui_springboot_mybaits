<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">


<title>文件上传</title>
    <%@include file="NewFile.jsp"%>
    <meta name="renderer" content="webkit">
 	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=basePath%>/css/layui.css">   

</head>
<body >

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
  <legend>常规使用：普通图片上传</legend>
</fieldset>

<div class="layui-upload">
  <button type="button" class="layui-btn" id="test1">上传图片</button>
  <div class="layui-upload-list" id="image1">
    <img class="layui-upload-img" id="demo1">
    <p id="demoText"></p>
  </div>
</div> 

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
  <legend>选完文件后不自动上传</legend>
</fieldset>
 
<div class="layui-upload" id="file1">
  <button type="button" class="layui-btn layui-btn-normal" id="test8">选择文件</button>
  <button type="button" class="layui-btn" id="test9">开始上传</button>
</div>


<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
  <legend>高级应用：制作一个多文件列表</legend>
</fieldset> 

<div class="layui-upload">
  <button type="button" class="layui-btn layui-btn-normal" id="testList">选择多文件</button> 
  <div class="layui-upload-list">
    <table class="layui-table">
      <thead>
        <tr><th>文件名</th>
        <th>大小</th>
        <th>状态</th>
        <th>操作</th>
      </tr></thead>
      <tbody id="demoList"></tbody>
    </table>
  </div>
  <button type="button" class="layui-btn" id="testListAction">开始上传</button>
</div> 



<script src="<%=basePath%>/js/layui.js"></script>


<script>
layui.use('upload', function(){
	  var $ = layui.jquery
	  ,upload = layui.upload;
	  
	  var href = 'fileUpload'+'/';
	  
	  //普通图片上传
	  var uploadInst = upload.render({
	    elem: '#test1'
	    ,url: '/fileUpload' //改成您自己的上传接口
	    ,acceptMime:'image/*'
	    	//,method: ''  //可选项。HTTP类型，默认post
	    	//,data: {} //可选项。额外的参数，如：{id: 123, abc: 'xxx'}
	    ,before: function(obj){
	      //预读本地文件示例，不支持ie8
	      layer.load();//上传loading
	      obj.preview(function(index, file, result){

	    	   
	    	//obj.resetFile(index, file, '123.jpg'); //重命名文件名，layui 2.3.0 开始新增
	        $('#demo1').attr('src', result); //图片链接（base64）
	        
	      });
	    }
	    ,done: function(res){
	      
	      layer.closeAll('loading');//关闭loading
	      console.log(res.code);

	      if(res.code == 0){
	        
		      var newInput = '<a href='+'"'+href+res.data+'"'+'  download='+'"'+res.data+'"'+' >'+res.data+'</a>';
		      
		      $('#image1').append(newInput);
		    //上传成功
	      }else{
	    	//如果上传失败
	    	  return layer.msg('上传失败');
	    	  
	      }
	      
	    }
	    ,error: function(){
	      //演示失败状态，并实现重传
	      layer.closeAll('loading');//关闭loading
	      var demoText = $('#demoText');
	      demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
	      demoText.find('.demo-reload').on('click', function(){
	        uploadInst.upload();
	      });
	    }
	  });
	  
	  upload.render({
		 
		    elem: '#test8'
		    ,url: '/fileUpload' //改成您自己的上传接口
		    ,auto: false
		    //,multiple: true
		    ,accept:'file'
		    ,bindAction: '#test9'
	    	,before: function(obj){
	  	      layer.load();
	  	    }
		    ,done: function(res){
		    	
		    	layer.closeAll('loading');
			      if(res.code == 0){
				        
				      var newInput = '<a href='+'"'+href+res.data+'"'+'  download='+'"'+res.data+'"'+' >'+res.data+'</a>';
				      
				      $('#file1').append(newInput);
				    //上传成功
			      }else{
			    	//如果上传失败
			    	  return layer.msg('上传失败');
			    	  
			      }
		     
		    }
		});
	  
	  var demoListView = $('#demoList')
	  ,uploadListIns = upload.render({
	    elem: '#testList'
	    ,url: '/fileUpload' //改成您自己的上传接口
	    ,accept: 'file'
	    ,multiple: true
	    ,auto: false
	    ,bindAction: '#testListAction'
	    ,choose: function(obj){
	    	layer.load();
	      var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
	      //读取本地文件
	      obj.preview(function(index, file, result){
	        var tr = $(['<tr id="upload-'+ index +'">'
	          ,'<td>'+ file.name +'</td>'
	          ,'<td>'+ (file.size/1024).toFixed(1) +'kb</td>'
	          ,'<td>等待上传</td>'
	          ,'<td>'
	            ,'<button class="layui-btn layui-btn-xs demo-reload layui-hide">重传</button>'
	            ,'<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
	          ,'</td>'
	        ,'</tr>'].join(''));
	        
	        //单个重传
	        tr.find('.demo-reload').on('click', function(){
	          obj.upload(index, file);
	        });
	        
	        //删除
	        tr.find('.demo-delete').on('click', function(){
	          delete files[index]; //删除对应的文件
	          tr.remove();
	          uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
	        });
	        
	        demoListView.append(tr);
	      });
	    }
	    ,done: function(res, index, upload){
	    	layer.closeAll('loading');
	      if(0 == res.code){ //上传成功
	    	  var newInput = '<a href='+'"'+href+res.data+'"'+'  download='+'"'+res.data+'"'+' >'+res.data+'</a>';
	        var tr = demoListView.find('tr#upload-'+ index)	        
	        ,tds = tr.children();
	        tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
	        tds.eq(3).html(newInput); //清空操作
		      
		      
		    

	        return delete this.files[index]; //删除文件队列已经上传成功的文件
	      }
	      this.error(index, upload);
	    }
	    ,error: function(index, upload){
	    	layer.closeAll('loading');
	      var tr = demoListView.find('tr#upload-'+ index)
	      ,tds = tr.children();
	      tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
	      tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //显示重传
	    }
	  });
});		  
</script>
</body>
</html>