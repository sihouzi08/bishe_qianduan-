<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>退出页面</title>
</head>
<body>
<%
    out.println("<script>");
    out.println("window.top.location.href='http://localhost:8088/login';");
//    out.println("window.top.location.href='http://101.200.56.75:8088/login';");
    out.println("</script>");
%>
</body>
</html>