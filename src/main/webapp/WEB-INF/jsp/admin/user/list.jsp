<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="<%=basePath %>css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath %>css/bootstrap-responsive.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath %>css/style.css" />
    <script type="text/javascript" src="<%=basePath%>js/jquery.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/jquery.sorted.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/bootstrap.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/ckform.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/common.js"></script>
	<script type="text/javascript">
	    $(function () {
	    	
			$("#addnew").click(function(){
				window.location.href="<%=basePath%>userManage/addPage";
			 });
			$(".open").click(function(){
				if(confirm("是否要启用该用户？")){
				}else{
					$(".open").attr("href","");
				}
			});
			$(".aclose").click(function(){
				if(confirm("是否要禁用该用户？")){
				}else{
					$(".aclose").attr("href","");
				}
			});
			$("#pagenext").click(function(){
				window.location.href="<%=basePath%>userManage/list?page=${page.pageNum==page.lastPage?page.lastPage:page.nextPage}";
			 });
			$("#pagebefore").click(function(){
				window.location.href="<%=basePath%>userManage/list?page=${page.pageNum==1?1:page.prePage}";
			 });
			$("#firstPage").click(function(){
				window.location.href="<%=basePath%>userManage/list?page=${page.firstPage}";
			 });
			$("#lastPage").click(function(){
				window.location.href="<%=basePath%>userManage/list?page=${page.lastPage}";
			 });

	    });
	</script>
    <style type="text/css">
        body {
            padding-bottom: 40px;
        }
        .sidebar-nav {
            padding: 9px 0;
        }

        @media (max-width: 980px) {
            /* Enable use of floated navbar text */
            .navbar-text.pull-right {
                float: none;
                padding-left: 5px;
                padding-right: 5px;
            }
        }
    </style>
</head>
<body>
<form class="form-inline definewidth m20" action="<%=basePath%>userManage/findByName" method="post">
    用户名：
    <input type="text" name="username" id="username" value="${username}" class="abc input-default" placeholder="" value="">&nbsp;&nbsp; 
    <button type="submit" class="btn btn-primary nav-item-inner nav-order">查询</button>&nbsp;&nbsp; <button type="button" class="btn btn-success" id="addnew">添加</button>
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
    	<th>序号</th>
        <th>用户编号</th>
        <th>用户名</th>
		<th>性别</th>
		<th>工作单位</th>
		<th>角色</th>
		<th>状态</th>
		<th>操作</th>
		<th>查看container</th>
    </tr>
    </thead>
    	<c:forEach items="${userList}" var="user" varStatus="status">
			<tr>
                <td>${status.count}</td>
                <td>${user.userId}</td>
				<td>${user.userName}</td>
				<td>
					<c:if test="${user.sex=='boy'}">男</c:if>
					<c:if test="${user.sex=='girl'}">女</c:if>
				</td>
				<td>${user.dept}</td>
				<td>
					<c:if test="${user.role==0}"><c:out value="管理员"></c:out></c:if>
					<c:if test="${user.role==1}"><c:out value="用户"></c:out></c:if>
				</td>
				<td>
					<c:if test="${user.state==0}"><c:out value="禁用中"></c:out></c:if>
					<c:if test="${user.state==1}"><c:out value="启用中"></c:out></c:if>
				</td>
				<td>
					<c:if test="${user.state==0}"><a class="open" href="<%=basePath%>userManage/edit?userId=${user.userId}">启用</a></c:if>
					<c:if test="${user.state==1}"><a class="aclose" href="<%=basePath%>userManage/edit?userId=${user.userId}">禁用</a></c:if>
				</td>
				<td><a href="<%=basePath%>containerManage/containerListByUserId?userId=${user.userId}">查看container</a></td>
            </tr>
		</c:forEach>
</table>
<c:if test="${not empty page }">
<div>
<span style="position:absolute; left:50px; bottom:50px;">
<h4>当前第<a href="">${page.pageNum }</a>页</h4>
</div>
<div>
<span style="position:absolute; right:50px; bottom:50px;">
 	<button type="button" class="btn btn-primary nav-item-inner nav-order" id="pagenext">下一页</button>
</div>
<div>
<span style="position:absolute; right:150px; bottom:50px;">
 	<button type="button" class="btn btn-primary nav-item-inner nav-order" id="pagebefore">上一页</button>
</div>
<div>
<span style="position:absolute; right:350px; bottom:50px;">
 	<button type="button" class="btn btn-success" id="firstPage">首页</button>
</div>
<div>
<span style="position:absolute; right:280px; bottom:50px;">
 	<button type="button" class="btn btn-success" id="lastPage">尾页</button>
</div>
</c:if>
</body>
</html>
