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
    <script language="javascript" type="text/javascript">
        function setUrl(url){
            document.getElementById("manFrame").src = url;
            $("#ifrTest").load(function () {
                var h = document.body.clientHeight;
                var w = document.body.clientWidth;
                document.getElementById("ifrTest").height = h + "px";
                document.getElementById("ifrTest").width = w + "px";

            });
        }
    </script>

    <title>Title</title>
<%--</head>--%>
<%--<frameset rows="59,*" cols="*" frameborder="no" border="0" framespacing="0">--%>

    <%--<frame src="index.jsp" name="manFrame" frameborder="no" id="manFrame" title="manFrame" />--%>
<%--</frameset>--%>

<body>
<input type="button" onclick="setUrl('index.jsp')" value="baidu">
<input type="button" onclick="setUrl('www.sohu.com')" value="sohu"
<iframe src="" id="ifrTest"  ></iframe>

</body>

<%--<body style="overflow-y:hidden;overflow-x:hidden">--%>
<%--<input type="button" onclick="setUrl('index.jsp')" value="baidu">--%>
<%--<input type="button" onclick="setUrl('www.sohu.com')" value="sohu">--%>
<%--&lt;%&ndash;<iframe src="" id="ifrTest"  ></iframe>&ndash;%&gt;--%>
<%--</body>--%>
</html>
