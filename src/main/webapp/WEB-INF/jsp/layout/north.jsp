<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	$.extend($.fn.validatebox.defaults.rules, {
		equals : {
			validator : function(value, param) {
				return value == $(param[0]).val();
			},
			message : '两次密码不一致'
		}
	});
</script>
<script type="text/javascript">
	function login() {
		$('#loginForm').form('submit', {
			url : "${pageContext.request.contextPath}/system/user/login.action",
			success : function(d) {
				d = $.parseJSON(d);
				if (d.success) {
					$('#loginDiv').panel('close');
				} else {
					$.messager.show({
						title : '提示',
						msg : d.message,
						timeout : 1000,
						showType : 'slide'
					});
				}
			}
		});
	}

	function logout() {
		$.ajax({
			url : "${pageContext.request.contextPath}/system/user/logout.action",
			type : "post",
			dataType : "json",
			success : function(d) {
				if (d.success) {
					window.location.href = "${pageContext.request.contextPath}/page/login.action";
				}
			}
		});
	}

	function showEditPassword() {
		$('#editPassowrdForm').form('reset');
		$('#pwd_div').panel('open');
	}

	function editPassword() {
		$('#editPassowrdForm').form('submit', {
			url : "${pageContext.request.contextPath}/system/user/editPassword.action",
			success : function(d) {
				d = $.parseJSON(d);
				if (d.success) {
					$('#pwd_div').panel('close');
				}
				$.messager.show({
					title : '提示',
					msg : d.message,
					timeout : 1000,
					showType : 'slide'
				});
			}
		});
	}

	function showLogin() {
		$('#loginForm').form('reset');
		$('#loginDiv').panel('open');
		$.ajax({
			url : "${pageContext.request.contextPath}/system/user/logout.action",
			type : "post",
			dataType : "json",
			success : function(d) {
			}
		});
	}
</script>
<div>
	<div style="float: left;">
		<img height="54" width="200" alt="中软国际" src="${pageContext.request.contextPath}/img/logo.jpg">
	</div>
	<div style="float: right; margin-top: 20px">
		<a href="javascript:void(0)" id="mb" class="easyui-menubutton" data-options="menu:'#mm',iconCls:'icon-man'">${user.name}</a>
		<div id="mm" style="width: 150px;">
			<div data-options="iconCls:'icon-edit'" onclick="showEditPassword()">修改密码</div>
			<div class="menu-sep"></div>
			<div data-options="iconCls:'icon-lock'" onclick="showLogin()">锁定账号</div>
			<div data-options="iconCls:'icon-close'" onclick="logout()">退出系统</div>
		</div>
	</div>
</div>
<div id="pwd_div" class="easyui-dialog" title="修改密码" style="width: 400px; height: 193px;"
	data-options="iconCls:'icon-edit',resizable:true,modal:true,closed:true,buttons:[{
				text:'修改',
				iconCls:'icon-edit',
				handler:function(){editPassword()}
			}]">
	<form id="editPassowrdForm" method="post">
		<div style="margin-top: 5px">
			原来密码：<input id="oldPassword" type="password" name="oldPassword" data-options="iconCls:'icon-lock',required:true" class="easyui-textbox"
				style="width: 80%; height: 30px; padding: 12px">
		</div>
		<div style="margin-top: 5px">
			新的密码：<input id="newPassword" type="password" name="newPassword" data-options="iconCls:'icon-lock',required:true" class="easyui-textbox"
				style="width: 80%; height: 30px; padding: 12px">
		</div>
		<div style="margin-top: 5px">
			确认密码：<input id="repPassword" type="password" name="repPassword" data-options="iconCls:'icon-lock',required:true,validType:'equals[\'#newPassword\']'" class="easyui-textbox"
				style="width: 80%; height: 30px; padding: 12px">
		</div>
	</form>
</div>
<div id="loginDiv" class="easyui-dialog" title="&nbsp;登录" style="width: 320px; height: 175px; padding: 10px"
	data-options="iconCls:'icon-cn',resizable:true,modal:true,closable:false,closed:true">
	<form id="loginForm" method="post">
		<div style="margin-bottom: 5px">
			<input id="id" type="text" name="id" data-options="iconCls:'icon-man',required:true,prompt:'账号'" class="easyui-textbox" style="width: 100%; height: 30px; padding: 12px">
		</div>
		<div style="margin-bottom: 5px">
			<input id="pwd" type="password" name="password" data-options="iconCls:'icon-lock',required:true" class="easyui-textbox" style="width: 100%; height: 30px; padding: 12px">
		</div>
		<a class="easyui-linkbutton" style="padding: 5px 0px; width: 100%;" onclick="login()"> <span style="font-size: 14px;">登录</span>
		</a>
	</form>
</div>