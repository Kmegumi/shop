<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String path=request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>拼购商城</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">

  <%@include file="../../include_front_titile.jsp"%>
  <style>
    .errorContent {  position: absolute;  top: 0;  bottom: 0;  left: 0;  right: 0;  margin: auto;  height: 5.2rem;  width: 70%;  text-align: center;  }
    .error-font{  position: absolute;  bottom: 0;  left: 0;  right: 0;  font-size: 0.7rem;  color: #666;  }
  </style>
</head>
<body>
<div class="page-group">
  <div class="page page-current" id='router'>
    <header class="bar bar-nav header-z">
      <a href="javascript:void(0);" onclick="goPersonal()" class="icon icon-left pull-left"></a>
      <h1 class="title">申请售后</h1>
    </header>
    <div class="content">
      <c:if test="${empty list}">
        <div class="page-group" style="background: #eee;">
          <div class="errorContent">
            <img src="<%=path %>/static/front/img/error.png" alt="">
            <div class="error-font">您还没有相关的售后</div>
          </div>
        </div>
      </c:if>
      <c:forEach items="${list}" var="val">
        <div class="row no-gutter progress-row">
          <div class="col-50 progress-row_l">${val.order.orderNum}</div>
          <div class="col-50 progress-row_r">${val.afterSaleStatusEnum.desc}</div>
        </div>
        <div class="order-detail" style="    border-bottom: 1px solid #efefef; background: #fff;">
          <div class="order-detailLeft">
            <img src="${val.order.goods.url}${val.order.goods.img}" alt="">
          </div>
          <div class="order-detailRight" style="padding: 0.6rem 0;">
            <div class="detailRight_f" style="font-size: 0.75rem;color: #333;  margin-bottom: 0.4rem; height: 1rem;">
              <div class="f_left">${val.order.goods.name}</div>
              <div class="f_right">￥${val.order.goodsMoney}</div>
            </div>
            <div class="detailRight_f" style="font-size: 0.65rem;color: #666;  margin-bottom: 0.4rem; height: 0.9rem;">
              <div class="f_left"><em>${val.order.goods.teamNum}</em>人团</div>
              <div class="f_right">×<em>${val.order.goodsNum}</em></div>
            </div>
          </div>
        </div>
        <div class="progress-mod">
          <div class="progress-row2">共<em>1</em>件&nbsp;合计：<i>￥${val.order.goodsTotalMoney}</i></div>
          <div class="progress-row3">
            <a href="javascript:void(0);" onclick="goafterSaleInfo(${val.id})"><div class="row3-mod row3-mod_r">售后详情</div></a>
          </div>
        </div>
      </c:forEach>

    </div>
  </div>
</div>
<script>
  function goafterSaleInfo(id){
    location.href = "<%=path %>/rest/front/afterSaleInfo?id="+id;
  }
  function goPersonal(){
    location.href="<%=path%>/rest/front/personal";
  }
</script>
</body>
</html>
