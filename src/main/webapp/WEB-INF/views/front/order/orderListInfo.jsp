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
    <div class="oreder_c">${val.orderStatusEnum.desc}</div>
  </div>
  <div class="order-detail" onclick="goOrderDetail('${val.orderNum}')" style="    border-bottom: 1px solid #efefef; background: #fff;">
    <div class="order-detailLeft">
      <img src="${val.goods.url}${val.goods.img}" alt="">
    </div>
    <div class="order-detailRight" style="padding: 0.6rem 0;">
      <div class="detailRight_f" style="font-size: 0.75rem;color: #333;  margin-bottom: 0.4rem; height: 1rem;">
        <div class="f_left">${val.goods.name}</div>
        <div class="f_right">￥${val.goodsMoney}</div>
      </div>
      <div class="detailRight_f" style="font-size: 0.65rem;color: #666;  margin-bottom: 0.4rem; height: 0.9rem;">
        <div class="f_left"><em>${val.teamOrder.teamNum}</em>人团</div>
        <div class="f_right">×<em>${val.goodsNum}</em></div>
      </div>
    </div>
  </div>
  <div class="progress-mod">
    <%--共<em>1</em>件&nbsp;--%>
    <div class="progress-row2">合计：<i>￥${val.goodsTotalMoney}</i></div>
    <div class="progress-row3">
      <c:if test="${val.orderStatusEnum.name() == 'PAY_WAIT'}">
        <a href="javascript:void(0);" onclick="clearOrder(${val.id})" class="row3-mod row3-mod_r open-about2"><input class="id" type="hidden" value="${val.id}">取消订单</a>
        <a href="javascript:void(0);" class="row3-mod row3-mod_r open-about">立即付款<input class="money" type="hidden" value="${val.goodsTotalMoney}"><input class="id" type="hidden" value="${val.id}"></a>
      </c:if>
      <c:if test="${val.orderStatusEnum.name() == 'CLOSE'}">
        <a href="javascript:void(0);" onclick="deleteOrder(${val.id})" class="row3-mod row3-mod_r">删除订单</a>
      </c:if>
      <c:if test="${val.orderStatusEnum.name() == 'TEAM_FAIL_PAID'}">
        <a href="javascript:void(0);" onclick="deleteOrder(${val.id})" class="row3-mod row3-mod_r">再次购买</a>
      </c:if>
      <c:if test="${val.orderStatusEnum.name() == 'OK' && val.goods.goodsTypeEnum.name() != 'IN_KIND'}">
        <a href="javascript:void(0);" onclick="seeCoupons(${val.id})" class="row3-mod row3-mod_r">在线预约</a>
      </c:if>
      <c:if test="${val.goods.ifNeedInvoice == true && val.goods.invoiceType == 2}">
        <c:if test="${val.orderStatusEnum.name() == 'OK' && (val.invoiceToken == null || val.invoiceToken == '')}">
          <a href="javascript:void(0);" onclick="createInvoice('${val.id}')" class="row3-mod row3-mod_r">申请开票</a>
        </c:if>
        <c:if test="${val.orderStatusEnum.name() == 'OK' && val.invoiceToken != null && val.invoiceToken != ''}">
          <a href="javascript:void(0);" onclick="createInvoice('${val.id}')" class="row3-mod row3-mod_r">
            <c:if test="${val.invoiceStatus == null || val.invoiceStatus == ''}">
              申请开票
            </c:if>
            <c:if test="${val.invoiceStatus != null || val.invoiceStatus != ''}">
              ${val.invoiceStatus}
            </c:if>
          </a>
        </c:if>
      </c:if>
    </div>
  </div>
</c:forEach>
