<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <img src="<%=path%>/static/front/img/Active@2x.png" alt="">
    <div class="d-list-row">
        <em>${voucher.activityName}</em>
        <i>${voucher.voucherNum}</i>
    </div>
</div>
<div class="detail-list-row">
    <em>规则说明</em>
    <img src="<%=path%>/static/front/img/ruleActive@2x.png" alt="">
</div>
<div class="detail-list-row2">
    <em>${voucher.goodName}</em>
    <i>有效至 ${fn:substring(voucher.validStartDate, 0, 10)} - ${fn:substring(voucher.validEndDate, 0, 10)}</i>
</div>
<div class="detail-list-row3">
    <p>${voucher.goodUseRule}</p>
</div>
</body>
</html>
