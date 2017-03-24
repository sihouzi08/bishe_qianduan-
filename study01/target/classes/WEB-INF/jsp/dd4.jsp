<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/10/24
  Time: 19:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <link rel="stylesheet" href="css/common.css" type="text/css" />
    <title>管理区域</title>
    <script src="js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <script type="text/javascript">


        window.onload =function() {
            $.ajax({
                url: "http://101.200.56.75/shop/newpage?page=2&size=5&sort=shopid,asc",
                type: "GET",
                dataType: "json",
                success: function (res) {
                    p = res.payload.content;



//                                      for(var i=0,l=p.length;i<l;i++){
//                        for (var key in p[i]) {
//                            alert(key + ':' + p[i][key]);
//                        }
//                    }





                    alert("分页test()"+p[1].picture)
                }

            });
            alert("(跨域分页)")
        }


    </script>
</head>

<body>
<div id="man_zone">
    <table width="99%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
        <tr>
            <td width="18%" class="left_title_1"><span class="left-title">上传个人照片</span></td>
            <td width="82%">&nbsp;</td>
        </tr>
        <tr>
            <td class="left_title_2">个人简介</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="left_title_1">联系电话</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="left_title_2">死猴子</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="left_title_1">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="left_title_2">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="left_title_1">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="left_title_2">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="left_title_1">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td class="left_title_2">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</div>
</body>
</html>
