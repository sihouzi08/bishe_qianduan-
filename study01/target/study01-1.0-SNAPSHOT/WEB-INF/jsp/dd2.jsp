
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



        function checkDelete(id, name, obj) {
            msg = '是否将' + name + '下架？';
            if (confirm(msg)) {
                xmlAjaxRequest("/dishesStatus?id=" + id + "&shelvesed=" + 0, "post", true, null, deleteCallback, obj, null)
            }
        }

        function deleteCallback(responseTxt, obj) {
            obj.parentNode.parentNode.parentNode.removeChild(obj.parentNode.parentNode);
        }

        function getDishesList(page){
            xmlAjaxRequest("/getDishesList?page="+page, "post", true, null, showDishesList, null, null);
        }


        function showDishesList(responseXml, obj){

            var maxPage = responseXml.getElementsByTagName("maxPage");
            maxPage = maxPage[0].childNodes[0].nodeValue;
            var page = responseXml.getElementsByTagName("page");
            page = page[0].childNodes;
            var paper = document.getElementById("pager");
            paper.innerHTML = "";
            var Line ="<li class='disabled'>"
                    +      "<a href='#' aria-label='Previous'>"
                    +          "<span aria-hidden='true'>&laquo;</span>"
                    +      "</a>"
                    +  "</li>";
            for (var i=1;i<=maxPage;i++){
                Line += "<li><a href='#' onclick='getDishesList(" + i + ")'>"+i+"</a></li>"
            }
            Line += "<li>"
                    +  "<a href='#' aria-label='Next'>"
                    +  "<span aria-hidden='true'>&raquo;</span>"
                    +"</a>"
                    +"</li>";
            paper.innerHTML = Line;

            var table = document.getElementById("orderTable");
            table.innerHTML = "";
            var shopes = responseXml.getElementsByTagName("shop");
            for (var i = 0; i < shopes.length; i++) {
                var shop = shopes[i];
                var attrs = shop.childNodes;
                var shopId;
                var shopName;
                var category;
                var des;
                var picture;
                var shop_status;
                var put_time;
                var userphne;
                var price;
                for (var j = 0; j < attrs.length; j++) {
                    var attr = attrs[j];
                    if (attr.nodeName == "shopId") {
                        shopId = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "category") {
                        category = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "shop_status") {
                        shop_status = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "shopName") {
                        shopName = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "des") {
                        des = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "pricture") {
                        pricture = attr.childNodes[0].nodeValue;
                    }
//                    if (attr.nodeName == "put_time") {
//                        put_time = attr.childNodes[0].nodeValue;
//                    }
                    if (attr.nodeName == "userphne") {
                        userphne = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "price") {
                        price = attr.childNodes[0].nodeValue;
                    }
                }

                shop_status = shop_status=="0"?"下架":"上架";
                var subdes = des;
                var subuserphne = userphne == 1?"推荐":"非推荐";
                var newLine = "<tr>"
                        +  "<td class='tableCenter'>" + shopId + "</td>"
                        +  "<td class='tableCenter'>" + shopName + "</td>"
                        +  "<td class='tableCenter'>" + des + "</td>"
                        +  "<td class='tableCenter'>" + price + "</td>"
                        +  "<td class='tableCenter'>" + subuserphne + "</td>"
                        +  "<td class='tableCenter'>" + shop_status + "</td>"
                        +  "<td class='tableCenter'>"
                        +      "<a href='adminAmendDishes.jsp?id="+dishesId+"&name="+dishesName+"&discript="+dishesDiscript+"&txt="+dishesTxt+"&price="+dishesPrice+"&recommend="+recommend+"&dishesImg="+dishesImg+"'title='编辑菜品'>"
                        +          "<span class='glyphicon glyphicon-cog'></span>"
                        +      "</a>"
                        +      "<a href='#' title='查看菜品'"
                        +         "onclick=\"detail('" + dishesName + "','" + dishesDiscript + "','" + dishesTxt+ "','" + dishesPrice + "','" + dishesImg + "','" + dishesType + "')\">"
                        +          "<span class='glyphicon glyphicon-list-alt'></span> &nbsp"
                        +      "</a>"
                        +      "<a href='#' title='下架菜品'"
                        +         "onclick=\"checkDelete('" + dishesId + "','" + dishesName + "',this)\">"
                        +          "<span class='glyphicon glyphicon-remove'></span> &nbsp"
                        +      "</a>"
                        +  "</td>"
                        +"</tr>"

                table.innerHTML += newLine;

            }
        }
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
<body class="bjys"style="height:90%;"onload="getDishesList(1)">
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
                <table class="table table-striped table-hover table-bordered">
                    <thead>
                    <tr>
                        <th class="tableCenter">商品编号</th>
                        <th class="tableCenter">商品名称</th>
                        <th class="tableCenter">商品简介</th>
                        <th class="tableCenter">商品价格</th>
                        <th class="tableCenter">是否推荐</th>
                        <th class="tableCenter">商品状态</th>
                        <th class="tableCenter">操作</th>
                    </tr>
                    </thead>
                    <tbody id="orderTable">

                    </tbody>
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

                        <div style="text-align: center;">
                            <img src="img/userIcon.jpg" id="dishesImg" width="200px"
                                 height="200px" class="img-circle"
                                 style="border:1px solid #CCC;box-shadow:0 0 10px rgba(100, 100, 100, 1);"/>
                        </div>
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
