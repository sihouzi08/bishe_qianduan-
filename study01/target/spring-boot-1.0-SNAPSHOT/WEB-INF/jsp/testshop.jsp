<%--
  Created by IntelliJ IDEA.
  User: Foreveross
  Date: 2017/2/6
  Time: 17:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>商品管理</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
    <script src="js/ajax.js"></script>
    <!-- <link rel="stylesheet" type="text/css" href="css/index.css"> -->
    <link rel="stylesheet" type="text/css" href="css/rightmain.css">
    <script type="text/javascript">
        var p, maxpage;
        var h;
        var default_size=5;
        var default_sort="shopid,asc";

        function ch3(){
            var s1 = document.getElementsByName("s1")[0];
            if (s1.value == "0") {
                alert("请重新选择记录数！");
                return false;
            }
            alert('you choice: 每页' + s1.value +"条记录");

            default_size=s1.value;

            remond('0',default_size,default_sort);
        }

        function ch2(){
            var s2 = document.getElementsByName("s2")[0];
            if (s2.value == "0") {
                alert("请重新选择排序方式！");
                return false;
            }
            alert('you choice: 排序方式为-->' + s2.value);

            default_sort=s2.value+",asc";

            remond('0',default_size,default_sort);
        }

        window.onload = function () {
            remond('0',default_size,default_sort);
//            alert("kuayu()")
        };

        function addElementLiFirstAndUpone(obj, operation, key, value, page) {
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


        function addElementLiNextAndEnd(obj, operation, key, value, page) {
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

        function download(){
            msg = '是否把该页shop表单导出excel';
            if(confirm(msg)){
                var url="http://101.200.56.75/shop/file";
                window.open(url);
            }
        }

        function dodelete(shopid,shop_status,name){
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



        function remond(page, size, sort, operation, key, value) {
            $.ajax({
                url: "http://101.200.56.75/shop/newspage?page=" + page + "&size=" + size + "&sort=" + sort + "&operation=" + operation + "&key=" + key + "&value=" + value,
                type: "GET",
                dataType: "json",
                success: function (res) {
                    p = res.payload.content;
                    maxpage = res.payload.totalPages;
                    $("#pager").html("");
                    $("#ShopTable  tr:not(:first)").html("");
                    page++;
                    addElementLiFirstAndUpone("pager", operation, key, value, page);
                    var ShopTable = document.getElementById("ShopTable");
                    for (var i = 0; i < p.length; i++) {
                        var row = ShopTable.insertRow(ShopTable.rows.length);
                        var c1 = row.insertCell(0);
                        c1.innerHTML = (page - 1) * default_size + i + 1;
                        var c2 = row.insertCell(1);
                        c2.innerHTML = p[i].shopid;
                        var c3 = row.insertCell(2);
                        c3.innerHTML = p[i].shopname;
                        var c4 = row.insertCell(3);
                        c4.innerHTML = p[i].price;
                        var shop_status = p[i].shop_status == "0" ? "下架" : "上架";
                        var c5 = row.insertCell(4);
                        c5.innerHTML = shop_status;
                        var c6 = row.insertCell(5);
                        c6.innerHTML = p[i]._category.category
                        var c7 = row.insertCell(6);
                        c7.innerHTML = "<a href='#' title='修改商品'"
                            + "onclick=\"change('" + p[i].shopname + "','" + p[i].shopid + "','" + p[i].shop_status + "','" + p[i].price + "','" + p[i].des + "','" + p[i].userName + "','" + p[i].userphne + "','" + p[i].category_id + "','" + p[i].picture + "')\">"
                            + "<span class='glyphicon glyphicon-cog'></span>"
                            + "</a>"
                            + "<a href='#' title='商品详情'"
                            + "onclick=\"detail('" + p[i].shopname + "','" + p[i].shopid + "','" + p[i].shop_status + "','" + p[i].des + "','" + p[i].price + "')\">"
                            + "<span class='glyphicon glyphicon-list-alt'></span> &nbsp"
                            + "</a>"
                            + "<a href='#' title='商品删除'"
                            + "onclick=\"dodelete('" + p[i].shopid + "','" + p[i].shop_status + "','" + p[i].shopname + "')\">"
                            + "<span class='glyphicon glyphicon-remove'></span> &nbsp"
                            + "</a>";

                    }

                    for (var i = 1; i < maxpage + 1; i++) {
                        addElementLi("pager", i, operation, key, value);
                    }
                    addElementLiNextAndEnd("pager", operation, key, value, page);
                }
            });
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
            document.getElementById('txt').innerHTML="<span class='glyphicon glyphicon-time'></span>&nbsp;"+ h+":"+m+":"+s
            t=setTimeout('startTime()',500)
        }

        function checkTime(i)
        {
            if (i<10)
            {i="0" + i}
            return i
        }

        //显示商品详情调用模态框
        function detail(name, shopid, shop_status, des, price) {
            var shop_status = shop_status == "0" ? "下架" : "上架";
            document.getElementById("ShopName").innerHTML = name;
            document.getElementById("Des").innerHTML = des;
            document.getElementById("price").innerHTML = price;
            document.getElementById("shopid").innerHTML = shopid;

            document.getElementById("shop_status").innerHTML = shop_status;


            $('#myModal').modal('show');
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
<body onload="startTime()">
<div class="iframecontent">
    <div class="pos">
        <i class="icoh"></i>
        <span>商品列表查看</span>



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
            <input type="button" onclick="download()" name="" value="导出EEXCEL" class="btn  btn-success">
            <select name="s1" onchange="ch3()">
                <option value="0" selected="selected">请选择每页记录数</option>
                <option value=5>5</option>
                <option value=8>8</option>
                <option value=10>10</option>
            </select>

            <select name="s2" onchange="ch2()">
                <option value="0" selected="selected">请选择排序</option>
                <option value="shopid">id</option>
                <option value="price">价格</option>
                <%--<option value="">10</option>--%>
            </select>


        </div>
        <!-- operate标题结束 -->
        <div class="list">
            <div class="tablewrap">
                <table class="table" width="100%" id="ShopTable">

                    <tr>
                        <th>序号</th>
                        <th>编号id</th>
                        <th>名称</th>
                        <th>商品价格</th>
                        <th>显示上下架</th>
                        <th>所属类型</th>
                        <th>操作</th>
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
                            商品状态：
                        </h3>
                        <p><span id="shop_status"></span></p>

                        <h3>商品简介：</h3>
                        <p>
                            <span id="Des"></span>
                        </p>
                        <h3>
                            菜品价格： <span id="price"> </span> (元)
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

<script type="text/javascript" src="js/bootstrap.min.js"></script>
</body>
</html>
