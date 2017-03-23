<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/10/24
  Time: 19:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>无标题文档</title>
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/chili-1.7.pack.js"></script>
    <script type="text/javascript" src="js/jquery.easing.js"></script>
    <script type="text/javascript" src="js/jquery.dimensions.js"></script>
    <script type="text/javascript" src="js/jquery.accordion.js"></script>
    <link rel="stylesheet" href="css/common.css" type="text/css" />
    <script language="javascript">
        jQuery().ready(function(){
            jQuery('#navigation').accordion({
                header: '.head',
                navigation1: true,
                event: 'click',
                fillSpace: true,
                animated: 'bounceslide'
            });
        });
        function initinav(sortname)
        {
            outlookbar.getdefaultnav(sortname);
            outlookbar.getbytitle(sortname);
//window.top.frames['manFrame'].location = "manFrame.html"
        }
    </script>
    <style type="text/css">
        <!--
        body {
            margin:0px;
            padding:0px;
            font-size: 12px;
        }
        #navigation {
            margin:0px;
            padding:0px;
            width:147px;
        }
        #navigation a.head {
            cursor:pointer;
            display:block;
            font-weight:bold;
            margin:0px;
            padding:5px 0 5px;
            text-align:center;
            font-size:12px;
            text-decoration:none;
        }
        #navigation ul {
            border-width:0px;
            margin:0px;
            padding:0px;
            text-indent:0px;
        }
        #navigation li {
            list-style:none; display:inline;
        }
        #navigation li li a {
            display:block;
            font-size:12px;
            text-decoration: none;
            text-align:center;
            padding:3px;
        }
        #navigation li li a:hover {

            border:solid 1px #adb9c2;
        }
        -->
    </style>

</head>
<body onload="initinav('管理首页')">
<div id="left_content">
    <div id="user_info">欢迎您，<strong>pobear</strong><br />[<a href="#">系统管理员</a>，<a href="#">退出</a>]</div>
    <div id="main_nav">

    </div>
</div>
<div  style="height:80%;">
    <ul id="navigation">
        <li> <a class="head">用户管理</a>
            <ul>
                <li><a href="huiyuantest.jsp" target="rightFrame">会员</a></li>
                <li><a href="putongyonghutest.jsp" target="rightFrame">普通用户</a></li>
            </ul>
        </li>
        <li> <a class="head">订单管理</a>
            <ul>
                <li><a href="dingdancheck.jsp" target="rightFrame">成功订单查询</a></li>
                <li><a href="yudingdan.jsp" target="rightFrame">待处理订单</a></li>
            </ul>
        </li>
        <li> <a class="head">分类管理</a>
            <ul>
                <li><a href="ddd.jsp" target="rightFrame">添加分类</a></li>
                <li><a href="ddd.jsp" target="rightFrame">查看/删除分类</a></li>
            </ul>
        </li>
        <li> <a class="head">商品管理</a>
            <ul>
                <li><a href="ddd.jsp" target="rightFrame">添加分类</a></li>
                <li><a href="ddd.jsp" target="rightFrame">查看/删除分类</a></li>
            </ul>
        </li>
        <li> <a class="head">留言评论管理</a>
            <ul>
                <li><a href="checkliuyan.jsp" target="rightFrame">查看/删除留言</a></li>
                <li><a href="lookliuyan.jsp" target="rightFrame">查看/删除评论</a></li>
            </ul>
        </li>
        <li> <a class="head">大数据test</a>
            <ul>
                <li><a href="lookliuyan.jsp" target="rightFrame">各种数据统计</a></li>
                <li><a href="checkliuyan.jsp" target="rightFrame">动态表单test</a></li>
            </ul>
        </li>
        <li> <a class="head">友情链接管理</a>
            <ul>
                <li><a href="ddd.jsp" target="rightFrame">添加友情链接</a></li>
                <li><a href="ddd.jsp" target="rightFrame">查看/修改友情链接</a></li>
            </ul>
        </li>
        <li> <a class="head">版本信息</a>
            <ul>
                <li><a href="ddd.jsp" target="_blank">by Jessica(865171.cn)</a></li>
            </ul>
        </li>
    </ul>
</div>
</body>
</html>

