<%--
  Created by IntelliJ IDEA.
  User: Foreveross
  Date: 2017/2/6
  Time: 17:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>订单管理</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap-datepicker.min.css">
    <link rel="stylesheet" type="text/css" href="css/rightmain.css">
    <script type="text/javascript">
        var p, maxpage;
        var h;
        var default_size=5;
        var default_sort="orderid,asc";
        var _key=0;
        var orderEndDateMin,orderEndDateMax;
        var OrderByUsername,OrderByShop,OrderByCategory;
        var _operation;
            function ch3(){
            var s1 = document.getElementsByName("s1")[0];
            if (s1.value == "0") {
                alert("请重新选择记录数！");
                return false;
            }
            alert('you choice: 每页' + s1.value +"条记录");

            default_size=s1.value;
                if (_key==2) {
                    if(_operation=="username"){
                        remond('0',default_size,default_sort,_operation,_key,OrderByUsername);
                    }else if( _operation=="shopname"){
                        remond('0',default_size,default_sort,_operation,_key,OrderByShop);
                    }else if( _operation=="category"){
                        remond('0',default_size,default_sort,_operation,_key,OrderByCategory);
                    }else{
                        alert("出错");
                    }

                }else if (_key==3) {
                    remond('0',default_size,default_sort,orderEndDateMin,_key,orderEndDateMax);
                }else{
                    remond('0',default_size,default_sort);
                }

        }

        function ch2(){
            var s2 = document.getElementsByName("s2")[0];
            if (s2.value == "0") {
                alert("请重新选择排序方式！");
                return false;
            }
            alert('you choice: 排序方式为-->' + s2.value);

            default_sort=s2.value+",asc";
            if (_key==2) {
                if(_operation=="username"){
                    remond('0',default_size,default_sort,_operation,_key,OrderByUsername);
                }else if( _operation=="shopname"){
                    remond('0',default_size,default_sort,_operation,_key,OrderByShop);
                }else if( _operation=="category"){
                    remond('0',default_size,default_sort,_operation,_key,OrderByCategory);
                }else{
                    alert("出错");
                }

            }else if (_key==3) {
                remond('0',default_size,default_sort,orderEndDateMin,_key,orderEndDateMax);
            }else{
                remond('0',default_size,default_sort);
            }
//            remond('0',default_size,default_sort);
        }



        window.onload = function () {
            remond('0',default_size,default_sort);
//            alert("kuayu()")
        };




        function startTime()
        {
            var today=new Date()
            var h=today.getHours()
            var m=today.getMinutes()
            var s=today.getSeconds()
// add a zero in front of numbers<10
            m=checkTime(m)
            s=checkTime(s)
            document.getElementById('txt').innerHTML="<span class='glyphicon glyphicon-time'></span>&nbsp;"+ h+":"+m+":"+s
            t=setTimeout('startTime()',500)
        }

        function checkTime(i)
        {
            if (i<10)
            {i="0" + i}
            return i
        }


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


        function dodelete(orderid,paystate,name){
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
                        if (_key==2) {
                            if(_operation=="username"){
                                remond('0',default_size,default_sort,_operation,_key,OrderByUsername);
                            }else if( _operation=="shopname"){
                                remond('0',default_size,default_sort,_operation,_key,OrderByShop);
                            }else if( _operation=="category"){
                                remond('0',default_size,default_sort,_operation,_key,OrderByCategory);
                            }else{
                                alert("出错");
                            }

                        }else if (_key==3) {
                            remond('0',default_size,default_sort,orderEndDateMin,_key,orderEndDateMax);
                        }else{
                            remond('0',default_size,default_sort);
                        }
                    }
                })
                alert(orderid + "--" + paystate);
            }
        }



        function remond(page,size,sort,operation,key,value) {//后期想到一个好方法 直接拼接一个url当成参数传递过来就好了 可惜太迟了 现在改的话麻烦了点
            var url="http://101.200.56.75/order/orderspage?page="+page+"&size="+size+"&sort="+sort+"&operation="+operation+"&key="+key+"&value="+value;
            if(key==2){
                url="http://101.200.56.75/datastatistics/username2?&page="+page+"&size="+size+"&sort="+default_sort+"&"+operation+"="+value;
                _key=2;
                alert(url)
            }
            if(key==3){
                url="http://101.200.56.75/datastatistics/date?&page="+page+"&size="+size+"&sort="+sort+"&field=ordertime"+"&orderEndDateMin="+operation+"&orderEndDateMax="+value;
                _key=3;
                alert(url+"    key="+key)
            }
            $.ajax({
                url: url,
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
                        var c12 = row.insertCell(1);
                        c12.innerHTML = p[i].orderid;
                        var c2 = row.insertCell(2);
                        c2.innerHTML = p[i].ordertime;
                        var c3 = row.insertCell(3);
                        c3.innerHTML = p[i].moneySum;
                        var c4 = row.insertCell(4);
                        c4.innerHTML = p[i].amount;
                        var c5 = row.insertCell(5);
                        c5.innerHTML = p[i].paystate;
                        var c6 = row.insertCell(6);
                        c6.innerHTML = p[i]._shop._category.category;
                        var c7 = row.insertCell(7);
                        c7.innerHTML = "<shiro:hasPermission name="add">"+"<a href='#' title='修改商品'"
                            + "onclick=\"change('" + p[i].ordertime + "','" + p[i].orderid + "','" +  p[i].paystate + "','" + p[i].moneySum + "','" + p[i].amount + "','" + p[i].userid + "','" + p[i].shopid + "','" + p[i]._shop.shopname + "','" + p[i]._user.userName + "')\">"
                            + "<span class='glyphicon glyphicon-cog'></span>"
                            + "</a>"+"</shiro:hasPermission>"
                            + "<a href='#' title='查看商品'"
                            + "onclick=\"detail('" + p[i].moneySum + "','" + p[i].orderid + "','" + p[i]._shop.shopname + "','" + p[i]._shop.des + "','" + p[i]._user.userName + "','" + p[i].ordertime+ "')\">"
                            + "<span class='glyphicon glyphicon-list-alt'></span> &nbsp"
                            + "</a>"
                            + "<shiro:hasPermission name="del">"+"<a href='#' title='已售商品'"
                            + "onclick=\"dodelete('"  + p[i].orderid + "','" + p[i].paystate  + "','" + p[i].shopname  + "')\">"
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
                        if (_key==2) {
                            if(_operation=="username"){
                                remond('0',default_size,default_sort,_operation,_key,OrderByUsername);
                            }else if( _operation=="shopname"){
                                remond('0',default_size,default_sort,_operation,_key,OrderByShop);
                            }else if( _operation=="category"){
                                remond('0',default_size,default_sort,_operation,_key,OrderByCategory);
                            }else{
                                alert("出错");
                            }

                        }else if (_key==3) {
                            remond('0',default_size,default_sort,orderEndDateMin,_key,orderEndDateMax);
                        }else{
                            remond('0',default_size,default_sort);
                        }
                        $('#myModal2').modal('toggle')
                    }
                })
            }
//            alert("check()--调---试")
//        }
        }

               function orderSearch() {

                   orderEndDateMin=document.getElementById("orderEndDateMin").value;
                   orderEndDateMax=document.getElementById("orderEndDateMax").value;
                   if ( orderEndDateMin== "" || orderEndDateMax=="") {
                       alert("请输入日期")
                   }else{
                       remond('0',default_size,"orderid,asc",orderEndDateMin,3,orderEndDateMax);
                   }
//                   alert("         " )
               }


        function getOrderBy() {

            OrderByUsername=document.getElementById("OrderByUsername").value;
            OrderByShop=document.getElementById("OrderByShop").value;
            OrderByCategory=document.getElementById("OrderByCategory").value;
            if ( OrderByUsername== ""&& OrderByShop==""&& OrderByCategory=="") {//remond(page,size,sort,operation,key,value)
                     alert("请选择一个条件搜索order")
            }else if( OrderByUsername!= ""&& OrderByShop==""&& OrderByCategory=="") {
                alert("条件  "+OrderByUsername)
                _operation="username";
                remond('0',default_size,default_sort,_operation,2,OrderByUsername);
            }else if( OrderByUsername== ""&& OrderByShop!=""&& OrderByCategory=="") {
                alert("条件  "+OrderByShop)
                _operation="shopname";
                remond('0',default_size,default_sort,_operation,2,OrderByShop);
            }else if( OrderByUsername== ""&& OrderByShop==""&& OrderByCategory!="") {
                alert("条件  "+OrderByCategory)
                _operation="category";
                remond('0',default_size,default_sort,_operation,2,OrderByCategory);
            }else{
                alert( "  输入有误  请重新选择一个条件  " )
            }
        }

//        function OnInput (event) {
////            alert ("The new content: " + event.target.value);
//            getOrderBy();
//        }
//        // Internet Explorer
//        function OnPropChanged (event) {
//            if (event.propertyName.toLowerCase () == "value") {
//                alert ("The new content: " + event.srcElement.value);
//            }
//        }

    </script>


</head>
<body onload="startTime()">
<div class="iframecontent">
    <div class="pos">
        <i class="icoh"></i>
        <span>订单列表查看</span>



    </div>
    <div class="operate">
        <div class="pull-right">
            <ul class="nav_return">
                <li> 现在时间:[*<a href="/time" id="txt"> </a>*]</li><li>[ <a href="/indexmain"><span class='glyphicon glyphicon-home'></span>&nbsp;点击返回主页</a> ]</li>
            </ul>
        </div>
    </div>
    <div class="operate">
        <div class="pull-left">
<shiro:hasRole name="admin">
    <input type="button" onclick="download()" name="" value="导出EEXCEL" class="btn  btn-success">
</shiro:hasRole>
            <select name="s1" onchange="ch3()">
                <option value="0" selected="selected">请选择每页记录数</option>
                <option value=5>5</option>
                <option value=8>8</option>
                <option value=10>10</option>
            </select>

            <select name="s2" onchange="ch2()">
                <option value="0" selected="selected">请选择排序</option>
                <option value="orderid">id</option>
                <option value="moneySum">订单金额</option>
                <option value="amount">订单数量</option>
            </select>


            <form class="form-inline">
                <div class="form-group">
                    <div class="input-append date form_datetime">
                        <label >开始时间：</label>
                        <input size="16" id="orderEndDateMin" type="text" value="" readonly>
                        <span class="add-on">
                                <i class="icon-th glyphicon glyphicon-calendar"></i>
                            </span>
                    </div>
                </div>
                &nbsp;&nbsp;
                <div class="form-group">
                    <div class="input-append date form_datetime">
                        <label >结束时间：</label>
                        <input size="16" id="orderEndDateMax" type="text" value="" readonly>
                        <span class="add-on">
                                <i class="icon-th glyphicon glyphicon-calendar"></i>
                            </span>
                    </div>


                </div>
                <input type="button" class="btn btn-primary btn-ms"  value="开始搜索" onclick="orderSearch()" style="margin:auto 20px;"/>
                <input type="button" class="btn btn-primary btn-ms"  value="搜索" onclick="getOrderBy()"/>
                <input size="12" id="OrderByUsername" type="text" value="" placeholder="请输入用户名查找">
                <%--<input size="12" id="OrderByUsername" type="text" value="" placeholder="请输入用户名查找"  oninput="OnInput (event)" onpropertychange="OnPropChanged (event)">--%>
                <input size="12" id="OrderByShop" type="text" value="" placeholder="请输入商品名查找">
                <input size="12" id="OrderByCategory" type="text" value="" placeholder="请输入类型名查找">
            </form>


        </div>
        <!-- operate标题结束 -->
        <div class="list">
            <div class="tablewrap">
                <table class="table" width="100%" id="OrderTable">
                    <tr>
                        <th >订单序号</th>
                        <th >订单id</th>
                        <th >订单时间</th>
                        <th >订单金额</th>
                        <th >订单数量</th>
                        <th >是否完成</th>
                        <th >订单类型</th>
                        <th >操作</th>
                    </tr>
                </table>
                <nav style="text-align: center">
                    <ul id="pager" class="pagination pagination-lg pager">
                    </ul>
                </nav>

            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="js/bootstrap-datepicker.zh-CN.min.js"></script>
<script>

    $(".form_datetime").datepicker({
        language: 'zh-CN',
        todayHighlight: 1,
        autoclose: 1,
        format: 'yyyy-mm-dd'
    });
</script>
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
                                    <select name="s4" onchange="ch4()">
                                        <option value="" selected="selected">请选择订单状态</option>
                                        <option value=0>0代表未付款</option>
                                        <option value=1>1正常已经付款</option>
                                    </select>

                                    <script type="text/javascript">
                                        function ch4(){
                                            var s4 = document.getElementsByName("s4")[0];
                                            $("#paystate").val(s4.value);
                                            alert('you choice:' + s4.value);
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

</body>
</html>
