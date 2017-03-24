<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/10/24
  Time: 19:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <link rel="stylesheet" href="css/common.css" type="text/css" />
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
    <script type="text/javascript">
        function startTime()
        {
            var today=new Date()
            var h=today.getHours()
            var m=today.getMinutes()
            var s=today.getSeconds()
// add a zero in front of numbers<10
            m=checkTime(m)
            s=checkTime(s)
            document.getElementById('txt').innerHTML="现在时间:<span class='glyphicon glyphicon-time'></span>&nbsp;"+ h+":"+m+":"+s
//            document.getElementById('timeid').innerHTML="<span class='glyphicon glyphicon-time'></span>&nbsp;"+ h+":"+m+":"+s
            t=setTimeout('startTime()',500)
        }

        function checkTime(i)
        {
            if (i<10)
            {i="0" + i}
            return i
        }
        function back(){
            window.history.back(-1);
        }




    </script>
    <title>通用后台管理系统</title>
</head>

<body onload="startTime()">
<div class="header_content">
    <div class="logo"><img src="images/fff.png" alt="广商淘-后台管理" /></div>
    <div class="right_nav">
        <div class="text_left"><ul class="nav_list"><li><span class='glyphicon glyphicon-hand-right'></span>&nbsp;"广商淘"后台管理系统</li></ul>
        </div>
        <div class="text_right">
            <ul class="nav_return">
                <li> [<a href="/time" id="txt"> </a>]</li>
                <li>[<a href="#" onclick="back()"><span class='glyphicon glyphicon-share-alt'></span>&nbsp;返回 </a> ][ <a href="/help" ><span class='glyphicon glyphicon-question-sign'></span>&nbsp;帮助</a>]
                </li>
                <li> [<a href="/indexmain"><span class='glyphicon glyphicon-home'></span>&nbsp;主页</a>]</li>
                <li> [<a href="/thisuser"><span class='glyphicon glyphicon-user'></span>&nbsp;用户</a>]&nbsp;&nbsp;</li>
            </ul>
        </div>
    </div>
</div>


<script type="text/javascript" src="js/bootstrap.min.js"></script>
</body>
</html>
