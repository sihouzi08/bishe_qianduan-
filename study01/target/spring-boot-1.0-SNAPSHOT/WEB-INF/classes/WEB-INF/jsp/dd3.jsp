
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/6/5
  Time: 16:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html >
<head>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" type="text/css" href="css/dashboard.css">
    <link rel="stylesheet" href="css/common.css" type="text/css" />
    <title>"广商淘"系统</title>
    <script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
    <script src="js/ajax.js"></script>
    <script type="text/javascript">
        var p;
        window.onload =function() {
            $.ajax({
                url: "http://101.200.56.75/users/",
                type: "GET",
                dataType: "json",
                success: function (res) {
                    p = res.payload;



                    var ShopTable = document.getElementById("ShopTable");
                    for (var i = 0; i < p.length; i++) {
                        var row = ShopTable.insertRow(ShopTable.rows.length);
                        var c1 = row.insertCell(0);
                        c1.innerHTML = i+1;
                        var c2 = row.insertCell(1);
                        c2.innerHTML = p[i].userName;
                        var c3 = row.insertCell(2);
                        c3.innerHTML = p[i].password;
                        var c4 = row.insertCell(3);
                        c4.innerHTML = p[i].email;
                        var c5 = row.insertCell(4);
                        c5.innerHTML = p[i].school;
                        var c6 = row.insertCell(5);
                        c6.innerHTML = p[i].court;
                        var c7 = row.insertCell(6);
                        c7.innerHTML = p[i].professional;
                        var c8 = row.insertCell(7);
                        c8.innerHTML = p[i].phone;
                        var c9 = row.insertCell(8);
                        c9.innerHTML = p[i].rental;
//                        var c10 = row.insertCell(9);
//                        c10.innerHTML = p[i].tenancy;
                    }






//                                      for(var i=0,l=p.length;i<l;i++){
//                        for (var key in p[i]) {
//                            alert(key + ':' + p[i][key]);
//                        }
//                    }





                    alert("用户()")
                }

            });
            alert("kuayu()")
        }


        function checkDelete(id, name, obj) {
            msg = '是否将' + name + '下架？';
            if (confirm(msg)) {
                xmlAjaxRequest("/dishesStatus?id=" + id + "&shelvesed=" + 0, "post", true, null, deleteCallback, obj, null)
            }
        }

        function deleteCallback(responseTxt, obj) {
            obj.parentNode.parentNode.parentNode.removeChild(obj.parentNode.parentNode);
        }

//        function getDishesList(page){
//            xmlAjaxRequest("/getDishesList?page="+page, "post", true, null, showDishesList, null, null);
//        }


        //显示菜品详情调用模态框
        function detail(name, discript, txt, price, img, dishesType) {
            var dishesName = document.getElementById("dishesName");
            var dishesDiscript = document.getElementById("dishesDiscript");
            var dishesTxt = document.getElementById("dishesTxt");
            var dishesPrice = document.getElementById("dishesPrice");
            var dishesImg = document.getElementById("dishesImg");
            var type = document.getElementById("type");
            type.innerHTML = dishesType;
            dishesImg.src = "img/" + img;
            dishesName.innerHTML = name;
            dishesDiscript.innerHTML = discript;
            dishesTxt.innerHTML = txt;
            dishesPrice.innerHTML = price;
            $('#myModal').modal('show');
        }
    </script>

</head>
<body class="bjys"style="height:90%">
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
            <span class="glyphicon glyphicon-home navFont"><strong class=“systemTitle”> 广商淘-商品查看模块</strong></span>
        </a>
    </div>
</nav>
<!-- 右边详细内容 -->
<div >
    <div class="panel panel-info">
        <div class="panel-heading">
            <h3 class="panel-title">商品列表</h3>
        </div>
        <div>
            <nav>
                <ul class="pager">
                    <li><a href="adminDishes.jsp">在售商品</a></li>
                    <li><a href="adminDishesUnder.jsp">已售商品</a></li>
                </ul>
            </nav>
        </div>
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover table-bordered"  id="ShopTable">

                    <tr>
                        <th class="tableCenter">用户编号</th>
                        <th class="tableCenter">用户名称</th>
                        <th class="tableCenter">用户密码</th>
                        <th class="tableCenter">用户邮箱</th>
                        <th class="tableCenter">用户学校</th>
                        <th class="tableCenter">用户系别</th>
                        <th class="tableCenter">用户专业</th>
                        <th class="tableCenter">用户电话</th>
                        <th class="tableCenter">操作</th>
                    </tr>

                </table>
                <nav style="text-align: center">
                    <ul id="pager" class="pagination pagination-lg pager">

                    </ul>
                </nav>

            </div>
        </div>
        <hr>
        <div style="text-align: center">
            如果您需要在系统中推荐一个新商品，请点击右边的按钮：
            <a href="adminAddDishes.jsp" class="btn btn-primary addUserAndDishes">推荐商品</a>
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






<%--查看菜品详情的模态框--%>

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
                        <h3 class="panel-title">菜品详情</h3>
                    </div>
                    <div class="panel-body">


                        <p>
                        <h2 style="text-align: center;">
                            菜品名称： <span id="dishesName"></span>
                        </h2>
                        <h3 style="text-align: center;">
                            <span style="color: red;font-weight: bold;" id="recommend"></span>
                        </h3>
                        <hr/>
                        <p>
                        <h3>
                            菜品分类：
                        </h3>
                        <p><span id="type">主菜</span></p>
                        <h3>
                            菜品简介：
                        </h3>
                        <p><span id="dishesDiscript"></span></p>
                        <p>
                        <h3>菜品描述：</h3>
                        <p>
                            <span id="dishesTxt"></span>
                        </p>
                        <h3>
                            菜品价格：<span id="dishesPrice"> </span> (元)
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
</body>

</html>

