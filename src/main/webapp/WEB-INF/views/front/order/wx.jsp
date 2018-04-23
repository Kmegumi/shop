<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String path=request.getContextPath();%>
<html>
<head>

</head>
<body>
<script type="text/javascript">
    //当微信内置浏览器完成内部初始化后会触发WeixinJSBridgeReady事件。
    document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
        // 公众号支付
            WeixinJSBridge.invoke(
                'getBrandWCPayRequest', {
                    "appId":"${appId}",     //公众号名称，由商户传入
                    "timeStamp":"${timeStamp}",         //时间戳，自1970年以来的秒数
                    "nonceStr":"${nonceStr}", //随机串
                    "package":"${wxPackage}",
                    "signType":"MD5",         //微信签名方式：
                    "paySign":"${paySign}" //微信签名
                },
                function(res){
                    if(res.err_msg == "get_brand_wcpay_request:ok" ) {
                        window.location.href = '<%=path%>${url}'
                    } else if (res.err_msg == "get_brand_wcpay_request:cancel"){ //取消微信支付
                        window.location.href = '<%=path%>/'
                    }
                    else if(res.err_msg == "get_brand_wcpay_request:fail") { //微信支付失败
                        alert('微信支付失败');
                        window.location.href = '<%=path%>/'
                    }
                    // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回ok，但并不保证它绝对可靠。
                    // 因此微信团队建议，当收到ok返回时，向商户后台询问是否收到交易成功的通知，若收到通知，前端展示交易成功的界面；若此时未收到通知，商户后台主动调用查询订单接口，查询订单的当前状态，并反馈给前
                    // 展示相应的界面。
                }
            );
    }, false);
</script>
</body>
</html>
