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
		<h2 >登录管理系统---${message }</h2><!--style="color:black;"-->
		<form action="${pageContext.request.contextPath }/login"
				    method="post" class="form-horizontal"/>
			<%--<form action="${pageContext.request.contextPath }/login" method="post" class="form-horizontal">--%>
		           <!-- 让表单在一行中显示form-horizontal -->
		          <div class="form-group">
		              <label for="username" class="col-lg-1 control-label">用户名:</label><!--style="color:black;"-->
		              <div class="col-lg-4">
		                <input type="text" name="username" id="username" class="form-control" placeholder="admin" >
						  <form:errors path="username" cssClass="error" />
		              </div>
		          </div>
				  <div class="form-group"></div>
				  <div class="form-group"></div>

		          <div class="form-group">
		              <label for="password" class="col-lg-1 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;码:</label><!--style="color:black;"-->
		              <div class="col-lg-4">
		                <input type="password" name="password" id="password" class="form-control" placeholder="admin">
						  <form:errors path="password" cssClass="error" />
		              </div>              
		          </div>
                   <div class="form-group"></div>
                   <!-- <div class="form-group"></div> -->

		          <div class="form-group">
		            <div class="col-lg-11 col-lg-offset-1">              
		                <span class="checkbox " ><!--style="color:black;"-->
		                    <label><input type="checkbox"  name="" class="checkbox-inline">记住我</label>
		                </span>           
		            </div>
		          </div>

		          <div class="form-group">
		            <div class="col-lg-4 col-lg-offset-1">
		                <input type="submit" name="button" value="登录" class="btn btn-danger btn-lg">
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

<script src="js/delaunay.js"></script>
<script src="js/TweenMax.js"></script>
<script src="js/effect.js"></script>
<script type="text/javascript">
    if(window.top.location.href!=location.href)
    {
        window.top.location.href=location.href;
    }
</script>

</body>
</html>