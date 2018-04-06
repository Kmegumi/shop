<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path=request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>login</title>
    <link rel="stylesheet" type="text/css" href="<%=path %>/static/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="<%=path %>/static/css/demo.css">
    <!--必要样式-->
    <link rel="stylesheet" type="text/css" href="<%=path %>/static/css/component.css">
</head>
<body>
<div class="container demo-1">
    <div class="content">
        <div id="large-header" class="large-header" style="height: 949px;">
            <canvas id="demo-canvas" width="1068" height="949"></canvas>
            <div class="logo_box">
                <h3>欢迎你</h3>
                <form action="#" id="sub_form" method="post">
                    <div class="input_outer">
                        <span class="u_user"></span>
                        <input name="username" class="text" style="color: #FFFFFF !important" type="text" placeholder="请输入账户">
                    </div>
                    <div class="input_outer">
                        <span class="us_uer"></span>
                        <input name="password" class="text" style="color: #FFFFFF !important; position:absolute; z-index:100;" value="" type="password" placeholder="请输入密码">
                    </div>
                    <div class="mb2">
                        <a class="act-but submit" href="javascript:void (0);" onclick="login()" style="color: #FFFFFF">登录</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="<%=path %>/static/js/TweenLite.min.js"></script>
<script src="<%=path %>/static/js/EasePack.min.js"></script>
<script src="<%=path %>/static/js/demo-1.js"></script>
<script src="<%=path%>/static/js/jquery.min.js"></script>
<script>
    function login() {
        $.ajax({
            type: 'POST',
            url: '<%=path %>/rest/login/login',
            data: $('#sub_form').serialize(),
            cache: true,
            dataType: "json",
            async: true,
            beforeSend: function () { },
            success: function (data) {
                if (data) {
                    if (data.code == '200') {
                        window.location.href="<%=path%>/rest/index";
                    } else {
                        alert(data.msg);
                    }
                }
            },
            error: function () { }
        });
    }
</script>
</body>
</html>
