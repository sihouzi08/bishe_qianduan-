<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/10/27
  Time: 17:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
    <script src="js/ajax.js"></script>
    <script language="javascript" type="text/javascript">
        function download(){

               var url="http://101.200.56.75/shop/file";
                window.open(url);

        }
    </script>

    <title>Title</title>


<body>
<input type="button" value="导出数据" onclick="download()"/>

</body>


</html>
