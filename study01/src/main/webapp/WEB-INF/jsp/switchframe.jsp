<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/10/24
  Time: 20:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <link rel="stylesheet" href="css/common.css" type="text/css" />
    <title>显示/隐藏左侧导航栏</title>
</head>
<script language="JavaScript">
    function Submit_onclick(){
        if(window.parent.myFrame.cols == "199,7,*") {
            top.myFrame.cols="0,7,*";
            document.getElementById("ImgArrow").src="images/switch_right.gif";
            document.getElementById("ImgArrow").alt="打开左侧导航栏";
        } else {
            top.myFrame.cols="199,7,*";
            document.getElementById("ImgArrow").src="images/switch_left.gif";
            document.getElementById("ImgArrow").alt="隐藏左侧导航栏";
        }
    }

    function MyLoad() {
        if(window.parent.location.href.indexOf("MainUrl")>0) {
            window.top.midFrame.document.getElementById("ImgArrow").src="images/switch_right.gif";
        }
    }
</script>
<body onload="MyLoad()">
<div id="switchpic"><a href="javascript:Submit_onclick()"><img src="images/switch_left.gif" alt="隐藏左侧导航栏" id="ImgArrow" /></a></div>
</body>
</html>

