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
    <title>用户管理</title>
    <script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
    <!-- Bootstrap -->
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">

    <script src="js/ajax.js"></script>
    <!-- <link rel="stylesheet" type="text/css" href="css/index.css"> -->
    <link rel="stylesheet" type="text/css" href="css/rightmain.css">
    <script type="text/javascript">
        var p;
        var default_size=5;
        var default_sort="userid,asc";
        var controller=0;
        function ch3(){
            var s1 = document.getElementsByName("s1")[0];
            if (s1.value == "0") {
                alert("请重新选择记录数！");
                return false;
            }
            alert('you choice: 每页' + s1.value +"条记录");

            default_size=s1.value;

            if (controller == 0) {
                remond('0', default_size, default_sort);
            } else {
                remond('0', default_size, default_sort, 'like', 'shopname', value);
            }
        }

        function ch0(){
            var s0 = document.getElementsByName("s0")[0];
            if (s0.value == "0") {
                alert("请重新选择排序方式！");
                return false;
            }
            alert('you choice: 排序方式为-->' + s0.value);

            default_sort=s0.value+",asc";

            if (controller == 0) {
                remond('0', default_size, default_sort);
            } else {
                remond('0', default_size, default_sort, 'like', 'shopname', value);
            }
        }

        window.onload =function() {
            remond(0,default_size,default_sort)
//            alert("users()")
            startTime();
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

        function addElementLiFirstAndUpone(obj,operation,key,value,page) {
            var ul = document.getElementById(obj);

            var li0 = document.createElement("li");

            li0.innerHTML = "<a href='#'"
                + "onclick=\"remond('0',default_size,default_sort,'" + operation + "','" + key + "','" + value + "')\""
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
                + "onclick=\"remond('" + _maxpage + "','" + default_size + "','" + default_sort + "','" + operation + "','" + key + "','" + value + "')\""
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
        function detail(userName, userid, password, email, school) {

            document.getElementById("userName").innerHTML = userName;
            document.getElementById("password").innerHTML = password;
            document.getElementById("email").innerHTML = email;
            document.getElementById("userid").innerHTML = userid;

            $('#myModal').modal('show');
        }
        //显示商品修改调用模态框," + p[i].userName + "','" + p[i].userid + "','" + p[i].password + "','" + p[i].email + "','" + p[i].school'" + p[i].userstatus + "','" + p[i].court + "','" + p[i].professional + "','" + p[i].phone + "')\">"
        function change(userName, userid, password, email,school,userstatus,court,professional,phone) {

            document.getElementById("userid2").innerHTML = userid;
//
            $("#userName2").val(userName);//jquery通过id属性并修改value属性为name
//
            $("#password2").val(password);//jquery通过id属性并修改value属性为price
            $("#email2").val(email);
            $("#school2").val(school);
            $("#court2").val(court);
            $("#professional2").val(professional);
            $("#userstatus").val(userstatus);
            $("#phone2").val(phone);
            $('#myModal2').modal('show');
        }

        function check() {
            msg = '是否将' + name + '下架？';
            var isphone = /^(13[0-9]|14(5|7)|15(0|1|2|3|5|6|7|8|9)|18[0-9])\d{8}$/;
            var isuserstatus = /^[0-1]$/;
            var userName, userid, password, userstatus, email,court,school,professional,phone;
            if (confirm(msg)) {
                if (document.getElementById("userName2").value == "") {
                    alert("请输入userName2！");
                    document.forms.amendShopesForm.userName2.focus();
                    return false;
                }
                if (document.getElementById("password2").value == "") {
                    alert("请输入菜品password2！");
                    document.forms.amendShopesForm.password2.focus();
                    return false;
                }
                if (document.getElementById("email2").value == "") {
                    alert("请输入email2！");
                    document.forms.amendShopesForm.email2.focus();
                    return false;
                }
                if (document.getElementById("school2").value == "") {
                    alert("请输入school2！");
                    document.forms.amendShopesForm.school2.focus();
                    return false;
                }
                if (document.getElementById("court2").value == "") {
                    alert("请输入court2！");
                    document.forms.amendShopesForm.court2.focus();
                    return false;
                }
                if (document.getElementById("professional2").value == "") {
                    alert("请输入professional2！");
                    document.forms.amendShopesForm.professional2.focus();
                    return false;
                }
                if (document.getElementById("userstatus").value == "") {
                    alert("请输入userstatus！");
                    document.forms.amendShopesForm.userstatus.focus();
                    return false;
                }else if (isuserstatus.test(document.getElementById("userstatus").value)) {
                    userstatus = document.getElementById("userstatus").value;
                }else {
                    alert("你的shop_status2选择有误，请重新选择");
                    document.forms.amendShopesForm.userstatus.focus();
                    return false;
                }
                if(isphone.test(document.getElementById("phone2").value)){
                    phone = document.getElementById("phone2").value;
                }else if (document.getElementById("phone2").value == "") {
                    alert("请输入userphne！");
                    document.forms.amendShopesForm.phone2.focus();
                    return false;
                } else {
                    document.forms.amendShopesForm.phone2.focus();
                    alert('你所输入的不是手机号码');
                    return false;
                }
                userName = document.getElementById("userName2").value;
                password = document.getElementById("password2").value;
                userid = document.getElementById("userid2").innerHTML;
                email = document.getElementById("email2").value;
                court = document.getElementById("court2").value;
                school = document.getElementById("school2").value;
                professional = document.getElementById("professional2").value;

//            shop_status =
                alert(userid + "--" + userName + "--" + school);
                var jsonput={
                    "userid": userid,
                    "userName": userName,
                    "password": password,
                    "userstatus": userstatus,
                    "email": email,
                    "court": court,
                    "school": school,
                    "professional": professional,
                    "phone": phone
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
                        alert("回---调---调---试");
                        $('#myModal2').modal('toggle')
                        remond('0',default_size,default_sort);
                    }
                })
            }
            alert("check()--调---试")
        }
        function remond(page,size,sort,operation,key,value) {
            $.ajax({
                url: "http://101.200.56.75/users/userspage?page="+page+"&size="+size+"&sort="+sort+"&operation="+operation+"&key="+key+"&value="+value,
                type: "GET",
                dataType: "json",
                success: function (res) {
                    p = res.payload.content;
                    maxpage = res.payload.totalPages;
                    $("#pager").html("");
                    $("#UserTable  tr:not(:first)").html("");
                    page++;
                    addElementLiFirstAndUpone("pager",operation,key,value,page);
                    var ShopTable = document.getElementById("UserTable");
                    for (var i = 0; i < p.length; i++) {
                        var row = UserTable.insertRow(UserTable.rows.length);
                        var c1 = row.insertCell(0);
                        c1.innerHTML = (page - 1) * 5 + i + 1;
                        var c11 = row.insertCell(1);
                        c11.innerHTML = p[i].userid;
                        var c2 = row.insertCell(2);
                        c2.innerHTML = p[i].userName;
                        var c3 = row.insertCell(3);
                        c3.innerHTML = p[i].password;
                        var c4 = row.insertCell(4);
                        c4.innerHTML = p[i].email;
                        var c5 = row.insertCell(5);
                        c5.innerHTML = p[i].school;
                        var c6 = row.insertCell(6);
                        c6.innerHTML = p[i].court;
                        var c7 = row.insertCell(7);
                        c7.innerHTML = p[i].professional;
                        var c8 = row.insertCell(8);
                        c8.innerHTML = p[i].phone;

                        var userstatus = p[i].userstatus == "0" ? "黑名单" : "正常";
                        var c9 = row.insertCell(9);
                        c9.innerHTML = userstatus;

                        var c10 = row.insertCell(10);
                        c10.innerHTML = "<shiro:hasPermission name="add">"+"<a href='#' title='用户修改'"
                            + "onclick=\"change('" + p[i].userName + "','" + p[i].userid + "','" + p[i].password + "','" + p[i].email + "','" + p[i].school + "','" + p[i].userstatus + "','" + p[i].court + "','" + p[i].professional + "','" + p[i].phone + "')\">"
                            + "<span class='glyphicon glyphicon-cog'></span>"
                            + "</a>"+"</shiro:hasPermission>"
                            + "<a href='#' title='用户详情'"
                            + "onclick=\"detail('" + p[i].userName + "','" + p[i].userid + "','" + p[i].password + "','" + p[i].email + "','" + p[i].school + "')\">"
                            + "<span class='glyphicon glyphicon-list-alt'></span> &nbsp"
                            + "</a>"
                            + "<shiro:hasPermission name="del">"+"<a href='#' title='用户拉黑'"
                            + "onclick=\"dodelete('"  + p[i].userid + "','" + p[i].userName  + "','" + p[i].userstatus  + "')\">"
                            + "<span class='glyphicon glyphicon-remove'></span> &nbsp"
                            + "</a>"+"</shiro:hasPermission>";

                    }

                    for (var i = 1; i < maxpage + 1; i++) {
                        addElementLi("pager", i,operation,key,value);
                    }

//                    page--;
                    addElementLiNextAndEnd("pager",operation,key,value,page);

//                    addElementLiEnd("pager",operation,key,value);


                }

            });

        }

        function dodelete(id, name,userstatus) {
            msg = '是否将' + name + '下架？';
            if (confirm(msg)) {
                if (userstatus == 0) {
                    userstatus = 1;
                } else {
                    userstatus = 0;
                }
                $.ajax({
                    url: "http://101.200.56.75/users/amenduserstatus?id=" + id + "&userstatus=" + userstatus,
                    type: "PUT",
                    success: function (res) {
                        alert(res);
                    }
                })
                alert(id + "-——-" + userstatus);
            }
        }



        function download(){
            msg = '是否把该页user表单导出excel';
            if(confirm(msg)){
                var url="http://101.200.56.75/users/file";
                window.open(url);
            }
        }


        function OnInput (event) {
//            alert ("The new content: " + event.target.value);
            controller=1;
            value=event.target.value;
            remond('0',default_size,default_sort,'like','userName',value);
        }
        // Internet Explorer
        function OnPropChanged (event) {
            if (event.propertyName.toLowerCase () == "value") {
                alert ("The new content: " + event.srcElement.value);
                controller=1;
                value=event.target.value;
                remond('0',default_size,default_sort,'like','userName',value);
            }
        }





    </script>

</head>
<body >
<div class="iframecontent">
    <div class="pos">
        <i class="icoh"></i>
        <span>用户列表查看</span>



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

            <select name="s0" onchange="ch0()">
                <option value="0" selected="selected">请选择排序</option>
                <option value="userid">id</option>
                <option value="userName">userName</option>
                <%--<option value="">10</option>--%>
            </select>


            <input size="12" id="ShopBySearch" type="text" value="" placeholder="请输入查找"  oninput="OnInput (event)" onpropertychange="OnPropChanged (event)">



        </div>
        <!-- operate标题结束 -->
        <div class="list">
            <div class="tablewrap">
                <table class="table" width="100%" id="UserTable">

                    <tr>
                        <th >用户序号</th>
                        <th >用户id</th>
                        <th >用户名称</th>
                        <th >用户密码</th>
                        <th >用户邮箱</th>
                        <th >用户学校</th>
                        <th >用户系别</th>
                        <th >用户专业</th>
                        <th >用户电话</th>
                        <th >用户状态</th>
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
                            用户id： <span id="userid"></span>
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
                            用户名称：
                        </h3>
                        <p><span id="userName"></span></p>
                        <p>
                        <h3>用户邮箱：</h3>
                        <p>
                            <span id="email"></span>
                        </p>
                        <h3>
                            用户密码：<span id="password"> </span> (元)
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
                            商品id： <span id="userid2"></span>
                        </h2>

                        <form class="form-horizontal" name="amendShopesForm" id="amendShopesForm" role="form"
                              style="margin-top: 20px"
                              method="get">

                            <div class="form-group">
                                <label for="userName2"
                                       class="col-sm-2 control-label">用&nbsp;&nbsp;户&nbsp;&nbsp;名:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="userName2"
                                           value="  "
                                           size="20" name="userName2" placeholder="请输入商品名称">
                                </div>
                                <div style="color: red;float: right;" id="nameerror"></div>
                            </div>

                            <div class="form-group">
                                <label for="password2"
                                       class="col-sm-2 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;码:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="password2"
                                           value="  "
                                           name="password2" placeholder="请输入密码">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="email2"
                                       class="col-sm-2 control-label">邮&nbsp;&nbsp;&nbsp;&nbsp;箱:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="email2"
                                           value="  "
                                           name="email2" placeholder="请输入邮箱">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="school2"
                                       class="col-sm-2 control-label">学&nbsp;&nbsp;&nbsp;&nbsp;校:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="school2"
                                           value="  "
                                           name="school2" placeholder="请输入学校">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="court2"
                                       class="col-sm-2 control-label">系&nbsp;&nbsp;&nbsp;&nbsp;别:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="court2"
                                           value="  "
                                           name="court2" placeholder="请输入所属系">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="professional2"
                                       class="col-sm-2 control-label">专&nbsp;&nbsp;&nbsp;&nbsp;业:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="professional2"
                                           value="  "
                                           name="professional2" placeholder="请输入专业">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="phone2"
                                       class="col-sm-2 control-label">电&nbsp;&nbsp;&nbsp;&nbsp;话:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="phone2" name="phone2"
                                           placeholder="请输入userphne" value=""
                                    >
                                </div>
                                <div style="color: red;float: right;"></div>
                            </div>

                            <div class="form-group">
                                <label for="userstatus"
                                       class="col-sm-2 control-label">状&nbsp;&nbsp;&nbsp;&nbsp;态:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="userstatus" name="userstatus"
                                           placeholder="请从下面选择shop_status2" value=""
                                    >
                                    <select name="s2" onchange="ch2()">
                                        <option value="" selected="selected">请选择用户状态</option>
                                        <option value=0>0代表黑用户</option>
                                        <option value=1>1正常用户</option>
                                    </select>

                                    <script type="text/javascript">
                                        function ch2(){
                                            var s2 = document.getElementsByName("s2")[0];
                                            $("#userstatus").val(s2.value);
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
