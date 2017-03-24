<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/10/24
  Time: 19:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <link rel="stylesheet" href="css/common.css" type="text/css" />
    <title>管理导航区域</title>
</head>
<script  type="text/javascript">
    var preClassName = "man_nav_1";
    function list_sub_nav(Id,sortname,url){
        if(preClassName != ""){
            getObject(preClassName).className="bg_image";
        }
        if(getObject(Id).className == "bg_image"){
            getObject(Id).className="bg_image_onclick";
            preClassName = Id;
            showInnerText(Id,url);
            //   document.getElementById("manFrame").src = url;

            // window.top.frames['leftFrame'].outlookbar.getbytitle(sortname);
            //   window.top.frames['leftFrame'].outlookbar.getdefaultnav(sortname);
        }
    }

    function showInnerText(Id,url){
        var switchId = parseInt(Id.substring(8));
        var showText = "对不起没有信息！";
        var a=url;
        switch(switchId){
            case 1:
                showText =  "欢迎使用“广商淘”后台管理系统!";
                document.getElementById("manFrame").src = url;
                break;
            case 2:
                showText =  "Show The Shop!";
                document.getElementById("manFrame").src = url;
                break;
            case 3:
                showText =  "Show The User";
                document.getElementById("manFrame").src = url;
                break;
            case 4:
                showText =  "Show The Order";
                document.getElementById("manFrame").src = url;
                break;
            case 5:
                showText =  "Show The Messages!";
                document.getElementById("manFrame").src = url;
                break;
        }
        getObject('show_text').innerHTML = showText;
    }
    //获取对象属性兼容方法
    function getObject(objectId) {
        if(document.getElementById && document.getElementById(objectId)) {
            // W3C DOM
            return document.getElementById(objectId);
        } else if (document.all && document.all(objectId)) {
            // MSIE 4 DOM
            return document.all(objectId);
        } else if (document.layers && document.layers[objectId]) {
            // NN 4 DOM.. note: this won't find nested layers
            return document.layers[objectId];
        } else {
            return false;
        }
    }
</script>




<body style="height: 100%">
<div id="nav">
    <ul><li id="man_nav_1" onclick="list_sub_nav(id,'管理首页','/dd1')"  class="bg_image_onclick">管理首页</li><li id="man_nav_2" onclick="list_sub_nav(id,'商品查看','/shopmain')"  class="bg_image">商品查看</li><li id="man_nav_3" onclick="list_sub_nav(id,'账户管理','/usermain')"  class="bg_image">账户管理</li><li id="man_nav_4"  onclick="list_sub_nav(id,'订单管理','/ordermain')"  class="bg_image">订单管理</li><li id="man_nav_5"  onclick="list_sub_nav(id,'评论管理','/messagesmain')"  class="bg_image">评论管理</li></ul>


</div>
<div id="sub_info">&nbsp;&nbsp;<img src="images/hi.gif" />&nbsp;<span id="show_text">欢迎使用“广商淘”后台管理系统!</span></div>
<iframe  src="/dd5" name="manFrame" class="bg_image" frameborder="no" id="manFrame" title="manFrame"  style="width: 100%;height: 80%" onload="this.height=this.contentWindow.document.documentElement.scrollHeight" />


</body>
</html>
