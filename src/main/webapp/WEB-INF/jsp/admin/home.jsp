<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<head>
    <title>知行云管理系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="<%=basePath %>css/dpl-min.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath %>css/bui-min.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath %>css/main-min.css" rel="stylesheet" type="text/css" />
	<link rel="Stylesheet" href="<%=basePath %>css/header.css" type="text/css" />
    <link rel="Stylesheet" href="<%=basePath %>css/skin/skin_0.css" type="text/css" id="cssfile" />
	<!--引用了一个Cookie插件，您可以下载Cookie插件，也可以用我的源代码插件，下面有下载的-->
	<script type="text/javascript" src="<%=basePath %>js/jquery-1.8.1.min.js"></script>
	<script src="<%=basePath %>js/jquery.cookie.js" type="text/javascript"></script>
	<!--这是Scripts文件夹中的核心代码ChangeSkin.js-->
	<script src="<%=basePath %>js/ChangeSkin.js" type="text/javascript"></script>
	<script src="<%=basePath %>js/ss.js" type="text/javascript"></script>
	<script type="text/javascript" src="<%=basePath %>js/bui-min.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/common/main-min.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/config-min.js"></script>
	<script>
		BUI.use('common/main',function(){
			var config = [{id:'2',homePage : '3',menu:[{text:'用户管理',
											items:[{id:'3',text:'用户管理',href:'<%=basePath%>userManage/list'}]}]},
										{id:'4',homePage : '5',menu:[{text:'用户container管理',
											items:[{id:'5',text:'用户container管理',href:'<%=basePath%>containerManage/list'}]}]},
										{id:'8',homePage : '9',menu:[{text:'进程管理',
											items:[{id:'9',text:'进程管理',href:'<%=basePath%>processManage/list'}]}]}
										];
			new PageUtil.MainPage({
				modulesConfig : config
			});
		});
	</script>
</head>
<body>
	
<div class="header">

    <div class="dl-title">
        知行云管理系统
    </div>
    <div class="dl-log"><a style="text-decoration: underline;color: white;" href="#">English</a>&nbsp;&nbsp;&nbsp;&nbsp;欢迎您，<span class="dl-log-user">${sessionScope.user.userName}</span><c:if test="${sessionScope.user.userName!=null}"><a href="<%=basePath%>logout" title="退出系统" class="dl-log-quit">[退出]</a></c:if>
    </div>
	<!--<div style="width:800px;height:1px;margin:44px 0px 0px 0px;padding:0px;background-color:#D5D5D5;"></div>-->
</div>
<div class="content">
    <div class="dl-main-nav">
        <div class="dl-inform"><div class="dl-inform-title"><s class="dl-inform-icon dl-up"></s></div></div>
        <ul id="J_Nav"  class="nav-list ks-clear">
			<li class="nav-item dl-selected"><div class="nav-item-inner nav-order">用户管理</div></li>
			<li class="nav-item dl-selected"><div class="nav-item-inner nav-order">container管理</div></li>
			<li class="nav-item dl-selected"><div class="nav-item-inner nav-order">进程管理</div></li>
			<ul id="skin">
				<li id="skin_0" title="蓝色" class="selected">蓝色</li>
				<li id="skin_1" title="紫色">紫色</li>
				<li id="skin_2" title="红色">红色</li>
				<li id="skin_3" title="天蓝色">天蓝色</li>
				<li id="skin_4" title="橙色">橙色</li>
				<li id="skin_5" title="淡绿色">淡绿色</li>
			</ul>
        </ul>
    </div>
    <ul id="J_NavContent" class="dl-tab-conten">

    </ul>
</div>

</body>
</html>