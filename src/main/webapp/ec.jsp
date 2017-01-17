<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
    <html> 
    <head> 
    <title>line</title> 
     <script src="<%=basePath %>js/echarts.js"></script>
     <script src="<%=basePath %>js/jquery-1.8.2.min.js"></script>
    </head> 
     
    <body> 
           <h1>动态数据图表展示</h1>
        <!-- 为ECharts准备一个具备大小（宽高）的Dom --> 
         <div id="main" style="height:400px"></div> 
     
        <script type="text/javascript" language="javascript"> 
            var myChart; 
            var eCharts; 
     
            require.config({ 
                paths : { 
                    'echarts' : 'plugin' , 
                } 
            }); 
     
            require( 
                [ 'echarts',  
                  'echarts/chart/line',
                  'echarts/chart/bar'
                ], DrawEChart //异步加载的回调函数绘制图表 
            ); 
     
            //创建ECharts图表方法 
            function DrawEChart(ec) { 
                eCharts = ec; 
                myChart = eCharts.init(document.getElementById('main')); 
                myChart.showLoading({ 
                   text : "图表数据正在努力加载..." 
                }); 
                //定义图表options 
                var options = { 
                    title : { 
                        text : "未来一周气温变化", 
                        subtext : "纯属虚构", 
                        sublink : "http://www.baidu.com" 
                    }, 
                    tooltip : { 
                           show: true,
                        trigger : 'axis' 
                    }, 
                    legend : { 
                        data : [ "测试" ] 
                    }, 
                    toolbox : { 
                        show : true, 
                        feature : { 
                            mark : { show : true}, 
                            dataView : {show : true,  readOnly : false}, 
                            magicType : {show : true,  type : [ 'line', 'bar' ] }, 
                            restore : {show : true }, 
                            saveAsImage : {show : true } 
                        } 
                    }, 
                    calculable : true, 
                    xAxis : [ { 
                        type : 'category', 
                        boundaryGap : false, 
                        data : [ '1', '2', '3', '4', '5', '6', '7' ] 
                    } ], 
                    yAxis : [ { 
                        type : 'value', 
                        axisLabel : { 
                            formatter : '{value} °C' 
                        }, 
                        splitArea : { 
                            show : true 
                        } 
                    } ], 
                   grid : { 
                        width : '90%' 
                    }, 
                    series : [ { 
                        name : '最高气温', 
                        type : 'line', 
                        data : [ 1, 11, 18, 11, 15, 11, 8 ],//必须是Integer类型的,String计算平均值会出错 
                        markPoint : { 
                            data : [
                                     {type : 'max', name : '最大值'},
                                     {type : 'min',  name : '最小值'}
                                     ] 
                        }, 
                        markLine : { 
                            data : [
                                     {type : 'average', name : '平均值'}
                                     ] 
                        } 
                    } ] 
                }; 
               
                myChart.setOption(options); //先把可选项注入myChart中 
                myChart.hideLoading();
                timeId = setInterval("getChartData();",2000);
                //getChartData();//aja后台交互  
            } 
        </script> 
     
     
        <script type="text/javascript"> 
            function getChartData() { 
                //获得图表的options对象 
                var options = myChart.getOption(); 
                //通过Ajax获取数据 
                $.ajax({ 
                    type : "post", 
                    async : false, //同步执行 
                    url : "<%=basePath%>getDynmicLineData", 
                    data : {}, 
                    dataType : "json", //返回数据形式为json
                    success : function(result) { 
                        if (result) { 
                            options.legend.data = result.legend; 
                            options.xAxis[0].data = result.category; 
                            options.series[0].data = result.series[0].data; 
                                                //alert(options.series[0].data);
                                               
                                                myChart.hideLoading();
                            myChart.setOption(options); 
                        } 
                    }, 
                    error : function(errorMsg) { 
                        alert("不好意思，大爷，图表请求数据失败啦!"); 
                        myChart.hideLoading(); 
                    } 
                }); 
            } 
        </script> 
    </body> 
    </html>