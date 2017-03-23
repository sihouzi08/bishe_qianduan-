<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/10/27
  Time: 20:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
    <title>上传文件test</title>
    <script type="text/javascript">
    $(document).ready(function(){

        function uploadFileOss(input, callback) {
            var form = $("<form></form>");
            form.append($(input));
            var formData = new FormData(form[0]);
            $.ajax({
                url : "ajax/aili/uploadFile",
                type : 'POST',
                data : formData,
                async : false,
                cache : false,
                contentType : false,
                processData : false,
                success : function(returndata) {
                    if (callback) {
                        callback(returndata);
                    }
                },
                error : function(returndata) {
                    alert("上传图片出错");
                }
            });

        }

        $("#upload").click(function () {
            uploadFileOss();
        });
    });
    </script>
</head>
<body>
<input type="file" id="file_upload"/>
<input type="button" value="上传图片" id="upload"/>
</body>

</html>