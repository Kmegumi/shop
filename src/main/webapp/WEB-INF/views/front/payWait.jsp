<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String path = request.getContextPath();%>
<html>
<head>
    <%@include file="../include_front_titile.jsp"%>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
    <style>
        .errorContent {  position: absolute;  top: 0;  bottom: 0;  left: 0;  right: 0;  margin: auto;  height: 5.2rem;  width: 70%;  text-align: center;  }
        .error-font{  position: absolute;  bottom: 0;  left: 0;  right: 0;  font-size: 0.7rem;  color: #666;  }
    </style>
</head>
<body>
<div class="page-group" style="background: #000;">
    <div class="errorContent" style="background: url(/static/css/loading2.svg) no-repeat center center;">
        <div class="error-font" style="font-size: 0.8rem;color: white">订单处理中，剩余时间：<em id="time">3</em>s</div>
    </div>
</div>
</body>
<script>
    wx.config({
        debug: false,
        appId: '${signMap.get("appid")}',
        timestamp: ${signMap.get("timestamp")},
        nonceStr: '${signMap.get("nonceStr")}',
        signature: '${signMap.get("signature")}',
        jsApiList: ['hideAllNonBaseMenuItem']
    });
    wx.ready(function(){
        wx.hideAllNonBaseMenuItem();
    });
    var time = 2;
    setInterval(function () {
        document.getElementById('time').innerText = time;
        if (time == 0) {
            window.location.href = '<%=path%>${url}';
            return false;
        }
        time = time - 1;
    },1000)
    //console.log(11)
</script>
</html>
