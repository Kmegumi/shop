<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String path=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>拼购商城</title>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" type="text/css" href="<%=path%>/static/front/css/coupons.css"/>
</head>
<body style="background: #F4F4F4">
<div class="detail-list">
    <img src="<%=path%>/static/front/img/Inactive@2x.png" alt="">
    <div class="d-list-row d-list-row2">
        <em>${voucher.activityName}</em>
        <i>${voucher.voucherNum}</i>
    </div>
</div>
<div class="detail-list-row row2">
    <em>规则说明</em>
    <img src="<%=path%>/static/front/img/ruleInActive@2x.png" alt="">
</div>
<div class="detail-list-row2 row3">
    <em>${voucher.goodName}</em>
    <i>${status}</i>
</div>
<div class="detail-list-row3 row4">
    <p>${voucher.goodUseRule}</p>
</div>
</body>
</html>
