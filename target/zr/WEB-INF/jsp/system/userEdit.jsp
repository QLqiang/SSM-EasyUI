<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户新增</title>
<jsp:include page="../easyui.jsp"></jsp:include>
<script type="text/javascript">
	$.extend($.fn.validatebox.defaults.rules, {
		equalsPwd : {
			validator : function(value, param) {
				return value == $(param[0]).val();
			},
			message : '两次密码不一致'
		}
	});
</script>
<script type="text/javascript">
	function save() {
		$('#userAddForm').form('submit', {
			url : '${pageContext.request.contextPath}/system/user/edit.action',
			success : function(d) {
				d = $.parseJSON(d);
				if (d.success) {
					parent.closeEdit();
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
				<td><input id="id" name="id" value="${u.id}" style="width: 300px; border: 0px; font-size: 14px;" data-options="required:true" readonly="readonly"></td>
			</tr>
			<tr>
				<td>姓名</td>
				<td><input id="name" name="name" value="${u.name}" class="easyui-textbox" style="width: 300px" data-options="required:true"></td>
			</tr>
			<tr>
				<td>密码</td>
				<td><input id="password" name="password" type="password" class="easyui-textbox" style="width: 300px"></td>
			</tr>
			<tr>
				<td>确认</td>
				<td><input id="repPassword" name="repPassword" type="password" class="easyui-textbox" style="width: 300px" data-options="validType:'equalsPwd[\'#password\']'"></td>
			</tr>
			<tr>
				<td>角色</td>
				<td>
					<input value="${u.roleStr}" id="roleids" name="roleids" class="easyui-combobox" style="width: 300px" data-options="valueField:'id',textField:'name',url:'${pageContext.request.contextPath}/system/role/combobox.action',panelMaxHeight:100,editable:false,multiple:true" />
				</td>
			</tr>
			<tr>
				<td>状态</td>
				<td><select id="status" class="easyui-combobox" name="status" data-options="panelHeight:80,editable:false" style="width: 300px;">
						<option value="0" <c:if test="${u.status == '0'}">selected="selected"</c:if> >正常</option>
						<option value="1" <c:if test="${u.status == '1'}">selected="selected"</c:if> >锁定</option>
				</select></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;"><div style="margin-top: 15px"><a onclick="save()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a></div></td>
			</tr>
		</table>
	</form>
</body>
</html>