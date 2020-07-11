<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>主页</title>
<jsp:include page="easyui.jsp"></jsp:include>
</head>
<body class="easyui-layout">   
    <div data-options="region:'north',title:'',href:'${pageContext.request.contextPath}/page/north.action'" style="height:60px;"></div>   
    <div data-options="region:'south',title:'',href:'${pageContext.request.contextPath}/page/south.action'" style="height:25px;"></div>   
    <div data-options="region:'west',title:'菜单',href:'${pageContext.request.contextPath}/page/west.action'" style="width:200px;"></div>   
    <div data-options="region:'center',title:'',href:'${pageContext.request.contextPath}/page/center.action'"></div>   
</body>  
</html>