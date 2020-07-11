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
			url : '${pageContext.request.contextPath}/system/user/query.action',
			fit : true,
			border : false,
			pagination : true,
			striped : true,
			nowrap : false,
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
			}, '-', {
				iconCls : 'icon-lock',
				text : '重置密码',
				handler : function() {
					restPwd()
				}
			} ],
			frozenColumns : [ [ {
				field : 'checkbox',
				title : '账号',
				checkbox : true
			}, {
				field : 'id',
				title : '账号',
				width : 100,
				sortable : true
			}, {
				field : 'name',
				title : '名称',
				width : 100,
				sortable : true
			} ] ],
			columns : [ [ {
				field : 'password',
				title : '密码',
				width : 100,
				formatter : function(value, row, index) {
					return "******";
				}
			},{
				field : 'roles',
				title : '角色',
				width : 300,
				formatter : function(value, row, index) {
					var roles = [];
					if(value){
						for(var i = 0 ; i < value.length; i++){
							roles.push(value[i].name);
						}
					}
					return roles.join(",");
				}
			}, {
				field : 'status',
				title : '状态',
				width : 100,
				formatter : function(value, row, index) {
					return value == 0 ? "正常" : "锁定";
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
		$('#userAddDiv').panel('open');
		$("#userAddIframe").attr("src","${pageContext.request.contextPath}/system/user/userAdd.action");
	}
	
	function edit() {
		var rows = $('#dg').datagrid('getChecked');
		if (rows.length == 1) {
			$('#userEditDiv').panel('open');
			$("#userEditIframe").attr("src","${pageContext.request.contextPath}/system/user/userEdit.action?id=" + rows[0].id);
		}else{
			$.messager.alert('消息', '请选一条需要修改的数据！', 'info');
		}
	}
	
	function closeAdd() {
		$('#userAddDiv').panel('close');
	}
	function closeEdit() {
		$('#userEditDiv').panel('close');
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
						url : '${pageContext.request.contextPath}/system/user/remove.action',
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
	
	function restPwd(){
		var rows = $('#dg').datagrid('getChecked');
		if (rows.length > 0) {
			$.messager.confirm('确认', '确定重置密码吗？', function(r) {
				if (r) {
					var ids = [];
					for (var i = 0; i < rows.length; i++) {
						ids.push(rows[i].id);
					}
					$.ajax({
						url : '${pageContext.request.contextPath}/system/user/resetPassword.action',
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
			$.messager.alert('消息', '请选需要操作的数据！', 'info');
		}
	}
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',title:'查询',border:false" style="height: 80px;">
		<div style="margin-top: 6px;">
			<table>
				<tr>
					<td>账号<input id="id" class="easyui-textbox" style="width: 150px"></td>
					<td>名称<input id="name" class="easyui-textbox" style="width: 150px"></td>
					<td>状态</td>
					<td><select id="status" class="easyui-combobox" data-options="editable:false" style="width: 150px;">
							<option value="">全部</option>
							<option value="0">正常</option>
							<option value="1">锁定</option>
					</select></td>
					<td><a onclick="query()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a></td>
				</tr>
			</table>
		</div>
	</div>
	<div data-options="region:'center',title:'数据',border:false">
		<table id="dg"></table>
	</div>
	<div id="userAddDiv" class="easyui-dialog" title="用户新增" style="width: 540px; height: 290px;" data-options="iconCls:'icon-add',resizable:true,modal:true,closed:true">
		<iframe id="userAddIframe" style='width:100%;height:98%;border:0px;' src=''></iframe>
	</div>
	<div id="userEditDiv" class="easyui-dialog" title="用户修改" style="width: 540px; height: 320px;" data-options="iconCls:'icon-edit',resizable:true,modal:true,closed:true">
		<iframe id="userEditIframe" style='width:100%;height:98%;border:0px;overflow: hidden;' src=''></iframe>
	</div>
</body>
</html>
