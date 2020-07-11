<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户新增</title>
<jsp:include page="../easyui.jsp"></jsp:include>
<script type="text/javascript">
$.extend($.fn.validatebox.defaults.rules, {    
    equalsPwd: {    
        validator: function(value,param){    
            return value == $(param[0]).val();    
        },    
        message: '两次密码不一致'   
    }    
});
$.extend($.fn.validatebox.defaults.rules, {    
	checkid: {    
        validator: function(value){
        	var boo = true;
        	$.ajax({
				url : '${pageContext.request.contextPath}/system/user/checkid.action',
				type : 'post',
				data : {
					id : value
				},
				dataType : 'json',
				async : false,
				success : function(d) {
					if (d.success) {
						boo = false;
					}
				}
			});
            return boo;    
        },    
        message: '此用户名已被占用'   
    }    
});
</script>
<script type="text/javascript">
	function save() {
		$('#userAddForm').form('submit', {
			url : '${pageContext.request.contextPath}/system/user/add.action',
			success : function(d) {
				d = $.parseJSON(d);
				if (d.success) {
					parent.closeAdd();
					parent.query();
				}
				parent.$.messager.show({
					title : '提示',
					msg : d.message,
					timeout : 1000,
					showType : 'slide'
				});
			}
		});
	}
</script>
</head>
<body style="text-align: center;">
	<form id="userAddForm" method="post">
		<table style="width: 100%;">
			<tr>
				<td>账号</td>
				<td><input id="id" name="id" class="easyui-textbox" style="width: 300px" data-options="required:true,validType:'checkid'"></td>
			</tr>
			<tr>
				<td>姓名</td>
				<td><input id="name" name="name" class="easyui-textbox" style="width: 300px" data-options="required:true"></td>
			</tr>
			<tr>
				<td>密码</td>
				<td><input id="password" name="password" type="password" class="easyui-textbox" style="width: 300px" data-options="required:true"></td>
			</tr>
			<tr>
				<td>确认</td>
				<td><input id="repPassword" name="repPassword" type="password" class="easyui-textbox" style="width: 300px" data-options="required:true,validType:'equalsPwd[\'#password\']'"></td>
			</tr>
			<tr>
				<td>角色</td>
				<td>
					<input id="roleids" name="roleids" class="easyui-combobox" style="width: 300px" data-options="valueField:'id',textField:'name',url:'${pageContext.request.contextPath}/system/role/combobox.action',panelMaxHeight:100,editable:false,multiple:true" />
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;"><div style="margin-top: 15px"><a onclick="save()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a></div></td>
			</tr>
		</table>
	</form>
</body>
</html>