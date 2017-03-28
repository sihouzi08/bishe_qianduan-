<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        var default_sort="shopid,asc";
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
//            alert("page =" + page + "   ......  最大页数：" + maxpage)
            if(tof==1){//uponetest


                var _page = parseInt(page) - 2 ;

                if (_page < 0) {
                    alert("当前第"+_page + "页的显示" + " 已经 shi最大页数：" + maxpage);
                    return false;
                }
                remond(_page ,default_size,default_sort,operation,key,value);
//                alert("当前第" + (_page+1) + "页的显示" + "   ......  最大页数：" + maxpage)
            }else{//nexttest

                var _page = parseInt(page)  ;

                if (_page >= maxpage) {
                    alert("当前第"+_page + "页的显示" + " 已经 shi最大页数：" + maxpage);
                    return false;
                }
                remond(_page ,default_size,default_sort,operation,key,value);
//                alert("当前第" + _page + "页的显示" + "   ......  最大页数：" + maxpage)
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


        //显示商品详情调用模态框
        function detail(name, shopid, shop_status, des, price,userName,picture,userphne) {
            var shop_status = shop_status == "0" ? "下架" : "上架";
            document.getElementById("ShopName").innerHTML = name;
            document.getElementById("Des").innerHTML = des;
            document.getElementById("price").innerHTML = price;
            document.getElementById("shopid").innerHTML = shopid;
            document.getElementById("userName0").innerHTML = userName;
            document.getElementById("shop_status").innerHTML = shop_status;
            document.getElementById("picture0").innerHTML = picture;
            document.getElementById("userphne0").innerHTML = userphne;
            $('#myModal').modal('show');
        }


        function status(shopid,shop_status,name){
            msg = '是否将' + name + '下架？';
            if (confirm(msg)) {
                if (shop_status == 0) {
                    shop_status = 1;
                } else {
                    shop_status = 0;
                }
                $.ajax({
                    url: "http://101.200.56.75/shop/amendShop_status?id=" + shopid + "&shop_status=" + shop_status,
                    type: "PUT",
                    success: function (res) {
                        alert(res);
                        remond('0',default_size,default_sort);
                    }
                })
            }
        }



        //显示商品修改调用模态框
        function change(name, shopid, shop_status, price,des,userName,userphne,categoryid,picture) {

            document.getElementById("shopid2").innerHTML = shopid;
            $("#shop_status").val(shop_status);
            $("#shopesName").val(name);//jquery通过id属性并修改value属性为name
            $("#picture").val(picture);
            $("#shopesPrice").val(price);//jquery通过id属性并修改value属性为price
            $("#_des").val(des);
            $("#userName").val(userName);
            $("#userphne").val(userphne);
            $("#categoryid").val(categoryid);
            $("#shop_status2").val(shop_status);
            $('#myModal2').modal('show');
        }

        function remond(page,size,sort,operation,key,value) {
            $.ajax({
                url: "http://101.200.56.75/shop/newspage?page="+page+"&size="+size+"&sort="+sort+"&operation="+operation+"&key="+key+"&value="+value,
                type: "GET",
                dataType: "json",
                success: function (res) {
                    p = res.payload.content;
                    maxpage = res.payload.totalPages;
                    $("#pager").html("");
                    $("#ShopTable  tr:not(:first)").html("");
                     page++;
                    addElementLiFirstAndUpone("pager",operation,key,value,page);
                    var ShopTable = document.getElementById("ShopTable");
                    for (var i = 0; i < p.length; i++) {
                        var row = ShopTable.insertRow(ShopTable.rows.length);
                        var c1 = row.insertCell(0);
                        c1.innerHTML = (page - 1) * default_size + i + 1;
                        var c2 = row.insertCell(1);
                        c2.innerHTML = p[i].shopname;
                        var c3 = row.insertCell(2);
                        c3.innerHTML = p[i].des;
                        var c4 = row.insertCell(3);
                        c4.innerHTML = p[i].price;
                        var shop_status = p[i].shop_status == "0" ? "下架" : "上架";
                        var c5 = row.insertCell(4);
                        c5.innerHTML = shop_status;
                        var c6 = row.insertCell(5);
                        c6.innerHTML = p[i].userName;
                        var c8 = row.insertCell(6);
                        c8.innerHTML = p[i]._category.category
                        var c7 = row.insertCell(7);
                        c7.innerHTML = "<shiro:hasPermission name="add">"+"<a href='#' title='修改商品'"
                                + "onclick=\"change('" + p[i].shopname + "','" + p[i].shopid + "','" + p[i].shop_status + "','" + p[i].price + "','" + p[i].des + "','" + p[i].userName + "','" + p[i].userphne + "','" + p[i].category_id + "','" + p[i].picture + "')\">"
                                + "<span class='glyphicon glyphicon-cog'></span>"
                                + "</a>"+"</shiro:hasPermission>"
                                +"<a href='#' title='商品详情'"
                                + "onclick=\"detail('" + p[i].shopname + "','" + p[i].shopid + "','" + p[i].shop_status + "','" + p[i].des + "','" + p[i].price + "','" + p[i].userName + "','" + p[i].picture + "','" + p[i].userphne + "')\">"
                                + "<span class='glyphicon glyphicon-list-alt'></span> &nbsp"
                                + "</a>"
                                + "<shiro:hasPermission name="del">"+"<a href='#' title='商品下架'"
                                + "onclick=\"status('"  + p[i].shopid + "','" + p[i].shop_status  + "','" + p[i].shopname  + "')\">"
                                + "<span class='glyphicon glyphicon-remove'></span> &nbsp"
                                + "</a>"+"</shiro:hasPermission>";

                    }

                    for (var i = 1; i < maxpage + 1; i++) {
                        addElementLi("pager", i,operation,key,value);
                    }
                    addElementLiNextAndEnd("pager",operation,key,value,page);
                }
            });
        }

        function download(){
            msg = '是否把该页shop表单导出excel';
            if(confirm(msg)){
                var url="http://101.200.56.75/shop/file";
                window.open(url);
            }
        }


//        {
//            "shopname": "a",
//            "des": "b",
//            "userName": "c",
//            "userphne": "13723697188",
//            "categoryid": "c",
//            "picture": "u",
//            "price": "24",
//            "shop_status": "1"
//        }
        function check() {
            msg = '是否将' + name + '下架？';
            var isphone = /^(13[0-9]|14(5|7)|15(0|1|2|3|5|6|7|8|9)|18[0-9])\d{8}$/;
            var categoryid = /^[1-4]$/;
            var isshop_status = /^[0-1]$/;
            var name, shopid, shop_status, des, price,userName,userphne,category_id,picture;
            if (confirm(msg)) {
                if(isphone.test(document.getElementById("userphne").value)){
                    userphne = document.getElementById("userphne").value;
                }else if (document.getElementById("userphne").value == "") {
                    alert("请输入userphne！");
                    document.forms.amendShopesForm.userphne.focus();
                    return false;
                } else {
                    document.forms.amendShopesForm.userphne.focus();
                    alert('你所输入的不是手机号码');
                    return false;
                }
            if (document.getElementById("_des").value == "") {
                alert("请输入shuoming！");
                document.forms.amendShopesForm._des.focus();
                return false;
            }
            if (document.getElementById("shopesPrice").value == "") {
                alert("请输入菜品jiage！");
                document.forms.amendShopesForm.shopesPrice.focus();
                return false;
            }
                if (document.getElementById("userName").value == "") {
                    alert("请输入userName！");
                    document.forms.amendShopesForm.userName.focus();
                    return false;
                }

                if (document.getElementById("categoryid").value == "") {
                    alert("请输入categoryid！");
                    document.forms.amendShopesForm.categoryid.focus();
                    return false;
                }else if (categoryid.test(document.getElementById("categoryid").value)) {
                    category_id = document.getElementById("categoryid").value;
                }else{
                    alert("你的categoryid选择有误，请重新选择");
                    document.forms.amendShopesForm.categoryid.focus();
                    return false;
                }
                if (document.getElementById("shop_status2").value == "") {
                    alert("请输入shop_status2！");
                    document.forms.amendShopesForm.shop_status2.focus();
                    return false;
                }else if (isshop_status.test(document.getElementById("shop_status2").value)) {
                    shop_status = document.getElementById("shop_status2").value;
                }else {
                    alert("你的shop_status2选择有误，请重新选择");
                    document.forms.amendShopesForm.shop_status2.focus();
                    return false;
                }
                if (document.getElementById("shopesName").value == "") {
                    alert("请输入shopesName！");
                    document.forms.amendShopesForm.shopesName.focus();
                    return false;
                }
                picture= document.getElementById("picture").value;
                name = document.getElementById("shopesName").value;
            des = document.getElementById("_des").value;
            price = document.getElementById("shopesPrice").value;
            shopid = document.getElementById("shopid2").innerHTML;

                userName = document.getElementById("userName").value;

//            alert(shopid + "--" + des + "--" + price);
            var jsonput={
                "shopname": name,
                "des": des,
                "userName": userName,
                "category_id":category_id,
                "userphne": userphne,
                "picture": picture,
                "price": price,
                "shop_status":shop_status
            };
            $.ajax({
                url: "http://101.200.56.75/shop/update/"+shopid,
                type: "PUT",
                data:JSON.stringify(jsonput),
                dataType: 'json',
                contentType:"application/json; charset=utf-8",
                processData:false,
                cache:false,
                success: function (res) {
                    p=res.payload;
//                    alert(p.shopid + "-----success")
//
                     alert("回---调---调---试");
                     $('#myModal2').modal('toggle')
                     remond('0',default_size,default_sort);
                }
            })
            }
//            alert("check()--调---试")
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
            <span class="glyphicon glyphicon-home navFont"><strong class=“systemTitle”> 广商淘-商品查看模块</strong></span>
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
                    <li><a href="#" onclick=" return remond('0',default_size,default_sort) ">所有商品</a></li>
                    <li><a href="#" onclick=" return remond('0',default_size,default_sort,'eq','shop_status',1) ">在售商品</a></li>
                    <li><a href="#" onclick=" return remond('0',default_size,default_sort,'eq','shop_status',0) ">已售商品</a></li>
                </ul>
            </nav>
        </div>
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover table-bordered" id="ShopTable">

                    <tr>
                        <th class="tableCenter">商品序号</th>
                        <th class="tableCenter">商品名称</th>
                        <th class="tableCenter">商品简介</th>
                        <th class="tableCenter">商品价格(元)</th>
                        <th class="tableCenter">商品状态</th>
                        <th class="tableCenter">上传者</th>
                        <th class="tableCenter">所属种类</th>
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
            如果您需要打印shop表单，请点击右边的按钮：<br/>admin角色登录显示此内容
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
                            商品id： <span id="shopid"></span>
                        </h2>
                        <h3 style="text-align: center;">
                            <span style="color: red;font-weight: bold;" id="recommend"></span>
                        </h3>
                        <hr/>
                        <p>
                        <h3>
                            商品名称：
                        </h3>
                        <p><span id="ShopName"></span></p>
                        <h3>
                           上传者名字：
                        </h3>
                        <p><span id="userName0"></span></p>
                        <h3>
                            上传者电话：
                        </h3>
                        <p><span id="userphne0"></span></p>
                        <h3>
                            商品状态：
                        </h3>
                        <p><span id="shop_status"></span></p>

                        <h3>商品简介：</h3>
                        <p>
                            <span id="Des"></span>
                        </p>
                        <h3>商品图片：</h3>
                        <p>
                            <span id="picture0"></span>
                        </p>
                        <h3>
                            商品价格： <span id="price"> </span> (元)
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
                <h4 class="modal-title" id="myModalLabel2">修改弹窗</h4>
            </div>
            <div class="modal-body" name="mydiv">
                <div class="panel panel-primary" style="margin-top: 10px">
                    <div class="panel-heading">
                        <h3 class="panel-title">商品修改</h3>
                    </div>
                    <div class="panel-body">

                        <p>
                        <h2 style="text-align: center;">
                            商品id： <span id="shopid2"></span>
                        </h2>

                        <form class="form-horizontal" name="amendShopesForm" id="amendShopesForm" role="form"
                              style="margin-top: 20px"
                              method="get">

                            <div class="form-group">
                                <label for="shopesName"
                                       class="col-sm-2 control-label">名&nbsp;&nbsp;&nbsp;&nbsp;称:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="shopesName"
                                           value="  "
                                           size="20" name="shopesName" placeholder="请输入商品名称">
                                </div>
                                <div style="color: red;float: right;" id="nameerror"></div>
                            </div>

                            <div class="form-group">
                                <label for="userName"
                                       class="col-sm-2 control-label">用&nbsp;&nbsp;户&nbsp;&nbsp;名:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="userName"
                                           value="  "
                                           name="userName" placeholder="请输入上传的用户名">
                                </div>
                            </div>


                            <div class="form-group">
                                <label for="_des"
                                       class="col-sm-2 control-label">说&nbsp;&nbsp;&nbsp;&nbsp;明:</label>
                                <div class="col-sm-10">
                                <textarea rows="8" class="form-control" id="_des"
                                          name="_des"></textarea>
                                </div>
                                <div style="color: red;float: right;" id="passerror"></div>
                            </div>
                            <div class="form-group">
                                <label for="shopesPrice"
                                       class="col-sm-2 control-label">价&nbsp;&nbsp;&nbsp;&nbsp;格:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="shopesPrice" name="shopesPrice"
                                           placeholder="请输入商品价格" value=""
                                    >
                                </div>
                                <div style="color: red;float: right;"></div>
                            </div>
                            <div class="form-group">
                                <label for="shopesPrice"
                                       class="col-sm-2 control-label">电&nbsp;&nbsp;&nbsp;&nbsp;话:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="userphne" name="userphne"
                                           placeholder="请输入userphne" value=""
                                    >
                                </div>
                                <div style="color: red;float: right;"></div>
                            </div>
                            <div class="form-group">
                                <label for="picture"
                                       class="col-sm-2 control-label">图&nbsp;&nbsp;&nbsp;&nbsp;片:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="picture" name="picture"
                                           placeholder="请输入picture" value="" readonly>
                                </div>
                                <div style="color: red;float: right;">图片由前端指定后，不能修改</div>
                            </div>
                            <div class="form-group">
                                <label for="categoryid"
                                       class="col-sm-2 control-label">种&nbsp;&nbsp;&nbsp;&nbsp;类:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="categoryid" name="categoryid"
                                           placeholder="请从下面选择categoryid" value=""
                                    >
                                    <select name="s1" onchange="ch3()">
                                        <option value="" selected="selected">请选择</option>
                                        <option value=1>运动</option>

                                        <option value=2>电子</option>
                                        <option value=3>书籍</option>
                                        <option value=4>食物</option>
                                    </select>

                                    <script type="text/javascript">
                                        function ch3(){
                                            var s1 = document.getElementsByName("s1")[0];
                                            $("#categoryid").val(s1.value);
                                            alert('you choice:' + s1.value);
                                        }
                                    </script>
                                </div>

                                <div style="color: red;float: right;"></div>
                            </div>
                            <div class="form-group">
                                <label for="shop_status2"
                                       class="col-sm-2 control-label">状&nbsp;&nbsp;&nbsp;&nbsp;态:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="shop_status2" name="shop_status2"
                                           placeholder="请从下面选择shop_status2" value=""
                                    >
                                    <select name="s2" onchange="ch2()">
                                        <option value="" selected="selected">请选择状态</option>
                                        <option value=0>0代表下架</option>
                                        <option value=1>1代表上架</option>
                                    </select>

                                    <script type="text/javascript">
                                        function ch2(){
                                            var s2 = document.getElementsByName("s2")[0];
                                            $("#shop_status2").val(s2.value);
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


</body>

</html>

