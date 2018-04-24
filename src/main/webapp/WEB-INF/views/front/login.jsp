<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>商城</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">

    <link rel="stylesheet" href="//g.alicdn.com/msui/sm/0.6.2/css/sm.min.css">
    <link rel="stylesheet" href="<%=path %>/static/front/css/main.css">
    <link rel="stylesheet" href="//g.alicdn.com/msui/sm/0.6.2/css/sm-extend.min.css">
    <link rel="stylesheet" href="http://static.shands.cn/common/frozenui-1.3.0/css/table.css">
    <script type='text/javascript' src='http://a.tbcdn.cn/libs/jquery/1.7.1/jquery.js' charset='utf-8'></script>
</head>
<body >
<div class="page-group" style="background: #fff">
    <header class="bar bar-nav" style="height: 2.6rem;line-height: 2.6rem;background: #fff;position: initial;  border-bottom: 1px solid #efefef;">
        <a class="button button-link button-nav pull-left" href="#" data-transition='slide-out' style="    margin-left: 0.25rem;line-height: 2.5rem;height: 2.6rem;">
            <!--<span class="icon close-popup" style="color: #666; font-size: 1.2rem;">×</span>-->
        </a>
        <h1 class="title" style="font-size: 0.75rem;color: #333;height: 2.6rem;line-height: 2.6rem;">会员登录</h1>
    </header>
    <div class="login-row">
        <form action="#" method="post" id="form">
            <div class="login-input">
                <input type="tel" placeholder="手机号" name="tel">
            </div>
            <div class="login-input" style="display:-webkit-box;display:-moz-box;display:-webkit-flex;display:-moz-flex;display:-ms-flexbox;display: flex; -webkit-align-items:center;-moz-align-items:center;-ms-align-items:center;-o-align-items:center;align-items:center;">
                <input name="login_check_code" type="tel" placeholder="验证码" style="-prefix-box-flex: 0.6;-webkit-box-flex: 0.6;-webkit-flex: 0.6;-moz-box-flex: 0.6;-ms-flex: 0.6;flex: 0.6;padding: 0 0 0 0.75rem;">
                <div class="code-wrap" id="login_get_check_code" onclick="sendCheckCode(this)">获取验证码</div>
            </div>
        </form>
    </div>
    <div class="invoice-footer" style="background: #FA725A;" id="login_req">登录</div>
</div>

<script type='text/javascript' src='//g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
<script>
    //    $.config = {
    //        router: false
    //    }
</script>
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm.min.js' charset='utf-8'></script>
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm-extend.min.js' charset='utf-8'></script>
<script type='text/javascript' src='http://a.tbcdn.cn/libs/jquery/1.7.1/jquery.js' charset='utf-8'></script>

<!-- Initialize Swiper -->
<script>
    var $j = jQuery.noConflict(); //自定义一个比较短快捷方式
    $j(function() {
        $.init();
    })
</script>
<script>

    var countdown=60;
    var sendSign=false;//重复提交标记
    var loginSign = false;//重复提交标记
    var loginStatus = false;  //是否已登录标记
    $(document).ready(function () {
        $.post('<%=path%>/rest/front/loginStatus',{},function (data) {
            if(data.code=='200'){
                loginStatus=true;
            } else if(data.code=='300'){
                loginStatus=false;
            }else {
                loginStatus=true;
            }
        })
    });


    function sendCheckCode(obj) {
        if (countdown == 60) {
            var mobile = $("input[name='tel']").val();
            var regPartton = /^1[2-9]\d{9}$/;
            if ((mobile.trim().length == 0 || !regPartton.test(mobile))) {
                alert("手机号码格式不正确!");
                return;
            }
            setTime(obj);
            //假装发了
            return;
        }
    }

    function setTime(obj) {
        if(sendSign ==true) {
            sendSign = false;
            return;
        }
        if (countdown <= 0) {
            obj.innerHTML="获取验证码";
            countdown = 60;
            return;
        } else {
            obj.innerHTML="重新发送(" + countdown + ")";
            countdown--;
        }
        setTimeout(function() {setTime(obj)},1000)
    }




    $("#login_req").click(function () {
        if(loginSign == true) {
            return;
        }

        var yzm = $("input[name='login_check_code']");
        var checkcode =$(yzm).val();
        if(checkcode ==''){
            return;
        }

        loginSign = true;
        $(this).html("努力登录中...");

        $.ajax({
            url : '<%=path%>/rest/front/login',
            data : {checkCode:checkcode, tel :$("input[name='tel']").val()},
            type : "POST",
            dataType:"json",
            success : function(data) {
                if(data.code =='200'){
                    window.location.href = '<%=path%>/rest/front/index';
                    return;
                }else{
                    loginSign = false;
                    $(this).html("登录");
                    alert(data.msg);
                }
            },
            error:function(XMLHttpRequest, textStatus, errorThrown){
                loginSign = false;
                $(this).innerHTML = "登录";
                alert('网络异常,请稍后再试');
            }

        });

    });


    //    /**手动触发事件**/
    //    $(document).ready(function () {
    //                $.popup('.popup-login');
    //    });
    //    /**登录成功后调用函数**/
    //    loginSuccess();
</script>
</body>
</html>