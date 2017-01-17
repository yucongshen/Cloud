<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
<title></title>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/bootstrap.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/bootstrap-responsive.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/style.css" />
<script type="text/javascript" src="<%=basePath%>js/jquery.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.sorted.js"></script>
<script type="text/javascript" src="<%=basePath%>js/bootstrap.js"></script>
<script type="text/javascript" src="<%=basePath%>js/ckform.js"></script>
<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
<style type="text/css">
body {
	padding-bottom: 40px;
}

.sidebar-nav {
	padding: 9px 0;
}

@media ( max-width : 980px) { /* Enable use of floated navbar text */
	.navbar-text.pull-right {
		float: none;
		padding-left: 5px;
		padding-right: 5px;
	}
}
</style>
<script type="text/javascript">
	    /* $(function () {
	    	$(".change").click(function(){
	    	    if($(this).html()=="启动"){
	    	         $(this).html("挂起");
	    	         // 这个应该是遮罩层还是说  只是改变那个 td的值就行了，就只改了字
	    	         $(this).parent().prev().html("正在启动...");
	    	    }else{
	    	         $(this).html("启动");
	    	         $(this).parent().prev().html("正在终止...");
	    	     }
	    	});
	    }); */
	    
	    function stopPro(obj,pid,containerId){
	    	$(obj).parent().prev().html("正在停止...");
	    	$.post("<%=basePath%>processManage/stopProcess?pid="+pid+"&containerId="+containerId,null,
		        function(data,status){
	    			//alert(data,status);
		        	if(data == 1){  
		        		$(obj).parent().prev().html("停止运行");
		        	}else{
		        		$(obj).parent().prev().html("停止失败");
		        	} 
		    });
	    }//deng wo xia 
		function changeProStatus(obj,pid,containerId){
	   		var text = $(obj).text();
	   		if(text == "启动"){	
	   			$(obj).parent().prev().html("正在启动...");
	   			$.post("<%=basePath%>processManage/startProcess?pid="+pid+"&containerId="+containerId,null,
	   			        function(data,status){
	   			        	if(data == 1){  
	   			        		$(obj).parent().prev().html("正在运行");
	   			        		$(obj).text("挂起");
	   			        	}else{
	   			        		$(obj).parent().prev().html("启动失败");
	   			        	}
	   			 });
	   		}else if(text == "挂起"){
	   			$(obj).parent().prev().html("正在终止...");
	   			$.post("<%=basePath%>processManage/stopProcess?pid="+pid+"&containerId="+containerId,null,
	   			        function(data,status){
	   			        	if(data == 1){  
	   			        		$(obj).parent().prev().html("已经挂起");
	   			        		$(obj).text("启动");
	   			        	}else{
	   			        		$(obj).parent().prev().html("挂起失败");
	   			        	} 
	   			 });
	   		}else{
	   			//nothing
	   		}
			
	    }
    </script>
</head>
<body>
	<form class="form-inline definewidth m20"
		action="<%=basePath%>processManage/findByKeyPid" method="post">
		进程号： <input type="text" name="pid" id="pid" value="${pid}"
			class="abc input-default" placeholder="">&nbsp;&nbsp;
		<button type="submit" class="btn btn-primary nav-item-inner nav-order">查询</button>
		&nbsp;&nbsp;
		<button type="button" class="btn btn-success" name="backid"
			id="backid" onclick="javascript:history.back(-1);">返回列表</button>

	</form>
	<table class="table table-bordered table-hover definewidth m10">
		<thead>
			<tr>
				<th>序号</th>
				<th>进程编号</th>
				<th>所属容器</th>
				<th>所属用户</th>
				<th>进程状态</th>
				<th>操作</th>
				<th>查看详细信息</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${processList}" var="process" varStatus="status">
				<tr>
					<td>${status.count }</td>
					<td>${process.pid }</td>
					<td>${process.containerId }</td>
					<td>${process.userName}</td>
					<td>
						<c:if test="${process.state==1}">运行状态</c:if> 
						<c:if test="${process.state==0}">终止状态</c:if>
					</td>
					<td>
						<c:if test="${process.state==0}">
							<a id="open"
								onclick="changeProStatus(this,${process.pid},'${process.containerId}',this)"
								class="change" href="javascript:return false;">启动</a>
						</c:if> <c:if test="${process.state==1}">
							<a id="close"
								onclick="changeProStatus(this,${process.pid},'${process.containerId}',this)"
								class="change" href="javascript:return false;">挂起</a>
						</c:if> 
					</td>
					<td>
						<a href="<%=basePath%>processManage/findByPid?pid=${process.pid}">查看</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>