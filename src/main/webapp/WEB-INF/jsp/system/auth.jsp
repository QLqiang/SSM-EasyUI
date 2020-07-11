<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>权限设置</title>
<jsp:include page="../easyui.jsp"></jsp:include>
<script type="text/javascript">
	$(function() {
		$('#authTable').treegrid({
			url : '${pageContext.request.contextPath}/system/auth/query.action',
			idField : 'id',
			treeField : 'name',
			border : false,
			toolbar : [ {
				iconCls : 'icon-add',
				text : '新增',
				handler : function() {
					add()
				}
			}, '-', {
				iconCls : 'icon-edit',
				text : '修改',
				handler : function() {
					edit()
				}
			}, '-', {
				iconCls : 'icon-remove',
				text : '删除',
				handler : function() {
					remove()
				}
			} ],
			columns : [ [ {
				title : 'id',
				field : 'id',
				hidden : true,
				width : 180
			}, {
				field : 'name',
				title : '权限名称',
				width : 200
			}, {
				field : 'mark',
				title : '备注',
				width : 200
			}, {
				field : 'url',
				title : '权限地址',
				width : 300
			}, {
				field : 'seq',
				title : '排序',
				width : 50
			} ] ]
		});
	});

	function add() {
		$('#authAddDiv').panel('open');
		$("#authAddIframe").attr("src", "${pageContext.request.contextPath}/system/auth/authAdd.action");
	}

	function edit() {
		var rows = $('#authTable').treegrid('getChecked');
		if (rows.length == 1) {
			$('#authEditDiv').panel('open');
			$("#authEditIframe").attr("src", "${pageContext.request.contextPath}/system/auth/authEdit.action?id=" + rows[0].id);
		} else {
			$.messager.alert('消息', '请选一条需要修改的数据！', 'info');
		}
	}
	
	function remove() {
		var rows = $('#authTable').treegrid('getChecked');
		if (rows.length > 0) {
			$.messager.confirm('确认', '确定删除数据吗？', function(r) {
				if (r) {
					$.ajax({
						url : '${pageContext.request.contextPath}/system/auth/remove.action',
						type : 'post',
						data : {
							id : rows[0].id
						},
						dataType : 'json',
						success : function(d) {
							if (d.success) {
								query();
							}
							$.messager.show({
								title : '消息',
								msg : d.message,
								timeout : 1000
							});
						}
					});
				}
			});
		} else {
			$.messager.alert('消息', '请选需要删除的数据！', 'info');
		}
	}

	function closeAdd() {
		$('#authAddDiv').panel('close');
	}
	function closeEdit() {
		$('#authEditDiv').panel('close');
	}

	function query() {
		$('#authTable').treegrid('load');
	}
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',border:false,fit:true">
		<table id="authTable"></table>
	</div>
	<div id="authAddDiv" class="easyui-dialog" title="权限新增" style="width: 540px; height: 290px;" data-options="iconCls:'icon-add',resizable:true,modal:true,closed:true">
		<iframe id="authAddIframe" style='width: 100%; height: 98%; border: 0px;' src=''></iframe>
	</div>
	<div id="authEditDiv" class="easyui-dialog" title="权限修改" style="width: 540px; height: 290px;" data-options="iconCls:'icon-add',resizable:true,modal:true,closed:true">
		<iframe id="authEditIframe" style='width: 100%; height: 98%; border: 0px;' src=''></iframe>
	</div>
</body>
</html>