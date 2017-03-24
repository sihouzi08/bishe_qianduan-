<%--
  Created by IntelliJ IDEA.
  User: Foreveross
  Date: 2017/2/9
  Time: 15:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" type="text/css" href="css/dashboard.css">
    <link rel="stylesheet" href="css/common.css" type="text/css"/>
    <script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <title>Title</title>
    <script type="text/javascript">
        if (window.top.location.href != location.href) {
            window.top.location.href = location.href;
        }
        function checkTime(i) {
            if (i < 10) {
                i = "0" + i
            }
            return i
        }
        function init() {
            var canvas = document.getElementById("canvas"),
                context = canvas.getContext("2d");
            var today=new Date()
            var h=today.getHours()
            var m=today.getMinutes()
            var s=today.getSeconds()
// add a zero in front of numbers<10
            m=checkTime(m)
            s=checkTime(s)
            document.getElementById('timeid').innerHTML="<span class='glyphicon glyphicon-time'></span>&nbsp;"+ h+":"+m+":"+s
            t=setTimeout('init()',500)
            setInterval(function () {
                draw(canvas, context)
            }, 1000);
            $('#myModal').modal('show');
        }
        function draw(canvas, context) {
            var x = canvas.width,
                y = canvas.height,
                r = Math.min(x / 2, y / 2);

            context.clearRect(0, 0, x, y); //清除绘画历史
            //绘画钟框
            context.fillStyle = "#f1f1f1";
            drawCircle(context, x, y, r);
            //绘画文字
            var tx = x / 2, ty = y / 2, tr = 0.8 * r;
            context.font = "bold 12px 微软雅黑";
            context.fillStyle = "#000";
            drawText(context, "1", tx + 0.5 * tr, ty - 0.866 * tr);
            drawText(context, "2", tx + 0.866 * tr, ty - 0.5 * tr);
            drawText(context, "3", tx + tr, ty);
            drawText(context, "4", tx + 0.866 * tr, ty + 0.5 * tr);
            drawText(context, "5", tx + 0.5 * tr, ty + 0.866 * tr);
            drawText(context, "6", tx, ty + tr);
            drawText(context, "7", tx - 0.5 * tr, ty + 0.866 * tr);
            drawText(context, "8", tx - 0.866 * tr, ty + 0.5 * tr);
            drawText(context, "9", tx - tr, ty);
            drawText(context, "10", tx - 0.866 * tr, ty - 0.5 * tr);
            drawText(context, "11", tx - 0.5 * tr, ty - 0.866 * tr);
            drawText(context, "12", tx, ty - tr);
            //获取当前时间
            var date = new Date(),
                h = date.getHours(),
                m = date.getMinutes(),
                s = date.getSeconds(),
                angleH = (360 / 12) * Math.PI / 180,
                angleM = (360 / 60) * Math.PI / 180
            context.strokeSyle = "#000";
            //绘制时刻度
            drawScale(context, x, y, r, angleH, -0.88 * r, -0.96 * r, 3);
            //绘制分刻度
            drawScale(context, x, y, r, angleM, -0.93 * r, -0.96 * r, 1);
            //绘画时分秒针
            drawCircle(context, x, y, 3);
            drawNeedle(context, x, y, r, h * angleH + m * angleM / 12, -0.5 * r);
            drawNeedle(context, x, y, r, m * angleM + s * angleM / 60, -0.6 * r);
            drawNeedle(context, x, y, r, s * angleM, -0.75 * r);

        }
        //绘画圆
        function drawCircle(context, x, y, r) {
            context.save();
            context.beginPath();
            context.arc(x / 2, y / 2, r, 0, Math.PI * 2, 0);
            context.fill();
            context.closePath();
            context.restore();
        }
        //绘画文字方法
        function drawText(context, text, x, y) {
            context.save();
            x -= (context.measureText(text).width / 2);
            y += 4;
            context.translate(x, y);
            context.fillText(text, 0, 0);
            context.restore();
        }
        //绘制刻度方法
        function drawScale(context, x, y, r, rotate, start, end, lineWidth) {
            context.save();
            context.beginPath();
            context.translate(x / 2, y / 2);
            context.lineWidth = lineWidth;
            for (var i = 0; i < 60; i++) {
                context.rotate(rotate);
                context.moveTo(0, start);
                context.lineTo(0, end);
            }
            context.closePath();
            context.stroke();
            context.restore();
        }
        //绘画时分秒针方法
        function drawNeedle(context, x, y, r, rotate, line) {
            context.save();
            context.translate(x / 2, y / 2);
            context.beginPath();
            context.rotate(rotate);
            context.moveTo(0, 0.1 * r);
            context.lineTo(0, line);
            context.closePath();
            context.stroke();
            context.restore();
        }
        function back(){
            window.history.back(-1);
        }
    </script>
</head>

<body onload="init()">


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        onclick="back()">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">时间信息</h4>
            </div>
            <div class="modal-body">
                <div class="panel panel-primary" style="margin-top: 10px">
                    <div class="panel-heading">
                        <h3 class="panel-title">时间详情</h3>
                    </div>
                    <div class="panel-body">
                        <h2 style="text-align: center;">
                            Time： <span id="timeid"></span>
                        </h2>
                        <div style="text-align: center;" >
                            <canvas id="canvas" width="200px" height="200px"></canvas>
                        </div>
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
