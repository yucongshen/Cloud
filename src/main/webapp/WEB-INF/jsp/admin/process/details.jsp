<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE>
<html>
	<head>
	    <meta charset="utf-8">
	    <!-- 引入 ECharts 文件 -->
	    <script src="<%=basePath%>js/echarts.js"></script>
	    <script src="<%=basePath%>js/jquery-1.8.2.min.js"></script>
	</head>
<body>
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="cpu" style="width: 600px;height:400px;"></div>
    <div id="memory" style="width: 600px;height:400px;"></div>
    <div id="netSend" style="width: 600px;height:400px;"></div>
    <div id="netAccept" style="width: 600px;height:400px;"></div>
    <div><button type="button" class="btn btn-success" name="backid" id="backid" onclick="javascript:history.back(-1);">返回列表</button></div>
    <script type="text/javascript">
    cpuChart();
    memoryChart();
    netSendChart();
    netAcceptChart();
    function cpuChart(){
    	var cpu = echarts.init(document.getElementById('cpu'));
        //图表显示提示信息
       	cpu.showLoading({text : "CPU图表数据正在努力加载..."}); 
    	    //定义图表options
    	    var options = {
    	        title: {
    	            text: 'cpu使用情况',
    	            subtext: 'cpu'
    	        },
    	        tooltip: {
    	            trigger: 'axis'
    	        },
    	        legend: {
    	            data: []
    	        },
    	        toolbox: {
    	            show: true,
    	            feature: {
    	                mark: false
    	            }
    	        },
    	        calculable: true,
    	        xAxis: [
    	            {
    	                type: 'category',
    	                data: []
    	            }
    	        ],
    	        yAxis: [
    	            {
    	                type: 'value',
    	                splitArea: { show: true }
    	            }
    	        ],
    	        series : [ {
    	            name : 'cpu',
    	            type : 'line',
    	            data : []
    	        } ]
    	    };
    	   	setInterval(function(){
    	   		$.ajax({
    	               type : "post",
    	               async : false, //同步执行
    	               url : "<%=basePath%>processManage/findCpu?pid=${process.pid}",
    	               dataType : "json", //返回数据形式为json
    	               success : function(result) {
    	                   if (result) {
    	                   	//alert(result);
    	                       //将返回的category和series对象赋值给options对象内的category和series
    	                       //因为xAxis是一个数组 这里需要是xAxis[i]的形式
    	                       options.legend.data = result.legend;
    	                          options.xAxis[0].data = result.category;
    	                          options.series[0].data = result.series[0].data;
    	                          
    	                          cpu.hideLoading();
    	                          cpu.setOption(options);
    	                   }
    	               },
    	               error : function(errorMsg) {
    	                   alert("cpu图表请求数据失败啦!");
    	               }
    	           });
    	   	},7000);
    }
    
	    //通过Ajax获取数据
	    
		function memoryChart(){
		  //内存饼图
	      var memory = echarts.init(document.getElementById('memory'));
	      //图表显示提示信息
	      memory.showLoading({text : "内存图表数据正在努力加载..."}); 
	      //定义图表options
	      var options = {
	        title : {
	            text : '内存使用情况',
	            subtext : '内存',
	            x : 'center'
	        },
	        tooltip : {
	            trigger : 'item',
	            formatter : "{a} <br/>{b} : {c} ({d}%)"
	        },
	        legend : {
	            orient : 'vertical',
	            left : 'left',
	            data : []
	        },
	        series : [ {
	            name : '内存',
	            type : 'pie',
	            data : []
	        } ]
	    };
	    setInterval(function(){
	    	//alert("lackhjalskd");
	        $.ajax({
	            type : "post",
	            async : false, //同步执行
	            url : "<%=basePath%>processManage/findMemory?pid=${process.pid}",
	            dataType : "json", //返回数据形式为json
	            success : function(result) {
	                if (result) {
	               	 //alert(result);
	                    options.legend.data = result.legend;
	
	                    //将返回的category和series对象赋值给options对象内的category和series
	                    //因为xAxis是一个数组 这里需要是xAxis[i]的形式
	                    options.series[0].name = result.series[0].name;
	                    options.series[0].type = result.series[0].type;
	                    var serisdata = result.series[0].data;
	                    //jquery遍历
	                    var value = [];
	                    $.each(serisdata, function(i, p) {
	                        value[i] = {
	                            'name' : p['name'],
	                            'value' : p['value']
	                        };
	                    });
	                    options.series[0]['data'] = value;
	                    memory.hideLoading();
	                    memory.setOption(options);
	                }
	            },
	            error : function(errorMsg) {
	                alert("内存图表请求数据失败!");
	            } 
	        });
	    },7000);
	}
		function netSendChart(){
	    	var netSend = echarts.init(document.getElementById('netSend'));
	        //图表显示提示信息
	       	netSend.showLoading({text : "netSend图表数据正在努力加载..."}); 
	    	    //定义图表options
	    	    var options = {
	    	        title: {
	    	            text: 'netSend使用情况',
	    	            subtext: 'netSend'
	    	        },
	    	        tooltip: {
	    	            trigger: 'axis'
	    	        },
	    	        legend: {
	    	            data: []
	    	        },
	    	        toolbox: {
	    	            show: true,
	    	            feature: {
	    	                mark: false
	    	            }
	    	        },
	    	        calculable: true,
	    	        xAxis: [
	    	            {
	    	                type: 'category',
	    	                data: []
	    	            }
	    	        ],
	    	        yAxis: [
	    	            {
	    	                type: 'value',
	    	                splitArea: { show: true }
	    	            }
	    	        ],
	    	        series : [ {
	    	            name : 'netSend',
	    	            type : 'line',
	    	            data : []
	    	        } ]
	    	    };
	    	   	setInterval(function(){
	    	   		$.ajax({
	    	               type : "post",
	    	               async : false, //同步执行
	    	               url : "<%=basePath%>processManage/findNetSend?pid=${process.pid}",
	    	               dataType : "json", //返回数据形式为json
	    	               success : function(result) {
	    	                   if (result) {
	    	                   	//alert(result);
	    	                       //将返回的category和series对象赋值给options对象内的category和series
	    	                       //因为xAxis是一个数组 这里需要是xAxis[i]的形式
	    	                       options.legend.data = result.legend;
	    	                          options.xAxis[0].data = result.category;
	    	                          options.series[0].data = result.series[0].data;
	    	                          
	    	                          netSend.hideLoading();
	    	                          netSend.setOption(options);
	    	                   }
	    	               },
	    	               error : function(errorMsg) {
	    	                   alert("netSend图表请求数据失败啦!");
	    	               }
	    	           });
	    	   	},7000);
	    }
		function netAcceptChart(){
	    	var netAccept = echarts.init(document.getElementById('netAccept'));
	        //图表显示提示信息
	       	netAccept.showLoading({text : "netAccept图表数据正在努力加载..."}); 
	    	    //定义图表options
	    	    var options = {
	    	        title: {
	    	            text: 'netAccept使用情况',
	    	            subtext: 'netAccept'
	    	        },
	    	        tooltip: {
	    	            trigger: 'axis'
	    	        },
	    	        legend: {
	    	            data: []
	    	        },
	    	        toolbox: {
	    	            show: true,
	    	            feature: {
	    	                mark: false
	    	            }
	    	        },
	    	        calculable: true,
	    	        xAxis: [
	    	            {
	    	                type: 'category',
	    	                data: []
	    	            }
	    	        ],
	    	        yAxis: [
	    	            {
	    	                type: 'value',
	    	                splitArea: { show: true }
	    	            }
	    	        ],
	    	        series : [ {
	    	            name : 'netAccept',
	    	            type : 'line',
	    	            data : []
	    	        } ]
	    	    };
	    	   	setInterval(function(){
	    	   		$.ajax({
	    	               type : "post",
	    	               async : false, //同步执行
	    	               url : "<%=basePath%>processManage/findNetAccept?pid=${process.pid}",
	    	               dataType : "json", //返回数据形式为json
	    	               success : function(result) {
	    	                   if (result) {
	    	                   	//alert(result);
	    	                       //将返回的category和series对象赋值给options对象内的category和series
	    	                       //因为xAxis是一个数组 这里需要是xAxis[i]的形式
	    	                       options.legend.data = result.legend;
	    	                          options.xAxis[0].data = result.category;
	    	                          options.series[0].data = result.series[0].data;
	    	                          netAccept.hideLoading();
	    	                          netAccept.setOption(options);
	    	                   }
	    	               },
	    	               error : function(errorMsg) {
	    	                   alert("netAccept图表请求数据失败啦!");
	    	               }
	    	           });
	    	   	},7000);
	    }
	</script>   
	    
</body>
</html>