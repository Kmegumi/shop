<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="popup popup-login">
    <header class="bar bar-nav" style="height: 2.6rem;line-height: 2.6rem;background: #fff;position: initial;  border-bottom: 1px solid #efefef;">
        <a class="button button-link button-nav pull-left" href="#" data-transition='slide-out'  style="    margin-left: 0.25rem;line-height: 2.5rem;height: 2.6rem;">
            <span class="icon close-popup" id="guanbi" style="color: #666; font-size: 1.2rem;">×</span>
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
<script>
    var countdown=60;
    var sendSign=false;//重复提交标记
    var loginSign = false;//重复提交标记
    var loginStatus = 0;  //是否已登录标记
    var isExecFunction = false;
    $(document).ready(function () {
        $.post('<%=path%>/rest/front/loginStatus',{},function (data) {
            if(data.code=='200'){
                loginStatus=1;
            } else if(data.code=='401'){
                loginStatus=2;
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
        $(this).html('<img src="<%=path%>/static/css/loading2.svg" width="28px" height="28px" style="margin-top: 5px">');
        $.ajax({
            url : '<%=path%>/rest/front/login',
            data : {checkCode:checkcode, tel :$("input[name='tel']").val()},
            type : "POST",
            dataType:"json",
            success : function(data) {
                if(data.code=='200'){
                    $('#guanbi').click();
                    if (isExecFunction) {
                        loginSuccess();
                    }
                } else {
                    loginSign = false;
                    $(this).html("登录");
                    alert(data.msg);
                }
            },
            error:function(){
                loginSign = false;
                $(this).innerHTML = "登录";
                alert('网络异常,请稍后再试');
            }
        });
    });
</script>