<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" type="text/css" href="css/dashboard.css">
    <link rel="stylesheet" href="css/common.css" type="text/css"/>
    <title>"广商淘"系统</title>
    <script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
    <script src="js/ajax.js"></script>
    <script type="text/javascript">
        var p, maxpage;
        var h;
        var default_size=5;
        var default_sort="orderid,asc";
        window.onload = function () {
            remond('0',default_size,default_sort);
            alert("kuayu()")
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


        function status(orderid,shop_status,name){
            msg = '是否将' + name + '下架？';
            if (confirm(msg)) {
                if (shop_status == 0) {
                    shop_status = 1;
                } else {
                    shop_status = 0;
                }
                $.ajax({
                    url: "http://101.200.56.75/shop/amendShop_status?id=" + orderid + "&shop_status=" + shop_status,
                    type: "PUT",
                    success: function (res) {
                        alert(res);
//                     remond();
                    }
                })
                alert(orderid + "--" + shop_status);
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
                        c7.innerHTML = "<a href='#' title='修改商品'"
                            + "onclick=\"change('" + p[i].ordertime + "','" + p[i].orderid + "','" +  p[i].paystate + "','" + p[i].moneySum + "','" + p[i].amount + "','" + p[i].userid + "','" + p[i].shopid + "','" + p[i]._shop.shopname + "','" + p[i]._user.userName + "')\">"
                            + "<span class='glyphicon glyphicon-cog'></span>"
                            + "</a>"
                            + "<a href='#' title='查看商品'"
                            + "onclick=\"detail('" + p[i].moneySum + "','" + p[i].orderid + "','" + p[i]._shop.shopname + "','" + p[i]._shop.des + "','" + p[i]._user.userName + "','" + p[i].ordertime+ "')\">"
                            + "<span class='glyphicon glyphicon-list-alt'></span> &nbsp"
                            + "</a>"
                            + "<a href='#' title='已售商品'"
                            + "onclick=\"status('"  + p[i].orderid + "','" + p[i].shop_status  + "','" + p[i].shopname  + "')\">"
                            + "<span class='glyphicon glyphicon-remove'></span> &nbsp"
                            + "</a>";

                    }

                    for (var i = 1; i < maxpage + 1; i++) {
                        addElementLi("pager", i,operation,key,value);
                    }

//                    page--;
                    addElementLiNextAndEnd("pager",operation,key,value,page);

//                    addElementLiEnd("pager",operation,key,value);

                    alert("remond()")
                }

            });
            alert("remond()kuayu()")
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
        function check() {
            msg = '是否将' + name + '下架？';
            var ordertime, orderid, paystate, moneySum,amount,shopname,userName;
            if (confirm(msg)) {
                if (document.getElementById("ordertime2").value == "") {
                    alert("请输入ordertime2！");
                    document.forms.amendShopesForm.ordertime2.focus();
                    return false;
                }
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
                if (document.getElementById("userName2").value == "") {
                    alert("请输入userName2！");
                    document.forms.amendShopesForm.userName2.focus();
                    return false;
                }
                if (document.getElementById("shopname2").value == "") {
                    alert("请输入shopname2！");
                    document.forms.amendShopesForm.shopname2.focus();
                    return false;
                }
//                ordertime, orderid, paystate, moneySum,amount,shopname,userName;
                ordertime = document.getElementById("ordertime2").value;
                moneySum = document.getElementById("moneySum2").value;
                orderid = document.getElementById("orderid2").innerHTML;
                amount = document.getElementById("amount2").value;
                shopname = document.getElementById("shopname2").value;
                userName = document.getElementById("userName2").value;
//                userName = document.getElementById("professional2").value;
//                phone = document.getElementById("phone2").value;
//            shop_status =
                alert(userid + "--" + userName + "--" + school);
                var jsonput = {
                    "ordertime": "2016-10-16 16:46:08",
                    "paystate": 1,
                    "moneySum": 10,
                    "amount": 13,
                    "userid": 4,
                    "shopid": 6
                };
                $.ajax({
                    url: "http://101.200.56.75/users/update/"+userid,
                    type: "PUT",
                    data:JSON.stringify(jsonput),
                    dataType: 'json',
                    contentType:"application/json; charset=utf-8",
                    processData:false,
                    cache:false,
                    success: function (res) {
                        p=res.payload;
                        alert(p.userid + "-----success")
//                    remond();
                        alert("回---调---调---试")
                    }
                })
            }
            alert("check()--调---试")
        }

    </script>

</head>
<body class="bjys" style="height:90%">
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand " href="#" style="padding-left: 35px">
            <span class="glyphicon glyphicon-home navFont"><strong class=“systemTitle”> 广商淘-订单模块</strong></span>
        </a>
    </div>
</nav>
<!-- 右边详细内容 -->
<div>
    <div class="panel panel-info">
        <div class="panel-heading">
            <h3 class="panel-title">商品列表</h3>
        </div>
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
        <hr>
        <div style="text-align: center">
            如果您需要打印order表单，请点击右边的按钮：
            <input type="button" class="btn btn-primary addUserAndDishes" value="导出excel" onclick="download()" />
        </div>
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
                                           value="  "
                                           size="20" name="ordertime2" placeholder="请输入订单时间">
                                </div>
                                <div style="color: red;float: right;" id="nameerror"></div>
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
                                <%--<select name="s1" onchange="ch3()">--%>
                                    <%--<option value="0" selected="selected">请选择</option>--%>
                                <%--</select>--%>

                                <%--<script type="text/javascript">--%>
                                    <%--function ch3(){--%>
                                        <%--var s1 = document.getElementsByName("s1")[0];--%>
<%--//                                        $("#categoryid").val("这是--2,电子");--%>
                                        <%--alert('you choice:' + s1.value);--%>
                                    <%--}--%>
                                <%--</script>--%>

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
                                <label for="shop_status2" class="col-sm-2 control-label"></label>
                                <div class="col-sm-10">
                                    <input type="checkbox" name="shop_status2" id="shop_status2"
                                           value=""/>
                                    <span style="font-size: 16px;font-weight: bold;">推荐商品</span>
                                </div>
                                <div style="color: red;float: right;" id="priceerror"></div>
                            </div>
                            <%--<input type="hidden" value="<%=request.getParameter("id")%>" id="dishesId" name="dishesId"/>--%>
                            <%--<input type="hidden" value="<%=request.getParameter("dishesImg")%>" id="dishesImg"--%>
                            <%--name="dishesImg"/>--%>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                    <input type="submit" class="btn btn-primary" id="addbtu" value="确认修改"
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

