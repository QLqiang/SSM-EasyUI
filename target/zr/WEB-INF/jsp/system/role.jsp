<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户</title>
<jsp:include page="../easyui.jsp"></jsp:include>
<script type="text/javascript">
	$(function() {
		$('#dg').datagrid({
			url : '${pageContext.request.contextPath}/system/role/query.action',
			fit : true,
			border : false,
			striped : true,
			nowrap : false,
			pagination : true,
			sortName : 'id',
			sortOrder : 'asc',
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
			frozenColumns : [ [ {
				field : 'checkbox',
				title : 'ID',
				checkbox : true
			}, {
				field : 'id',
				title : 'ID',
				width : 100,
				sortable : true,
				hidden:true
			}, {
				field : 'name',
				title : '角色名称',
				width : 100
			} ] ],
			columns : [ [ {
				field : 'mark',
				title : '备注',
				width : 300
			},{
				field : 'auths',
				title : '拥有权限',
				width : 500,
				formatter : function(value, row, index) {
					var auths = [];
					if(value){
						for(var i = 0 ; i < value.length; i++){
							auths.push(value[i].name);
						}
					}
					return auths.join(",");
				}
			}, {
				field : 'createid',
				title : '新增人员',
				width : 100
			}, {
				field : 'createtime',
				title : '新增时间',
				width : 150,
				sortable : true
			}, {
				field : 'modifyid',
				title : '修改人员',
				width : 100
			}, {
				field : 'modifytime',
				title : '修改时间',
				width : 150
			} ] ]
		});
	});

	function query() {
		$('#dg').datagrid('load', {
			id : $("#id").val(),
			name : $("#name").val(),
			status : $("#status").val()
		});
	}

	function add() {
		$('#roleAddDiv').panel('open');
		$("#roleAddIframe").attr("src","${pageContext.request.contextPath}/system/role/roleAdd.action");
	}
	
	function edit() {
		var rows = $('#dg').datagrid('getChecked');
		if (rows.length == 1) {
			$('#roleEditDiv').panel('open');
			$("#roleEditIframe").attr("src","${pageContext.request.contextPath}/system/role/roleEdit.action?id=" + rows[0].id);
		}else{
			$.messager.alert('消息', '请选一条需要修改的数据！', 'info');
		}
	}
	
	function closeAdd() {
		$('#roleAddDiv').panel('close');
	}
	function closeEdit() {
		$('#roleEditDiv').panel('close');
	}

	function remove() {
		var rows = $('#dg').datagrid('getChecked');
		if (rows.length > 0) {
			$.messager.confirm('确认', '确定删除数据吗？', function(r) {
				if (r) {
					var ids = [];
					for (var i = 0; i < rows.length; i++) {
						ids.push(rows[i].id);
					}
					$.ajax({
						url : '${pageContext.request.contextPath}/system/role/remove.action',
						type : 'post',
						data : {
							ids : ids.join(",")
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
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',title:'数据',border:false">
		<table id="dg"></table>
	</div>
	<div id="roleAddDiv" class="easyui-dialog" title="角色新增" style="width: 540px; height: 250px;" data-options="iconCls:'icon-add',resizable:true,modal:true,closed:true">
		<iframe id="roleAddIframe" style='width:100%;height:98%;border:0px;' src=''></iframe>
	</div>
	<div id="roleEditDiv" class="easyui-dialog" title="角色修改" style="width: 540px; height: 250px;" data-options="iconCls:'icon-edit',resizable:true,modal:true,closed:true">
		<iframe id="roleEditIframe" style='width:100%;height:98%;border:0px;overflow: hidden;' src=''></iframe>
	</div>
</body>
</html>
