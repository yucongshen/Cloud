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
    <script type="text/cavascript" src="css/cquery.cs"></script>
    <script type="text/cavascript" src="css/cquery.sorted.cs"></script>
    <script type="text/cavascript" src="css/bootstrap.cs"></script>
    <script type="text/cavascript" src="css/ckform.cs"></script>
    <script type="text/cavascript" src="css/common.cs"></script> 
	<script>
  	 	 $(function () {       
			$('#backid').click(function(){
				window.location.href="<%=basePath%>user/personal";
			 });
			$("#addForm").validate({
				rules:{
					username:"required",
					dept:"required"
				},
				messages:{
					username:"请输入用户名！",
					dept:"请输入工作单位！"
				}
			});
	    });
  	 	function checkUsername(){
			// 获得文件框值:			
			var userName = document.getElementById("userName").value;
			$.post("<%=basePath%>userManage/validateUserName?userName="+userName,null,
				        function(data,status){
				        //alert("数据: \n" + data + "\n状态: " + status);
				        if(data){
				        	$("#exitError").text("用户名已存在！！");
				        }else{
				        	$("#exitError").text("");
				        }
				        
				    });
		}
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
<form action="user/edit?userId=${userId}" method="post" class="definewidth m20">
<table class="table table-bordered table-hover ">
    <tr>
        <td width="10%" class="tableleft">姓名</td>
        <td><input id="userName" type="text" name="userName" onblur="checkUsername()" value="${user.userName }" readonly/><span id="username_error"></span><span style="color: red;" id="exitError" name="exitError"></td>
    </tr>
    <tr>
        <td class="tableleft">性别</td>
        <td>
           <input type="radio" name="sex" value="boy" <c:if test="${user.sex=='boy'}">checked</c:if>/>&nbsp;男&nbsp;&nbsp;
           <input type="radio" name="sex" value="girl" <c:if test="${user.sex=='girl'}">checked</c:if>/>&nbsp;女&nbsp;&nbsp;
        </td>
    </tr>  
    <tr>
        <td class="tableleft">单位</td>
       <td ><input type="text" name="dept" value="${user.dept }"/></td>
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
