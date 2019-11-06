<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>佰圣人力</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link type="text/css" href="assets/css/style.css" rel="stylesheet" />
    <%@include file="header.jsp"%>
</head>
<body>
<%@include file="footer.jsp"%>
<div class="container" align="center">
    <div class="col-md-6" style="margin-top: 10%;">
        <div class="inset">
            <form name="login" id="login" onkeydown="keyLogin()">
                <div>
                    <h2>佰圣人力代理系统</h2>
                    <span style="text-align: left;text-indent: 0.4em;"><label>用户名</label></span>
                    <span><input id="username" type="text" name="username" class="textbox" ></span>
                </div>
                <div>
                    <span style="text-align: left;text-indent: 0.4em;"><label>密码</label></span>
                    <span><input id="password"  name="password" type="password" class="password"></span>
                </div>
                <div class="sign">
                    <input type="reset"  class="submit" value="重置"/>
                    <input id="loginButton" type="button" class="submit" value="登录"/>
                </div>
            </form>
        </div>
    </div>
</div>


<script>
    $(document).ready(function(){
        $("#loginButton").click(
            function (event) {
                event.preventDefault();
                if (checkLogin()) {
                    // 发送登录请求
                    $.ajax({
                        type: "POST",
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        url: "/user/login",
                        data: $("#login").serialize(),
                        success: function (result) {
                            if (result.status == '0') {
                                // 登录成功,跳转到主界面
                                window.location.href = '/';
                            } else {
                                Notiflix.Report.Failure( '操作失败', result.msg, '知道了' );
                            }
                        },
                        error: function (e) {
                            Notiflix.Report.Failure( '操作失败', "登录失败，请稍后再试", '知道了' );
                        }
                    });
                }
            }
        );
    });

    // 检查是否输入用户名、密码
    function checkLogin(){
        if ($("#username").val() == null || $("#username").val() == "") {
            Notiflix.Notify.Warning('请输入用户名');
            return false;
        }
        if ($("#password").val() == null || $("#password").val() == "") {
            Notiflix.Notify.Warning('请输入密码');
            return false;
        }
        return true;
    }
    // 按下回车键
    function keyLogin() {
        if (event.keyCode == 13) {
            document.getElementById("loginButton").click();
        }
    }
</script>

</body>
</html>
