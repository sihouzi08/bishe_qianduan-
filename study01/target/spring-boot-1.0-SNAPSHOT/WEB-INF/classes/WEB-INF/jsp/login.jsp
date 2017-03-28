<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/10/24
  Time: 19:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
    <script src="js/ajax.js"></script>
    <script type="text/javascript">

        var email;
        var code;
        //        email = document.getElementById("username").value;

        var reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
        //        var value = "xxx@qq.com";


        function Code() {
            email = document.getElementById("email").value;

            if (!reg.test(email)) {
                alert("请输入有效的邮箱地址！");
            } else {
                $.ajax({
                    url: "/testemail?email=" + email,
                    type: "GET",
                    success: function (res) {
                        code = res;
//                    alert(code);
                        if (code == "error") {
                            alert("该邮箱已经注册成为游客了");
                        } else {
                            var jsonpost = {
                                "username": email,
                                "password": code
                            };
                            $.ajax({
                                url: "/user/add",
                                type: "POST",
                                data: JSON.stringify(jsonpost),
                                dataType: 'json',
                                contentType: "application/json; charset=utf-8",
                                processData: false,
                                cache: false,
                                success: function (res) {
//                                alert(res);//success
                                    var p = res;
                                    if (p == "error") {
                                        alert("该邮箱已经注册成为游客了");
                                    } else {
                                        alert("该邮箱注册成为游客成功请输入验证码登录");
                                    }
                                    // alert(res);//error
                                }
                            })
                            alert("该邮箱注册成为游客成功请输入验证码登录");
                        }


                    }
                })
            }

        }
        function detail() {
            $('#myModal').modal('show');
        }
    </script>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <!-- <link rel="stylesheet" type="text/css" href="../public/css/base.css">  -->
    <link rel="stylesheet" type="text/css" href="css/b_login.css">
    <title>"广商淘"后台登录页面</title>
</head>
<body>
<div class="login">
    <div class="loginmain">
        <h2>登录管理系统---${message }</h2><!--style="color:black;"-->
        <form action="${pageContext.request.contextPath }/login"
              method="post" class="form-horizontal"/>
        <%--<form action="${pageContext.request.contextPath }/login" method="post" class="form-horizontal">--%>
        <!-- 让表单在一行中显示form-horizontal -->
        <div class="form-group">
            <label for="username" class="col-lg-1 control-label">用户名:</label><!--style="color:black;"-->
            <div class="col-lg-4">
                <input type="text" name="username" id="username" class="form-control" placeholder="admin">
                <form:errors path="username" cssClass="error"/>
            </div>
        </div>
        <div class="form-group"></div>
        <div class="form-group"></div>

        <div class="form-group">
            <label for="password" class="col-lg-1 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;码:</label>
            <!--style="color:black;"-->
            <div class="col-lg-4">
                <input type="password" name="password" id="password" class="form-control" placeholder="admin">
                <form:errors path="password" cssClass="error"/>
            </div>
        </div>
        <div class="form-group"></div>
        <!-- <div class="form-group"></div> -->

        <div class="form-group">
            <div class="col-lg-11 col-lg-offset-1">
		                <span class="checkbox "><!--style="color:black;"-->
		                    <label><input type="checkbox" name="" class="checkbox-inline">记住我</label>
		                </span>
            </div>
        </div>

        <div class="form-group">
            <div class="col-lg-4 col-lg-offset-1">
                <input type="submit" name="button" value="登录" class="btn btn-danger btn-lg">
                <input type="button" onclick="detail()" name="zhuce" value="游客" class="btn btn-danger btn-lg">
                <span class="text"></span>
            </div>

        </div>

        </form>
    </div>
    <div class="rightpic">
        <div id="container">
            <!-- <img src="picture/1.jpg" alt="" width="500px" height="330px"> -->
        </div>
    </div>
</div>


<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">游客入口</h4>
            </div>
            <div class="modal-body">
                <div class="panel panel-primary" style="margin-top: 10px">
                    <div class="panel-heading">
                        <h3 class="panel-title">游客注册和登录</h3>
                    </div>

                    <div class="loginmain">
                        <h2>登录管理系统---${message }</h2>
                        <form action="${pageContext.request.contextPath }/login"
                              method="post" class="form-horizontal"/>
                        <%--<form action="${pageContext.request.contextPath }/login" method="post" class="form-horizontal">--%>
                        <!-- 让表单在一行中显示form-horizontal -->
                        <div class="form-group">
                            <label for="username" class="col-lg-2 control-label">用&nbsp;户&nbsp;名:&nbsp;</label><!--style="color:black;"-->
                            <div class="col-lg-6">
                                <input type="text" name="username" id="email" class="form-control" placeholder="admin">
                                <form:errors path="username" cssClass="error"/>
                            </div>
                        </div>
                        <div class="form-group"></div>
                        <div class="form-group"></div>

                        <div class="form-group">
                            <label for="password" class="col-lg-2 control-label">验&nbsp;证&nbsp;码:&nbsp;</label>
                            <!--style="color:black;"-->
                            <div class="col-lg-6">
                                <input type="password" name="password" id="code" class="form-control"
                                       placeholder="admin">
                                <form:errors path="password" cssClass="error"/>
                            </div>
                        </div>
                        <div style="color: red;float: right;">验证码就是默认游客登录密码</div>
                        <div class="form-group"></div>
                        <!-- <div class="form-group"></div> -->

                        <div class="form-group">
                            <div class="col-lg-4 col-lg-offset-1">
                                <input type="submit" name="button" value="登录" class="btn btn-danger btn-lg">
                                <input type="button" onclick="Code()" name="button" value="注册"
                                       class="btn btn-danger btn-lg">
                                <span class="text"></span>
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


<script src="js/delaunay.js"></script>
<script src="js/TweenMax.js"></script>
<script src="js/effect.js"></script>
<script type="text/javascript">
    if (window.top.location.href != location.href) {
        window.top.location.href = location.href;
    }
</script>

</body>
</html>