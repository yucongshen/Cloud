<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script type="text/javascript" src="<%=basePath %>js/jquery.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/jquery.sorted.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/bootstrap.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/ckform.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/common.js"></script>

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
<center>
<form class="form-inline definewidth m20" action="index.html" method="get">  
   	姓名：<input type="text" name="userName" id="userName"class="abc input-default" placeholder="" value="${user.userName}" readonly><br><br><br>
	性别：<c:if test="${user.sex=='boy'}"><input type="text" name="sex" id="sex"class="abc input-default" placeholder="" value="男" readonly></c:if>
		<c:if test="${user.sex=='girl'}"><input type="text" name="sex" id="sex"class="abc input-default" placeholder="" value="女" readonly></c:if><br><br><br>
	单位：<input type="text" name="dept" id="dept"class="abc input-default" placeholder="" value="${user.dept}" readonly>  
</form>
<center>
</body>
</html>