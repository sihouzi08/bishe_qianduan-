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
        var default_sort="messageid,asc";
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


        //显示商品详情调用模态框
        function detail(content, messageid, leave_time, leave_status, userName, shopname) {
            leave_status = leave_status == "0" ? "无效" : "通过";
            document.getElementById("leave_time").innerHTML = leave_time;
            document.getElementById("content").innerHTML = content;
            document.getElementById("userName").innerHTML = userName;
            document.getElementById("messageid").innerHTML = messageid;
            document.getElementById("shopname").innerHTML = shopname;
            document.getElementById("leave_status").innerHTML = leave_status;


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
//                     remond();
                    }
                })
                alert(shopid + "--" + shop_status);
            }
        }



        //显示商品修改调用模态框
        function change(name, shopid, shop_status, des, price) {

            document.getElementById("shopid2").innerHTML = shopid;

//            document.amendShopesForm.shopesName.value == name;

            $("#shopesName").val(name);//jquery通过id属性并修改value属性为name
            $("#shopesTxt").val(des);//jquery通过id属性并修改value属性为des
            $("#shopesPrice").val(price);//jquery通过id属性并修改value属性为price
//            document.getElementById("shopesTxt").value == des;
//
//            document.getElementById("shopesPrice").value == price;

//            document.getElementById("shop_status2").value == shop_status;

            $('#myModal2').modal('show');
        }

        function remond(page,size,sort,operation,key,value) {
            $.ajax({
                url: "http://101.200.56.75/messages/messagespage?page="+page+"&size="+size+"&sort="+sort+"&operation="+operation+"&key="+key+"&value="+value,
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
                        c2.innerHTML = p[i].content;
                        var c3 = row.insertCell(2);
                        c3.innerHTML = p[i].leave_time;
                        var c4 = row.insertCell(3);
                        c4.innerHTML = p[i].userName;
                        var c5 = row.insertCell(4);
                        c5.innerHTML = p[i].leave_status;
                        var c6 = row.insertCell(5);
                        c6.innerHTML = p[i]._shop.shopname;
                        var c7 = row.insertCell(6);
                        c7.innerHTML = "<a href='#' title='修改商品'"
                            + "onclick=\"change('" + p[i].shopname + "','" + p[i].shopid + "','" + p[i].shop_status + "','" + p[i].des + "','" + p[i].price + "')\">"
                            + "<span class='glyphicon glyphicon-cog'></span>"
                            + "</a>"
                            + "<a href='#' title='查看商品'"
                            + "onclick=\"detail('" + p[i].content + "','" + p[i].messageid + "','" + p[i].leave_time + "','" + p[i].leave_status + "','" + p[i].userName + "','" + p[i]._shop.shopname + "')\">"
                            + "<span class='glyphicon glyphicon-list-alt'></span> &nbsp"
                            + "</a>"
                            + "<a href='#' title='评论检查'"
                            + "onclick=\"status('"  + p[i].messageid + "','" + p[i].leave_status  + "','" + ((page - 1) * default_size + i + 1)  + "')\">"
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
        //            "shopname": "a",
        //            "des": "b",
        //            "userName": "c",
        //            "userphne": "13723697188",
        //            "category": "c",
        //            "picture": "u",
        //            "price": "24",
        //            "shop_status": "1"
        //        }
        function check() {
            var name, shopid, shop_status, des, price;
            if (document.getElementById("shopesTxt").value == "") {
                alert("请输入shuoming！");
                document.forms.amendShopesForm.shopesTxt.focus();
                return false;
            }
            if (document.getElementById("shopesPrice").value == "") {
                alert("请输入菜品jiage！");
                document.forms.amendShopesForm.shopesPrice.focus();
                return false;
            }
            des = document.getElementById("shopesTxt").value;
            price = document.getElementById("shopesPrice").value;
            shopid = document.getElementById("shopid2").innerHTML;
//            shop_status =
            alert(shopid + "--" + des + "--" + price);
            var jsonput={
                "shopname": "a",
                "des": des,
                "userName": "hdddss",
                "userphne": "13723697188",
                "category": "c是是是",
                "picture": "u.jpg",
                "price": price,
                "shop_status": "1"
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
                    alert(res.payload.shopid + "-----success")
//                    remond();
                    alert("回---调---调---试")
                }
            })
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
            <span class="glyphicon glyphicon-home navFont"><strong class=“systemTitle”> 广商淘-评论模块</strong></span>
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
                    <li><a href="#" onclick=" return remond('0',default_size,default_sort) ">所有评论</a></li>
                    <li><a href="#" onclick=" return remond('0',default_size,default_sort,'eq','Leave_status',1) ">通过的评论</a></li>
                    <li><a href="#" onclick=" return remond('0',default_size,default_sort,'eq','Leave_status',0) ">未通过评论</a></li>
                </ul>
            </nav>
        </div>
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover table-bordered" id="ShopTable">

                    <tr>
                        <th class="tableCenter">评论序号</th>
                        <th class="tableCenter">评论的内容</th>
                        <th class="tableCenter">评论的时间</th>
                        <th class="tableCenter">评论的用户</th>
                        <th class="tableCenter">是否通过</th>
                        <th class="tableCenter">所评论的商品</th>
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
                            商品id： <span id="messageid"></span>
                        </h2>
                        <h3 style="text-align: center;">
                            <span style="color: red;font-weight: bold;" id="recommend"></span>
                        </h3>
                        <hr/>
                        <p>
                        <h3>
                            评论时间：
                        </h3>
                        <p><span id="leave_time"></span></p>
                        <h3>
                            评论状态：<span id="leave_status"></span>
                        </h3>
                        <h3>评论内容： <span id="content"></span></h3>
                        <h3>
                            评论用户： <span id="userName"> </span>
                        </h3>
                        <h3>
                            评论商品： <span id="shopname"> </span>
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
                                <label for="shopesDiscript"
                                       class="col-sm-2 control-label">简&nbsp;&nbsp;&nbsp;&nbsp;介:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="shopesDiscript"
                                           value="  "
                                           name="shopesDiscript" placeholder="请输入少于100字的简介">
                                </div>
                            </div>


                            <div class="form-group">
                                <label for="shopesTxt"
                                       class="col-sm-2 control-label">说&nbsp;&nbsp;&nbsp;&nbsp;明:</label>
                                <div class="col-sm-10">
                                <textarea rows="8" class="form-control" id="shopesTxt"
                                          name="shopesTxt"></textarea>
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

