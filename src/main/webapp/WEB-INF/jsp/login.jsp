<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登录</title>
<jsp:include page="easyui.jsp"></jsp:include>
<script type="text/javascript">
function reloadImg(){
	$("#img").attr("src","${pageContext.request.contextPath}/img/img.action?r="+Math.random());
}

function login(){
	//2、做登录操作
	$('#loginForm').form('submit', {    
	    url:"${pageContext.request.contextPath}/system/user/login.action", 
	    onSubmit: function(){
	    	var isValid = $(this).form('validate');
	    	if (isValid){
	    		return checkImgCode(); 
	    	}
	        return false;    
	    }, 
	    success: function(d){
	    	d = $.parseJSON(d);
	       if(d.success){
	    	   window.location.href = "${pageContext.request.contextPath}/page/index.action";
	       }else{
	    	   $.messager.show({
					title:'提示',
					msg: d.message,
					timeout:1000,
					showType:'slide'
				});
	       }  
	    }    
	}); 
}

function checkImgCode(){
	var pass = false;
	$.ajax({
		url : "${pageContext.request.contextPath}/img/imgCode.action",
		type : "post",
		data : {
			imgCode : $("#imgCode").val()
		},
		dataType : "json",
		async : false,//设置ajax为同步提交，为了让代码阻塞，return最后执行
		success : function(d){
			if(d.success){
				pass = true;
			}else{
				$.messager.show({
					title:'提示',
					msg: d.message,
					timeout:1000,
					showType:'slide'
				});
			}
		}
	});
	return pass;
}
</script>
</head>
<body>
	<div class="easyui-dialog" title="&nbsp;登录" style="width: 320px; height: 220px;padding: 10px" data-options="iconCls:'icon-cn',resizable:true,modal:true,closable:false">
		<form id="loginForm" method="post">
			<div style="margin-bottom: 5px">
				<input id="id" type="text" name="id" data-options="iconCls:'icon-man',required:true,prompt:'账号'" class="easyui-textbox" style="width: 100%; height: 30px; padding: 12px">
			</div>
			<div style="margin-bottom: 5px">
				<input id="pwd" type="password" name="password" data-options="iconCls:'icon-lock',required:true" class="easyui-textbox" style="width: 100%; height: 30px; padding: 12px">
			</div>
			<div style="margin-bottom: 5px">
				<input id="imgCode" class="easyui-textbox" type="text" style="width: 45%; height: 30px; padding: 12px" data-options="required:true,prompt:'验证码'" /> <img id="img" style="margin: 0 0 0 3px; vertical-align: middle; height: 26px;" src="${pageContext.request.contextPath}/img/img.action"> <a onclick="reloadImg()" class="easyui-linkbutton" data-options="plain: true, iconCls:'icon-reload'">换一张</a>
			</div>
			<a class="easyui-linkbutton" style="padding: 5px 0px; width: 100%;" onclick="login()"> <span style="font-size: 14px;">登录</span>
			</a>
		</form>
	</div>
</body>
</html>