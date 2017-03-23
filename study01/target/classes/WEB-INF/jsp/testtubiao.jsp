<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/10/27
  Time: 20:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>图表测试</title>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
    <script src="js/ajax.js"></script>
    <script type="text/javascript">
        window.onload =function () {
            test();
            var a = 5.0;

            Highcharts.chart('container1', {
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false
                },
                title: {
                    text: 'Browser market shares at a specific website, 2014'
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
                    name: 'Browser share',
                    data: [
                        ['Firefox',   45.0],
                        ['IE',       26.8],
                        {
                            name: 'Chrome',
                            y: 12.8,
                            sliced: true,
                            selected: true
                        },
                        ['Safari',    8.5],
                        ['Opera',     6.2],
                        ['Others',   0.7]
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
                            text: 'Monthly Average Price',
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
            alert("test")
        }




    </script>



</head>





<body>
<div id="container" style="width: 610px; height: 400px; margin: 10px 5px 15px 20px "></div>
<div id="container1" style="width:600px;height:400px;margin-right:20px;"></div>

</body>
</html>

