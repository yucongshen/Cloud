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
	<base href="<%=basePath%>">
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.css" />
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/jquery.sorted.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/ckform.js"></script>
    <script type="text/javascript" src="js/common.js"></script> 
    <script type="text/javascript" src="<%=basePath%>js/jquery.validate.js"></script>
    <script>
  	 	 $(function () {       
				$('#backid').click(function(){
					window.location.href="<%=basePath%>user/personal";
				 });
				
				$("#passwordForm").validate({
					rules:{
						password:"required",
						newpassword: {
							required: true,
							minlength: 6
						},
						renewpassword: {
							required: true,
							minlength: 6,
							equalTo: "#newpassword"
						}},
					messages:{
						password: {
							required: "请输入新原密码！",
							minlength: "密码长度不能小于6位！"
						},
						newpassword: {
							required: "请输入新密码！",
							minlength: "密码长度不能小于6位！"
						},
						renewpassword: {
							required: "请输入密码！",
							minlength: "密码长度不能小于6位",
							equalTo: "密码不一致，请重新输入！"
						}}
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
<form action="user/editPassword?userId=${userId }" method="post" class="definewidth m20" id="passwordForm" name="passwordForm">
<table class="table table-bordered table-hover ">
	<span><b><font style="color: red;">${flag}</font></b></span>
    <tr>
        <td width="10%" class="tableleft">原密码</td>
        <td><input type="text" name="password" id="password" value=""/></td>
    </tr>
    <tr>
        <td class="tableleft">新密码</td>
        <td ><input type="text" name="newpassword" id="newpassword" value=""/></td>
    </tr>  
    <tr>
        <td class="tableleft">确认密码</td>
        <td ><input type="text" name="renewpassword" id="renewpassword" value=""/></td>
    </tr>
    <tr>
        <td class="tableleft"></td>
        <td>
            <button type="submit" class="btn btn-primary" type="button">保存</button> &nbsp;&nbsp;<button type="button" class="btn btn-success" name="backid" id="backid">返回列表</button>
        </td>
    </tr>
</table>
</form>
</body>
</html>
