<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Lumino - Dashboard</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/datepicker3.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
    <%--<link rel="stylesheet" type="text/css" href="css/main.css">--%>
    <%--<link rel="stylesheet" type="text/css" href="css/dashboard.css">--%>
    <%--<link rel="stylesheet" href="css/common.css" type="text/css"/>--%>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>

    <script src="js/ajax.js"></script>
    <![endif]-->
    <script type="text/javascript">

        var sum,sports,electronics,food,book;

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
            alert("test")
        }

        var p, maxpage;
        var h;
        var default_size=5;
        var default_sort="orderid,asc";
        window.onload = function () {
            remond('0',default_size,default_sort);
//            alert("kuayu()")
        };



        function addElementLiFirstAndUpone(obj,operation,key,value,page) {
            var ul = document.getElementById(obj);

            var li0 = document.createElement("li");

            li0.innerHTML = "<a href='#'"
                + "onclick=\"remond('0','" + default_size + "','" + default_sort + "','" + operation + "','" + key + "','" + value + "')\""
                + " aria-label='Next'>"
                + "<span aria-hidden='true'>首页</span></a>";
            ul.appendChild(li0);
            //添加 li
            var li = document.createElement("li");

            li.innerHTML = "<a href='#'"
                + "onclick=\"UponeOrNextTest('" + operation + "','" + key + "','" + value + "','" + page + "','1')\""
                + " aria-label='Next'>"
                + "<span aria-hidden='true'>&laquo;</span></a>";
            ul.appendChild(li);


        }




        function addElementLiNextAndEnd(obj,operation,key,value,page) {
            var ul = document.getElementById(obj);

            var _maxpage = maxpage - 1;
            //添加 li
            var li = document.createElement("li");

            li.innerHTML = "<a href='#'"
                + "onclick=\"UponeOrNextTest('" + operation + "','" + key + "','" + value + "','" + page + "','0')\""
                + " aria-label='Next'>"
                + "<span aria-hidden='true'>&raquo;</span></a>";
            ul.appendChild(li);

            var li2 = document.createElement("li");

            li2.innerHTML = "<a href='#'"
                + "onclick=\"remond('" + _maxpage + "',default_size,default_sort,'" + operation + "','" + key + "','" + value + "')\""
                + " aria-label='Next'>"
                + "<span aria-hidden='true'>尾页</span></a>";
            ul.appendChild(li2);
        }


        function UponeOrNextTest(operation,key,value,page,tof) {
            alert("page =" + page + "   ......  最大页数：" + maxpage)
            if(tof==1){//uponetest


                var _page = parseInt(page) - 2 ;

                if (_page < 0) {
                    alert("当前第"+_page + "页的显示" + " 已经 shi最大页数：" + maxpage);
                    return false;
                }
                remond(_page ,default_size,default_sort,operation,key,value);
                alert("当前第" + (_page+1) + "页的显示" + "   ......  最大页数：" + maxpage)
            }else{//nexttest

                var _page = parseInt(page)  ;

                if (_page >= maxpage) {
                    alert("当前第"+_page + "页的显示" + " 已经 shi最大页数：" + maxpage);
                    return false;
                }
                remond(_page ,default_size,default_sort,operation,key,value);
                alert("当前第" + _page + "页的显示" + "   ......  最大页数：" + maxpage)
            }
        }

        function addElementLi(obj, page,operation,key,value) {
            var ul = document.getElementById(obj);

            //添加 li
            var li = document.createElement("li");

            //设置 li 属性，如 id
//            li.setAttribute("id", page);
            var _page=page-1;
            li.innerHTML = "<a href='#'"
                + "onclick=\"remond('" + _page + "','" + default_size + "','" + default_sort + "','" + operation + "','" + key + "','" + value + "')\">"
                + page + "</a>";
            ul.appendChild(li);
        }


        //显示详情调用模态框
        function detail(moneySum, orderid, shopname, des, userName,ordertime) {

            document.getElementById("orderid").innerHTML = orderid;
            document.getElementById("moneySum").innerHTML = moneySum;
            document.getElementById("Des").innerHTML = des;
            document.getElementById("shopname").innerHTML = shopname;
            document.getElementById("userName").innerHTML = userName;

            document.getElementById("ordertime").innerHTML = ordertime;


            $('#myModal').modal('show');
        }


        function status(orderid,paystate,name){
            msg = '是否将ID号' + orderid + '的订单状态修改？';
            if (confirm(msg)) {
                if (paystate == 0) {
                    paystate = 1;
                } else {
                    paystate = 0;
                }
                $.ajax({
                    url: "http://101.200.56.75/order/amendpaystatus?id=" + orderid + "&paystate=" + paystate,
                    type: "PUT",
                    success: function (res) {
                        alert(res);
//                     remond();
                    }
                })
                alert(orderid + "--" + paystate);
            }
        }



        function remond(page,size,sort,operation,key,value) {
            $.ajax({
                url: "http://101.200.56.75/order/orderspage?page="+page+"&size="+size+"&sort="+sort+"&operation="+operation+"&key="+key+"&value="+value,
                type: "GET",
                dataType: "json",
                success: function (res) {
                    p = res.payload.content;
                    maxpage = res.payload.totalPages;
                    $("#pager").html("");
                    $("#OrderTable  tr:not(:first)").html("");
                    page++;
                    addElementLiFirstAndUpone("pager",operation,key,value,page);
                    var OrderTable = document.getElementById("OrderTable");
                    for (var i = 0; i < p.length; i++) {
                        var row = OrderTable.insertRow(OrderTable.rows.length);
                        var c1 = row.insertCell(0);
                        c1.innerHTML = (page - 1) * default_size + i + 1;
                        var c2 = row.insertCell(1);
                        c2.innerHTML = p[i].ordertime;
                        var c3 = row.insertCell(2);
                        c3.innerHTML = p[i].moneySum;
                        var c4 = row.insertCell(3);
                        c4.innerHTML = p[i].amount;
                        var c5 = row.insertCell(4);
                        c5.innerHTML = p[i].paystate;
                        var c6 = row.insertCell(5);
                        c6.innerHTML = p[i]._shop._category.category;
                        var c7 = row.insertCell(6);
                        c7.innerHTML = "<shiro:hasPermission name="add">"+"<a href='#' title='修改订单'"
                            + "onclick=\"change('" + p[i].ordertime + "','" + p[i].orderid + "','" +  p[i].paystate + "','" + p[i].moneySum + "','" + p[i].amount + "','" + p[i].userid + "','" + p[i].shopid + "','" + p[i]._shop.shopname + "','" + p[i]._user.userName + "')\">"
                            + "<span class='glyphicon glyphicon-cog'></span>"
                            + "</a>"+"</shiro:hasPermission>"
                            + "<a href='#' title='查看订单'"
                            + "onclick=\"detail('" + p[i].moneySum + "','" + p[i].orderid + "','" + p[i]._shop.shopname + "','" + p[i]._shop.des + "','" + p[i]._user.userName + "','" + p[i].ordertime+ "')\">"
                            + "<span class='glyphicon glyphicon-list-alt'></span> &nbsp"
                            + "</a>"
                            + "<shiro:hasPermission name="del">"+"<a href='#' title='订单状态'"
                            + "onclick=\"status('"  + p[i].orderid + "','" + p[i].paystate  + "','" + p[i].shopname  + "')\">"
                            + "<span class='glyphicon glyphicon-remove'></span> &nbsp"
                            + "</a>"+"</shiro:hasPermission>";

                    }

                    for (var i = 1; i < maxpage + 1; i++) {
                        addElementLi("pager", i,operation,key,value);
                    }

//                    page--;
                    addElementLiNextAndEnd("pager",operation,key,value,page);

//                    addElementLiEnd("pager",operation,key,value);

//                    alert("remond()")
                }

            });
//            alert("remond()kuayu()")
        }


        //        {
        //            "orderid": 13,
        //            "ordertime": "2016-10-16 16:46:08",
        //            "paystate": 1,
        //            "moneySum": 10,
        //            "amount": 13,
        //            "userid": 4,
        //            "shopid": 6
        //        }

        function change(ordertime, orderid, paystate, moneySum,amount,userid,shopid,shopname,userName) {

            document.getElementById("orderid2").innerHTML = orderid;
//
            $("#ordertime2").val(ordertime);//jquery通过id属性并修改value属性为name
//
            $("#moneySum2").val(moneySum);//jquery通过id属性并修改value属性为price
            $("#amount2").val(amount);
            $("#userName2").val(userid+","+userName);
            $("#shopname2").val(shopid+","+shopname);
//            $("#professional2").val(userName);
            $("#paystate").val(paystate);
            $('#myModal2').modal('show');
        }




        function download(){
            msg = '是否把该页order表单导出excel';
            if(confirm(msg)){
                var url="http://101.200.56.75/order/file";
                window.open(url);
            }
        }






        //        {
        //            "ordertime": "2016-10-16 16:46:08",
        //            "paystate": 1,
        //            "moneySum": 10,
        //            "amount": 13,
        //            "userid": 4,
        //            "shopid": 6
        //        }
        var controll1=0,controll2=0;
        var userNameid,shopnameid;
        var ordertime, orderid, paystate, moneySum,amount;
        function check() {


            var isupaystate = /^[0-1]$/;
//            var isuserid =/^[1-9][0-9]*$/;

            if (document.getElementById("moneySum2").value == "") {
                alert("请输入菜品moneySum2！");
                document.forms.amendShopesForm.moneySum2.focus();
                return false;
            }
            if (document.getElementById("amount2").value == "") {
                alert("请输入amount2！");
                document.forms.amendShopesForm.amount2.focus();
                return false;
            }

            if (document.getElementById("paystate").value == "") {
                alert("请输入paystate！");
                document.forms.amendShopesForm.paystate.focus();
                return false;
            }else if (isupaystate.test(document.getElementById("paystate").value)) {
                paystate = document.getElementById("paystate").value;
            }else {
                alert("你的paystate选择有误，请重新选择");
                document.forms.amendShopesForm.paystate.focus();
                return false;
            }
            if( (controll1==0 && controll2==0)|| (controll1==1 && controll2==0) || (controll1==0 && controll2==1) ){
//                    controll=2;
                if (document.getElementById("userName2").value == "") {
                    alert("请输入userNameid！");
                    document.forms.amendShopesForm.userName2.focus();
                    return false;
                }else {
                    //...
                    $.ajax({
                        url: "http://101.200.56.75/users/username?username="+document.getElementById("userName2").value,
                        type: "GET",
                        dataType: "json",
                        success: function (res) {
                            if(res.payload=="" || res.payload==null){
                                controll1=0;
                                alert(document.getElementById("userName2").value+"不存在，请重新输入userNameid！");
                                document.forms.amendShopesForm.userName2.focus();

                                return false;
                            }else{
                                p=res.payload;
                                alert(p[0].userName + "-----存在")
//                    remond();
                                userNameid=p[0].userid;
//                            alert("回---调---调---试"+userNameid)
                                controll1=1;
                            }
                            if(controll1==1 && controll2==1){ dochange();}


                        }
                    })

                }
                if (document.getElementById("shopname2").value == "") {
                    alert("请输入shopname2！");
                    document.forms.amendShopesForm.shopname2.focus();
                    return false;
                }else{
                    $.ajax({
                        url: "http://101.200.56.75/shop/shopname?shopname="+ document.getElementById("shopname2").value,
                        type: "GET",
                        dataType: "json",
                        success: function (res) {
                            if(res.payload=="" || res.payload==null){
                                controll2=0;
                                alert(document.getElementById("shopname2").value+"不存在，请重新输入userNameid！");
                                document.forms.amendShopesForm.userName2.focus();
                                return false;
                            }else{
                                p=res.payload;
                                alert(p[0].shopname + "-----存在")
//                    remond();
                                shopnameid=p[0].shopid;
//                            alert("回---调---调---试"+userNameid)
                                controll2=1;
                            }

                            if(controll1==1 && controll2==1){ dochange();}

                        }
                    })

                }


            }


        }

        function dochange() {
//            if(controll==1){
            msg = '是否将' + name + '下架？';
//            }
            //                ordertime, orderid, paystate, moneySum,amount,shopname,userName;
            if (confirm(msg)) {  ordertime = document.getElementById("ordertime2").value;
//            if(controll==0){
                controll1=0;
                controll2=0;
                moneySum = document.getElementById("moneySum2").value;
                orderid = document.getElementById("orderid2").innerHTML;
                amount = document.getElementById("amount2").value;

//                userName = document.getElementById("userName2").value;
//                userName = document.getElementById("professional2").value;
//                phone = document.getElementById("phone2").value;
//            shop_status =
                alert(orderid + "--" + shopnameid + "--" + userNameid);
                var jsonput = {
                    "ordertime": ordertime,
                    "paystate": paystate,
                    "moneySum": moneySum,
                    "amount": amount,
                    "userid": userNameid,
                    "shopid": shopnameid
                };
                $.ajax({
                    url: "http://101.200.56.75/order/update/"+orderid,
                    type: "PUT",
                    data:JSON.stringify(jsonput),
                    dataType: 'json',
                    contentType:"application/json; charset=utf-8",
                    processData:false,
                    cache:false,
                    success: function (res) {
                        p=res.payload;
                        alert(p.orderid + "-----success")
//                        alert("回---调---调---试")
                        remond('0',default_size,default_sort);
                        $('#myModal2').modal('toggle')
                    }
                })
            }
//            alert("check()--调---试")
//        }
        }


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

<body onload="startTime()">
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#sidebar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"><span>Lumino</span>Admin</a>
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
        <li class="active"><a href="index.html"><span class="glyphicon glyphicon-dashboard"></span> Datastatistics</a></li>
        <li><a href="#"><span class="glyphicon glyphicon-shopping-cart"></span> Shop</a></li>
        <li><a href="#"><span class="glyphicon glyphicon-user"></span> User</a></li>
        <li><a href="#"><span class="glyphicon glyphicon-list-alt"></span> Order</a></li>
        <li><a href="#"><span class="glyphicon glyphicon-comment"></span> Messages</a></li>
        <%--<li><a href="panels.html"><span class="glyphicon glyphicon-info-sign"></span> Alerts &amp; Panels</a></li>--%>
        <li class="parent ">
            <a href="#">
                <span class="glyphicon glyphicon-download-alt"></span> Download <span data-toggle="collapse" href="#sub-item-1" class="icon pull-right"><em class="glyphicon glyphicon-s glyphicon-plus"></em></span>
            </a>
            <ul class="children collapse" id="sub-item-1">
                <li>
                    <a class="" href="#">
                        <span class="glyphicon glyphicon-circle-arrow-down"></span> Shop Excel
                    </a>
                </li>
                <li>
                    <a class="" href="#">
                        <span class="glyphicon glyphicon-circle-arrow-down"></span> User Excel
                    </a>
                </li>
                <li>
                    <a class="" href="#">
                        <span class="glyphicon glyphicon-circle-arrow-down"></span> Order Excel
                    </a>
                </li>
                <li>
                    <a class="" href="#">
                        <span class="glyphicon glyphicon-circle-arrow-down"></span> Messages Excel
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
            <li><a href="#"><span class="glyphicon glyphicon-home"></span></a></li>
            <li class="active">Order</li>
            <li> [<a href="/time" id="txt"> </a>]</li>
            <li>[<a href="#" onclick="back()"><span class='glyphicon glyphicon-share-alt'></span>&nbsp;返回 </a> ]/[ <a href="/help" ><span class='glyphicon glyphicon-question-sign'></span>&nbsp;帮助</a>]
            </li>
            <li> [<a href="/indexmain"><span class='glyphicon glyphicon-home'></span>&nbsp;主页</a>]</li>
            <li> [<a href="/thisuser"><span class='glyphicon glyphicon-user'></span>&nbsp;用户</a>]&nbsp;&nbsp;</li>
        </ol>
    </div><!--/.row-->

    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">OrderTable</h1>
        </div>
    </div><!--/.row-->

    <%--<div class="copyrights">Collect from <a href="http://www.cssmoban.com/" >网页模板</a></div>--%>

    <div class="row">
    <div class="panel panel-info">
        <div>
            <nav>
                <ul class="pager">
                    <li><a href="#" onclick=" return remond('0',default_size,default_sort) ">所有订单</a></li>
                    <li><a href="#" onclick=" return remond('0',default_size,default_sort,'eq','paystate',1) ">完成订单</a></li>
                    <li><a href="#" onclick=" return remond('0',default_size,default_sort,'eq','paystate',0) ">未完成订单</a></li>
                </ul>
            </nav>
        </div>
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover table-bordered" id="OrderTable">

                    <tr>
                        <th class="tableCenter">订单序号</th>
                        <th class="tableCenter">订单时间</th>
                        <th class="tableCenter">订单金额</th>
                        <th class="tableCenter">订单数量</th>
                        <th class="tableCenter">是否完成</th>
                        <th class="tableCenter">订单类型</th>
                        <th class="tableCenter">操作</th>
                    </tr>

                </table>
                <nav style="text-align: center">
                    <ul id="pager" class="pagination pagination-lg pager">
                        <%--<li class="disabled">--%>
                        <%--<a href="#"  aria-label="Next">--%>
                        <%--<span aria-hidden="true">首页</span>--%>
                        <%--</a>--%>
                        <%--</li>--%>
                        <%--<li><a href="#">1</a></li>--%>
                        <%--<li><a href="#">2</a></li>--%>
                        <%--<li><a href="#">3</a></li>--%>
                        <%--<li><a href="#">4</a></li>--%>
                        <%--<li><a href="#">5</a></li>--%>

                    </ul>
                </nav>

            </div>
        </div>
        <hr><shiro:hasRole name="admin">
        <div style="text-align: center">
            如果您需要打印order表单，请点击右边的按钮：
            <input type="button" class="btn btn-primary addUserAndDishes" value="导出excel" onclick="download()" />
        </div></shiro:hasRole>
    </div>
    <div style="height:1px;width: 100%;background: #CCC;margin-bottom: 10px"></div>
    <footer>
        <p>&copy; ${ORDER_SYS_NAME}-广商淘-后台管理系统</p>
    </footer>
</div>
</div>
<!-- 将外部文件引入放在最后面这里更多为了提高用户体验，不必像传统的放前面后必须加载完后页面才显示内容，延缓了页面响应 -->
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script type="text/javascript" src="js/bootstrap.min.js"></script>


<%--查看商品详情的模态框--%>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">详细信息</h4>
            </div>
            <div class="modal-body">
                <div class="panel panel-primary" style="margin-top: 10px">
                    <div class="panel-heading">
                        <h3 class="panel-title">商品详情</h3>
                    </div>
                    <div class="panel-body">
                        <p>
                        <h2 style="text-align: center;">
                            订单id： <span id="orderid"></span>
                        </h2>
                        <h3 style="text-align: center;">
                            <span style="color: red;font-weight: bold;" id="recommend"></span>
                        </h3>
                        <hr/>
                        <p>
                        <h3>
                            商品名称：<span id="shopname"></span>
                        </h3>
                        <h3>
                            用户： <span id="userName"></span>
                        </h3>
                        <h3>商品简介： <span id="Des"></span></h3>
                        <h3>
                            订单金额： <span id="moneySum"> </span> (元)
                        </h3>
                        <h3>
                            订单时间： <span id="ordertime"> </span> (元)
                        </h3>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary addUserAndDishes" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<%--修改商品详情的模态框--%>
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel2">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel2">用户修改弹窗</h4>
            </div>
            <div class="modal-body" name="mydiv">
                <div class="panel panel-primary" style="margin-top: 10px">
                    <div class="panel-heading">
                        <h3 class="panel-title">用户修改</h3>
                    </div>
                    <div class="panel-body">

                        <p>
                        <h2 style="text-align: center;">
                            商品id： <span id="orderid2"></span>
                        </h2>

                        <form class="form-horizontal" name="amendShopesForm" id="amendShopesForm" role="form"
                              style="margin-top: 20px"
                              method="get">

                            <div class="form-group">
                                <label for="ordertime2"
                                       class="col-sm-2 control-label">订单时间:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="ordertime2"
                                           value="" readonly
                                           size="20" name="ordertime2" placeholder="请输入订单时间">
                                </div>
                                <div style="color: red;float: right;" id="nameerror">由前端台下单后，不能修改</div>
                            </div>

                            <div class="form-group">
                                <label for="moneySum2"
                                       class="col-sm-2 control-label">订单金额:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="moneySum2"
                                           value="  "
                                           name="moneySum2" placeholder="请输入订单金额">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="amount2"
                                       class="col-sm-2 control-label">数量:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="amount2"
                                           value="  "
                                           name="amount2" placeholder="请输入数量">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="userName2"
                                       class="col-sm-2 control-label">下单用户:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="userName2"
                                           value="  "
                                           name="userName2" placeholder="请输入下单的用户">
                                </div>



                            </div>
                            <div class="form-group">
                                <label for="shopname2"
                                       class="col-sm-2 control-label">下单商品:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="shopname2"
                                           value="  "
                                           name="shopname2" placeholder="请输入下单的商品">
                                </div>

                            </div>




                            <div class="form-group">
                                <label for="paystate"
                                       class="col-sm-2 control-label">状&nbsp;&nbsp;&nbsp;&nbsp;态:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="paystate" name="paystate"
                                           placeholder="请从下面选择paystate" value=""
                                    >
                                    <select name="s2" onchange="ch2()">
                                        <option value="" selected="selected">请选择订单状态</option>
                                        <option value=0>0代表未付款</option>
                                        <option value=1>1正常已经付款</option>
                                    </select>

                                    <script type="text/javascript">
                                        function ch2(){
                                            var s2 = document.getElementsByName("s2")[0];
                                            $("#paystate").val(s2.value);
                                            alert('you choice:' + s2.value);
                                        }
                                    </script>
                                </div>

                                <div style="color: red;float: right;"></div>
                            </div>
                            <%--<input type="hidden" value="<%=request.getParameter("id")%>" id="dishesId" name="dishesId"/>--%>
                            <%--<input type="hidden" value="<%=request.getParameter("dishesImg")%>" id="dishesImg"--%>
                            <%--name="dishesImg"/>--%>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                    <input type="button" class="btn btn-primary" id="addbtu" value="确认修改"
                                           onclick="check()"/>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary addUserAndDishes" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
<%--<script src="js/jquery-1.11.1.min.js"></script>--%>
<script src="js/bootstrap.min.js"></script>
<%--<script src="js/chart.min.js"></script>--%>
<%--<script src="js/chart-data.js"></script>--%>
<script src="js/easypiechart.js"></script>
<script src="js/easypiechart-data.js"></script>
<script src="js/bootstrap-datepicker.js"></script>

</body>

</html>
