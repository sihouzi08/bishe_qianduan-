<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>GuangShangTao - Datastatistics</title>
    <script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/datepicker3.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">

    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>

    <script src="js/ajax.js"></script>
    <![endif]-->
    <script type="text/javascript">

        var shopTotalElements,orderTotalElements,messagesTotalElements,userTotalElements;
//
//        function download(type){
//            msg = '是否把'+type+'表单导出excel';
//            if(confirm(msg)){
//                var url="http://101.200.56.75/"+type+"/file";
//                window.open(url);
//            }
//        }
//
//        function download(){
//            msg = '是否把该页shop表单导出excel';
//            if(confirm(msg)){
//                var url="http://101.200.56.75/shop/file";
//                window.open(url);
//            }
//        }


        window.onload =function () {
            test();
            var a = 5.0;
            startTime();
            Highcharts.chart('container1', {
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false
                },
                title: {
                    text: 'Commodity statistics percentage, 2017'
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: {
                            enabled: true,
                            format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                            style: {
                                color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                            }
                        }
                    }
                },
                series: [{
                    type: 'pie',
                    name: 'Goods share',
                    data: [
                        ['sport',   45.0],
                        ['electronics',       26.8],
                        {
                            name: 'book',
                            y: 12.8,
                            sliced: true,
                            selected: true
                        },
                        ['food',    15.4]
                    ]
                }]
            });
        }
        function test() {
            $.ajax({
                url: "http://101.200.56.75/datastatistics/getdatatest",
                type: "GET",
                dataType: "json",
                success: function (res) {
                    var p=res.payload.shiwu;
                    var s=res.payload.shuji
                    var d=res.payload.dianzi
                    Highcharts.chart('container', {
                        title: {
                            text: 'Monthly Sum Price',
                            x: -20 //center
                        },
                        subtitle: {
                            text: 'Source: GuangShangTao',
                            x: -20
                        },
                        xAxis: {
                            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                                'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
                        },
                        yAxis: {
                            yAxis: {
                                min: 0, // 这个用来控制y轴的开始刻度（最小刻度），另外还有一个表示最大刻度的max属性
                                startOnTick: false // y轴坐标是否从某一刻度开始（这个设定与标题无关）
                            },
                            title: {
                                text: '收益Price (元)'
                            },
                            plotLines: [{
                                value: 0,
                                width: 1,
                                color: '#808080'
                            }]
                        },
                        tooltip: {
                            valueSuffix: '元'
                        },
                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                            borderWidth: 0
                        },
                        series: [{
                            name: '书籍类商品',
                            data: [s[0].Jan, s[1].Feb, s[2].Mar, s[3].Apr, s[4].May, s[5].Jun, s[6].Jul,  s[7].Aug,  s[8].Sep,  s[9].Oct,  s[10].Nov,  s[11]._Dec]
                        }, {
                            name: '运功类商品',
                            data: [res.payload.yundong[0].Jan, res.payload.yundong[1].Feb,  res.payload.yundong[2].Mar,  res.payload.yundong[3].Apr,  res.payload.yundong[4].May,  res.payload.yundong[5].Jun,  res.payload.yundong[6].Jul,  res.payload.yundong[7].Aug,  res.payload.yundong[8].Sep,  res.payload.yundong[9].Oct,  res.payload.yundong[10].Nov,  res.payload.yundong[11]._Dec]
                        }, {
                            name: '食物类商品',
                            data: [p[0].Jan, p[1].Feb, p[2].Mar, p[3].Apr, p[4].May, p[5].Jun, p[6].Jul,  p[7].Aug,  p[8].Sep,  p[9].Oct,  p[10].Nov,  p[11]._Dec]
                        }, {
                            name: '电子类商品',
                            data: [d[0].Jan, d[1].Feb, d[2].Mar, d[3].Apr, d[4].May, d[5].Jun, d[6].Jul,  d[7].Aug,  d[8].Sep,  d[9].Oct,  d[10].Nov,  d[11]._Dec]
                        }]
                    });
                },

            });
//            alert("test")
            remond0(0,5,"messageid,asc",1);
            remond0(0,5,"orderid,asc",2);
            remond0(0,5,"userid,asc",3);
            remond0(0,5,"shopid,asc",4);
        }

        function remond0(page, size, sort,controller) {
            if(controller==1){
                $.ajax({
                    url: "http://101.200.56.75/messages/messagespage?page=" + page + "&size=" + size + "&sort=" + sort,
                    type: "GET",
                    dataType: "json",
                    success: function (res) {
                        messagesTotalElements=res.payload.totalElements;
//                        alert(messagesTotalElements+"          "+controller);
                        document.getElementById("messages").innerHTML = messagesTotalElements;
                    }

                });
            }
            if(controller==2){

                $.ajax({
                    url: "http://101.200.56.75/order/orderspage?page="+page+"&size="+size+"&sort="+sort,
                    type: "GET",
                    dataType: "json",
                    success: function (res) {
                        orderTotalElements = res.payload.totalElements;
//                        alert(orderTotalElements);
                        document.getElementById("order").innerHTML = orderTotalElements;
                    }

                });

            }
            if(controller == 3){

                $.ajax({
                    url: "http://101.200.56.75/users/userspage?page="+page+"&size="+size+"&sort="+sort,
                    type: "GET",
                    dataType: "json",
                    success: function (res) {
                        userTotalElements = res.payload.totalElements;
//                        alert(userTotalElements);
                        document.getElementById("user").innerHTML = userTotalElements;
                    }


                });

            }
            if(controller == 4){

                $.ajax({
                    url: "http://101.200.56.75/shop/newspage?page="+page+"&size="+size+"&sort="+sort,
                    type: "GET",
                    dataType: "json",
                    success: function (res) {
                        shopTotalElements = res.payload.totalElements;
//                        alert(shopTotalElements);
                        document.getElementById("shop").innerHTML =shopTotalElements;
                    }

                });

            }
        }
//        shopTotalElements,orderTotalElements,messagesTotalElements,userTotalElements;


        function startTime()
        {
            var today=new Date()
            var h=today.getHours()
            var m=today.getMinutes()
            var s=today.getSeconds()
// add a zero in front of numbers<10
            m=checkTime(m)
            s=checkTime(s)
            document.getElementById('txt').innerHTML="现在时间:<span class='glyphicon glyphicon-time'></span>&nbsp;"+ h+":"+m+":"+s
//            document.getElementById('timeid').innerHTML="<span class='glyphicon glyphicon-time'></span>&nbsp;"+ h+":"+m+":"+s
            t=setTimeout('startTime()',500)
        }

        function checkTime(i)
        {
            if (i<10)
            {i="0" + i}
            return i
        }
        function back(){
            window.history.back(-1);
        }

    </script>


</head>

<body>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#sidebar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"><span>GuangShangTao</span>Admin</a>
            <ul class="user-menu">
                <li class="dropdown pull-right">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-user"></span> <shiro:principal/> <span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="#"><span class="glyphicon glyphicon-user"></span> Profile</a></li>
                        <li><a href="#"><span class="glyphicon glyphicon-cog"></span> Settings</a></li>
                        <li><a href="${pageContext.request.contextPath }/logout"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div><!-- /.container-fluid -->
</nav>

<div id="sidebar-collapse" class="col-sm-3 col-lg-2 sidebar">
    <form role="search">
        <div class="form-group">
            <input type="text" class="form-control" placeholder="Search">
        </div>
    </form>
    <ul class="nav menu">
        <li class="active"><a href="/testtubiao"><span class="glyphicon glyphicon-dashboard"></span> 数据操作</a></li>
        <li><a href="/testshop"><span class="glyphicon glyphicon-shopping-cart"></span> 商品操作</a></li>
        <li><a href="/testuser"><span class="glyphicon glyphicon-user"></span> 用户操作</a></li>
        <li><a href="/testorder"><span class="glyphicon glyphicon-list-alt"></span> 订单操作</a></li>
        <li><a href="/testmessages"><span class="glyphicon glyphicon-comment"></span> 评论操作</a></li>
        <%--<li><a href="panels.html"><span class="glyphicon glyphicon-info-sign"></span> Alerts &amp; Panels</a></li>--%>
        <li class="parent ">
            <a href="#">
                <span class="glyphicon glyphicon-download-alt"></span> 下载excel <span data-toggle="collapse" href="#sub-item-1" class="icon pull-right"><em class="glyphicon glyphicon-s glyphicon-plus"></em></span>
            </a>
            <ul class="children collapse" id="sub-item-1">
                <li>
                    <a class=""  href="http://101.200.56.75/shop/file"  >
                        <span class="glyphicon glyphicon-circle-arrow-down"></span> 商品 Excel
                    </a>
                </li>
                <li>
                    <a class=""  href="http://101.200.56.75/users/file" >
                        <span class="glyphicon glyphicon-circle-arrow-down"></span> 用户 Excel
                    </a>
                </li>
                <li>
                    <a class=""  href="http://101.200.56.75/order/file"  >
                        <span class="glyphicon glyphicon-circle-arrow-down"></span> 订单 Excel
                    </a>
                </li>
                <li>
                    <a class=""  href="http://101.200.56.75/messages/file" >
                        <span class="glyphicon glyphicon-circle-arrow-down"></span> 评论 Excel
                    </a>
                </li>
            </ul>
        </li>
        <li role="presentation" class="divider"></li>
        <li><a href="${pageContext.request.contextPath }/logout"><span class="glyphicon glyphicon-user"></span> Login Out</a></li>
    </ul>
</div><!--/.sidebar-->

<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">
    <div class="row">
        <ol class="breadcrumb">
            <li> [<a href="/indexmain"><span class='glyphicon glyphicon-home'></span>&nbsp;主页</a>]</li>
            <li class="active">Datastatistics</li>
            <li> [<a href="/time" id="txt"> </a>]</li>
            <li>[<a href="#" onclick="back()"><span class='glyphicon glyphicon-share-alt'></span>&nbsp;返回 </a> ]</li>
            <li> [ <a href="/help" ><span class='glyphicon glyphicon-question-sign'></span>&nbsp;帮助</a>]</li>
            <li> [<a href="/thisuser"><span class='glyphicon glyphicon-user'></span>&nbsp;用户</a>]&nbsp;&nbsp;</li>
        </ol>
    </div><!--/.row-->

    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Datastatistics</h1>
        </div>
    </div><!--/.row-->

    <%--<div class="copyrights">Collect from <a href="http://www.cssmoban.com/" >网页模板</a></div>--%>

    <div class="row">
        <div class="col-xs-12 col-md-6 col-lg-3">
            <div class="panel panel-blue panel-widget ">
                <div class="row no-padding">
                    <div class="col-sm-3 col-lg-5 widget-left">
                        <em class="glyphicon glyphicon-list-alt glyphicon-l"></em>
                    </div>
                    <div class="col-sm-9 col-lg-7 widget-right">
                        <div class="large" id="order"></div>
                        <div class="text-muted">订单</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xs-12 col-md-6 col-lg-3">
            <div class="panel panel-orange panel-widget">
                <div class="row no-padding">
                    <div class="col-sm-3 col-lg-5 widget-left">
                        <em class="glyphicon glyphicon-comment glyphicon-l"></em>
                    </div>
                    <div class="col-sm-9 col-lg-7 widget-right">
                        <div class="large" id="messages"></div>
                        <div class="text-muted">评论</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xs-12 col-md-6 col-lg-3">
            <div class="panel panel-teal panel-widget">
                <div class="row no-padding">
                    <div class="col-sm-3 col-lg-5 widget-left">
                        <em class="glyphicon glyphicon-user glyphicon-l"></em>
                    </div>
                    <div class="col-sm-9 col-lg-7 widget-right">
                        <div class="large" id="user"></div>
                        <div class="text-muted">用户</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xs-12 col-md-6 col-lg-3">
            <div class="panel panel-red panel-widget">
                <div class="row no-padding">
                    <div class="col-sm-3 col-lg-5 widget-left">
                        <em class="glyphicon glyphicon-shopping-cart glyphicon-l"></em>
                    </div>
                    <div class="col-sm-9 col-lg-7 widget-right">
                        <div class="large" id="shop"></div>
                        <div class="text-muted">商品</div>
                    </div>
                </div>
            </div>
        </div>
    </div><!--/.row-->

    <div id="container" name="container" style="width: 810px; height: 400px; margin: 20px 5px 15px 20px "></div>
    <div id="container1" name="container1" style="width:800px;height:400px;margin-right:20px;"></div>
    <div class="row">
        <div class="col-xs-6 col-md-3">
            <div class="panel panel-default">
                <div class="panel-body easypiechart-panel">
                    <h4>Sports</h4>
                    <div class="easypiechart" id="easypiechart-blue" data-percent="92" ><span class="percent">92%</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xs-6 col-md-3">
            <div class="panel panel-default">
                <div class="panel-body easypiechart-panel">
                    <h4>Electronics</h4>
                    <div class="easypiechart" id="easypiechart-orange" data-percent="65" ><span class="percent">65%</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xs-6 col-md-3">
            <div class="panel panel-default">
                <div class="panel-body easypiechart-panel">
                    <h4>Book</h4>
                    <div class="easypiechart" id="easypiechart-teal" data-percent="56" ><span class="percent">56%</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xs-6 col-md-3">
            <div class="panel panel-default">
                <div class="panel-body easypiechart-panel">
                    <h4>Food</h4>
                    <div class="easypiechart" id="easypiechart-red" data-percent="47" ><span class="percent">47%</span>
                    </div>
                </div>
            </div>
        </div>
    </div><!--/.row-->
</div>	<!--/.main-->
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>

<%--<script src="js/jquery-1.11.1.min.js"></script>--%>
<script src="js/bootstrap.min.js"></script>
<%--<script src="js/chart.min.js"></script>--%>
<%--<script src="js/chart-data.js"></script>--%>
<script src="js/easypiechart.js"></script>
<script src="js/easypiechart-data.js"></script>
<script src="js/bootstrap-datepicker.js"></script>

</body>

</html>
