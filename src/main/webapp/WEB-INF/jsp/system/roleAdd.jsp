<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>角色新增</title>
<jsp:include page="../easyui.jsp"></jsp:include>
<script type="text/javascript">
	function save() {
		$('#roleAddForm').form('submit', {
			url : '${pageContext.request.contextPath}/system/role/add.action',
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
	<form id="roleAddForm" method="post">
		<table style="width: 100%;">
			<tr>
				<td>角色名称</td>
				<td><input id="name" name="name" class="easyui-textbox" style="width: 300px" data-options="required:true"></td>
			</tr>
			<tr>
				<td>角色备注</td>
				<td><textarea id="mark" name="mark" style="width: 300px; border-radius: 5px; border: 1px solid #FFA8A8;"></textarea></td>
			</tr>
			<tr>
				<td>拥有权限</td>
				<td><select id="authids" name="authids" class="easyui-combotree" style="width: 300px;"
					data-options="url:'${pageContext.request.contextPath}/system/auth/combotree.action',required:true,multiple:true"></select></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;"><div style="margin-top: 15px"><a onclick="save()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a></div></td>
			</tr>
		</table>
	</form>
</body>
</html>