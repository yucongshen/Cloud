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
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/bootstrap-responsive.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/style.css" />
    <script type="text/javascript" src="<%=basePath%>js/jquery.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/jquery.sorted.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/ckform.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/common.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.validate.js"></script>
	<script type="text/javascript">
	    $(function () {
			$("#addForm").validate({
				rules:{
					username:"required",
					password: {
						required: true,
						minlength: 6
					},
					repassword: {
						required: true,
						minlength: 6,
						equalTo: "#password"
					},
					dept:"required"
				},
				messages:{
					username:"请输入用户名！",
					password: {
						required: "请输入密码！",
						minlength: "密码长度不能小于6位！"
					},
					repassword: {
						required: "请输入密码！",
						minlength: "密码长度不能小于6位",
						equalTo: "密码不一致，请重新输入！"
					},
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
<form id="addForm" action="<%=basePath%>regist" method="post" class="definewidth m20">
<table class="table table-bordered table-hover definewidth m10">
    <tr>
        <td class="tableleft">用户名</td>
        <td><input id="userName" type="text" name="userName" onblur="checkUsername()"/><span id="username_error"></span><span style="color: red;" id="exitError" name="exitError">${exit }</span></td>
        
    </tr>
    <tr>
        <td class="tableleft">密码</td>
        <td><input id="password" type="password" name="password"/><span id="password_error"></span></td>
    </tr>
    <tr>
        <td class="tableleft">确认密码</td>
        <td><input id="repassword" type="password" name="repassword"/><span id="repassword_error"></span></td>
    </tr>
    <tr>
        <td class="tableleft">性别</td>
        <td>
           <input type="radio" name="sex" value="boy" checked/>&nbsp;男&nbsp;&nbsp;
           <input type="radio" name="sex" value="girl"/>&nbsp;女&nbsp;&nbsp;
        </td>
    </tr>
    <tr>
        <td class="tableleft">单位</td>
        <td><input id="dept" type="text" name="dept"/><span id="dept_error"></span></td>
    </tr>
     <tr>
        <td class="tableleft">角色</td>
        <td>
           <input type="radio" name="role" value="0" checked/>&nbsp;管理员&nbsp;&nbsp;
           <input type="radio" name="role" value="1"/>&nbsp;用户&nbsp;&nbsp;
        </td>
    </tr>
    <tr>
        <td class="tableleft">状态</td>
        <td>
           <input type="radio" name="state" value="1" checked/>&nbsp;启用&nbsp;&nbsp;
           <input type="radio" name="state" value="0"/>&nbsp;禁用&nbsp;&nbsp;
        </td>
    </tr>
    <tr>
        <td class="tableleft"></td>
        <td>
            <button type="submit" class="btn btn-primary">保存</button>
        </td>
    </tr>
</table>
</form>
</body>
</html>