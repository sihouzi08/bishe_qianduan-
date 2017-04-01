<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/10/27
  Time: 20:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<script type="text/javascript">
    if (window.top.location.href != location.href) {
        window.top.location.href = location.href;
    }
    //显示帮助详情调用模态框




    function startTime()
    {
        var today=new Date()
        var h=today.getHours()
        var m=today.getMinutes()
        var s=today.getSeconds()
// add a zero in front of numbers<10
        m=checkTime(m)
        s=checkTime(s)
        document.getElementById('timeid').innerHTML="<span class='glyphicon glyphicon-time'></span>&nbsp;"+ h+":"+m+":"+s
        t=setTimeout('startTime()',500)
        $('#myModal').modal('show');
    }

    function checkTime(i) {
        if (i < 10) {
            i = "0" + i
        }
        return i
    }

</script>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" type="text/css" href="css/dashboard.css">
    <link rel="stylesheet" href="css/common.css" type="text/css"/>
    <script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <title>NowUser</title>

</head>
<body onload="startTime()">

<%--查看帮助详情的模态框--%>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        onclick="javascrtpt:window.location.href='/indexmain'">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">登录信息</h4>
            </div>
            <div class="modal-body">
                <div class="panel panel-primary" style="margin-top: 10px">
                    <div class="panel-heading">
                        <h3 class="panel-title">登录详情</h3>
                    </div>
                    <div class="panel-body">


                        <p>
                        <h2 style="text-align: center;">
                            Time： <span id="timeid"></span>
                        </h2>
                        <h3 style="text-align: center;">
                            <span style="color: red;font-weight: bold;" id="recommend"></span>
                        </h3>
                        <hr/>
                        <p>
                        <h3>
                            我的信息：<h4><span>您好，<shiro:principal/></span></h4>
                        </h3>
                        <h3>
                            登录状态：<h4><span>已经登录 安全</span></h4>
                        </h3>
                        <h3>用户权限： <h4><span>查看</span></h4><shiro:hasRole name="admin"><h4><span>删除修改增加下载</span></h4></shiro:hasRole></h3>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary addUserAndDishes" data-dismiss="modal" onclick="javascrtpt:window.location.href='/indexmain'">关闭</button>
            </div>
        </div>
    </div>
</div>

</body>

</html>