<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>权限新增</title>
<jsp:include page="../easyui.jsp"></jsp:include>
<script type="text/javascript">
	function save() {
		$('#authAddForm').form('submit', {
			url : '${pageContext.request.contextPath}/system/auth/add.action',
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
	<form id="authAddForm" method="post">
		<table style="width: 100%;">
			<tr>
				<td>上级权限</td>
				<td><select id="pid" name="pid" class="easyui-combotree" style="width: 300px;"
					data-options="url:'${pageContext.request.contextPath}/system/auth/combotree.action',required:true"></select></td>
			</tr>
			<tr>
				<td>权限名称</td>
				<td><input id="name" name="name" class="easyui-textbox" style="width: 300px" data-options="required:true"></td>
			</tr>
			<tr>
				<td>权限备注</td>
				<td><input id="mark" name="mark" class="easyui-textbox" style="width: 300px" data-options="required:true"></td>
			</tr>
			<tr>
				<td>权限URL</td>
				<td><input id="url" name="url" type="text" class="easyui-textbox" style="width: 300px" data-options="required:true"></td>
			</tr>
			<tr>
				<td>权限排序</td>
				<td><input id="seq" name="seq" type="text" class="easyui-textbox" style="width: 300px" data-options="required:true"></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;"><div style="margin-top: 15px">
						<a onclick="save()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
					</div></td>
			</tr>
		</table>
	</form>
</body>
</html>