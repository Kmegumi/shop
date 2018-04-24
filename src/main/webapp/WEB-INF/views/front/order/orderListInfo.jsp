<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
  String path=request.getContextPath();
%>
<c:if test="${empty list}">
    <div class="errorContent">
      <img src="<%=path %>/static/front/img/error.png" alt="">
      <div class="error-font">您还没有相关的订单</div>
    </div>
</c:if>
<c:forEach items="${list}" var="val">
  <div onclick="goOrderDetail('${val.orderNum}')" class="order">
    <div class="oreder_b">订单编号：</div>
    <div class="oreder_h">${val.orderNum}</div>
    <!--<div class="oreder_s">交易成功</div>-->
    <div class="oreder_c">${val.orderStatusEnum.description}</div>
  </div>
  <div class="order-detail" onclick="goOrderDetail('${val.orderNum}')" style="    border-bottom: 1px solid #efefef; background: #fff;">
    <div class="order-detailLeft">
      <img src="${val.goods.goodsImg}" alt="">
    </div>
    <div class="order-detailRight" style="padding: 0.6rem 0;">
      <div class="detailRight_f" style="font-size: 0.75rem;color: #333;  margin-bottom: 0.4rem; height: 1rem;">
        <div class="f_left">${val.goods.goodsName}</div>
        <div class="f_right">￥${val.goodsTotalMoney}</div>
      </div>
      <div class="detailRight_f" style="font-size: 0.65rem;color: #666;  margin-bottom: 0.4rem; height: 0.9rem;">

      </div>
    </div>
  </div>
  <div class="progress-mod">
    <%--共<em>1</em>件&nbsp;--%>
    <div class="progress-row2">合计：<i>￥${val.goodsTotalMoney}</i></div>
    <div class="progress-row3">

    </div>
  </div>
</c:forEach>
