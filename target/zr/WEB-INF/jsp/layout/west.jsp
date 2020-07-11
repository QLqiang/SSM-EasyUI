<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	function menu(title, url) {
		var exit = $('#menuTabs').tabs('exists',title);
		if(exit){
			$('#menuTabs').tabs('select',title);
			return;
		};
		$('#menuTabs').tabs('add', {
			title : title,
			content : "<iframe style='width:100%;height:99%;border:0px;' src='${pageContext.request.contextPath}/"+url+"'></iframe>",
			closable : true,
			tools : [ {
				iconCls : 'icon-mini-refresh',
				handler : function() {
					var tab = $('#menuTabs').tabs('getTab', title);
					$('#menuTabs').tabs('update', {
						tab : tab,
						options : tab.panel('options')
					});
				}
			} ]
		});
	}
</script>
<div class="easyui-accordion" data-options="fit:true,border:false">
	<div title="系统设置">
		<ul class="easyui-tree">
			<li><div onclick="menu('用户设置','system/user/user.action')">
					<span>用户设置</span>
				</div></li>
			<li><div onclick="menu('角色设置','system/role/role.action')">
					<span>角色设置</span>
				</div></li>
			<li><div onclick="menu('权限设置','system/auth/auth.action')">
					<span>权限设置</span>
				</div></li>
		</ul>
	</div>
	<div title="业务设置">content2</div>
	<div title="公司设置">content3</div>
</div>

