<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>批量导入</title>
<jsp:include page="../easyui.jsp"></jsp:include>
<script type="text/javascript">
	function imp() {
		$('#impForm').form('submit', {
			url : '${pageContext.request.contextPath}/system/user/imp.action',
			success : function(d) {
				d = $.parseJSON(d);
				if (d.success) {
					parent.closeImp();
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
<body>
	<form id="impForm" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td><a href="${pageContext.request.contextPath}/file/user.xls">模板下载</a></td>
				<td><input name = "userFile" class="easyui-filebox" style="width: 300px"></td>
				<td><a onclick="imp()" class="easyui-linkbutton">上传</a></td>
			</tr>
		</table>
	</form>
</body>
</html>