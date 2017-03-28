<%--
  Created by IntelliJ IDEA.
  User: Foreveross
  Date: 2017/3/2
  Time: 18:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
    <script src="js/ajax.js"></script>
    <script type="text/javascript">

        var email;
        var code;
        //        email = document.getElementById("username").value;
        function Code() {
            email = document.getElementById("username").value;
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
                                }else{
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

    </script>
    <title>Title</title>
</head>
<body>
<form action="${pageContext.request.contextPath }/login"
      method="post" class="form-horizontal"/>
<%--<form action="${pageContext.request.contextPath }/login" method="post" class="form-horizontal">--%>
<!-- 让表单在一行中显示form-horizontal -->
<div class="form-group">
    <label for="username" class="col-lg-1 control-label">邮箱名:</label><!--style="color:black;"-->
    <div class="col-lg-4">
        <input type="text" name="username" id="username" class="form-control" placeholder="admin">
        <form:errors path="username" cssClass="error" />
    </div>
</div>
<div class="form-group"></div>
<div class="form-group"></div>

<div class="form-group">
    <label for="password" class="col-lg-1 control-label">验证&nbsp;码&nbsp;就&nbsp;是&nbsp;密码:</label>
    <!--style="color:black;"-->
    <div class="col-lg-4">
        <input type="password" name="password" id="password" class="form-control" placeholder="admin">
        <form:errors path="password" cssClass="error" />
    </div>
</div>
<div class="form-group"></div>
<!-- <div class="form-group"></div> -->


<div class="form-group">
    <div class="col-lg-4 col-lg-offset-1">

        <input type="submit" name="button" value="登录" class="btn btn-danger btn-lg">
        <input type="button" onclick="Code()" name="button" value="zhuce" class="btn btn-danger btn-lg">
        <span class="text"></span>
    </div>

</div>

</form>
</body>
</html>
