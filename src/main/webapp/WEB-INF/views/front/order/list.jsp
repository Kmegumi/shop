<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    .buttons-tab .button.active{color: #FA725A;    border-color: #FA725A;}
    .errorContent {  position: absolute;  top: 0;  bottom: 0;  left: 0;  right: 0;  margin: auto;  height: 5.2rem;  width: 70%;  text-align: center;  }
    .error-font{  position: absolute;  bottom: 0;  left: 0;  right: 0;  font-size: 0.7rem;  color: #666;  }
    .pay-wrap img.kou{width: 25px;
      height: 20px;}
  </style>
</head>
<body>
<div class="page-group">
  <div class="page page-current" id='router'>
    <header class="bar bar-nav header-z">
      <a href="javascript:void(0);" onclick="goPersonal()" class="icon icon-left pull-left"></a>
      <h1 class="title">我的订单</h1>
    </header>
    <div class="content">
      <div class="buttons-tab" style="margin-bottom: 0.4rem;">

        <a href="#tab1" onclick="orderListByState('',1)" class="tab-link <c:if test="${status == ''}">active</c:if> button">全部</a>
        <a href="#tab2" onclick="orderListByState('PAY_WAIT',2)" class="tab-link <c:if test="${status == 'PAY_WAIT'}">active</c:if> button">待付款</a>
        <a href="#tab5" onclick="orderListByState('TEAM_WAIT',5)" class="tab-link <c:if test="${status == 'TEAM_WAIT'}">active</c:if> button">待成团</a>
        <a href="#tab3" onclick="orderListByState('SEND_WAIT',3)" class="tab-link <c:if test="${status == 'SEND_WAIT'}">active</c:if> button">待发货</a>
        <a href="#tab4" onclick="orderListByState('OK',4)" class="tab-link <c:if test="${status == 'OK'}">active</c:if> button">完成</a>

      <%--<a href="<%=path %>/rest/front/orderList" class="<c:if test="${status == ''}">active</c:if> button">全部</a>--%>
        <%--<a href="<%=path %>/rest/front/orderList?orderStatus=PAY_WAIT" class="<c:if test="${status == 'PAY_WAIT'}">active</c:if> button">待付款</a>--%>
        <%--<a href="<%=path %>/rest/front/orderList?orderStatus=TEAM_WAIT" class="<c:if test="${status == 'TEAM_WAIT'}">active</c:if> button">待成团</a>--%>
        <%--<a href="<%=path %>/rest/front/orderList?orderStatus=SEND_WAIT" class="<c:if test="${status == 'SEND_WAIT'}">active</c:if> button">待发货</a>--%>
        <%--<a href="<%=path %>/rest/front/orderList?orderStatus=OK" class="<c:if test="${status == 'OK'}">active</c:if> button">已发货</a>--%>
      </div>
        <div class="content-block">
          <div class="tabs">
            <div id="tab1" class="tab <c:if test="${status == ''}">active</c:if>">
              <c:if test="${empty list}">
                <div class="errorContent">
                  <img src="../../../static/front/img/error.png" alt="">
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
                      <a href="javascript:void(0);" class="row3-mod row3-mod_r open-about2"><input class="id" type="hidden" value="${val.id}">取消订单</a>
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
            </div>
            <div id="tab2" class="tab <c:if test="${status == 'PAY_WAIT'}">active</c:if>">
              <c:if test="${empty list}">
                <div class="errorContent">
                  <img src="../../../static/front/img/error.png" alt="">
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
                      <a href="javascript:void(0);" class="row3-mod row3-mod_r open-about2"><input class="id" type="hidden" value="${val.id}">取消订单</a>
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
                  </div>
                </div>
              </c:forEach>
            </div>
            <div id="tab3" class="tab <c:if test="${status == 'SEND_WAIT'}">active</c:if>">
              <c:if test="${empty list}">
                <div class="errorContent">
                  <img src="../../../static/front/img/error.png" alt="">
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
                      <a href="javascript:void(0);" class="row3-mod row3-mod_r open-about2"><input class="id" type="hidden" value="${val.id}">取消订单</a>
                      <a href="javascript:void(0);" class="row3-mod row3-mod_r open-about">立即付款<input class="money" type="hidden" value="${val.goodsTotalMoney}"><input class="id" type="hidden" value="${val.id}"></a>
                    </c:if>
                    <c:if test="${val.orderStatusEnum.name() == 'CLOSE'}">
                      <a href="javascript:void(0);" onclick="deleteOrder(${val.id})" class="row3-mod row3-mod_r">删除订单</a>
                    </c:if>
                    <c:if test="${val.orderStatusEnum.name() == 'TEAM_FAIL_PAID'}">
                      <a href="javascript:void(0);" onclick="deleteOrder(${val.id})" class="row3-mod row3-mod_r">再次购买</a>
                    </c:if>
                  </div>
                </div>
              </c:forEach>
            </div>
            <div id="tab5" class="tab <c:if test="${status == 'TEAM_WAIT'}">active</c:if>">
              <c:if test="${empty list}">
                <div class="errorContent">
                  <img src="../../../static/front/img/error.png" alt="">
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
                      <a href="javascript:void(0);" class="row3-mod row3-mod_r open-about2"><input class="id" type="hidden" value="${val.id}">取消订单</a>
                      <a href="javascript:void(0);" class="row3-mod row3-mod_r open-about">立即付款<input class="money" type="hidden" value="${val.goodsTotalMoney}"><input class="id" type="hidden" value="${val.id}"></a>
                    </c:if>
                    <c:if test="${val.orderStatusEnum.name() == 'CLOSE'}">
                      <a href="javascript:void(0);" onclick="deleteOrder(${val.id})" class="row3-mod row3-mod_r">删除订单</a>
                    </c:if>
                    <c:if test="${val.orderStatusEnum.name() == 'TEAM_FAIL_PAID'}">
                      <a href="javascript:void(0);" onclick="deleteOrder(${val.id})" class="row3-mod row3-mod_r">再次购买</a>
                    </c:if>
                  </div>
                </div>
              </c:forEach>
            </div>
            <div id="tab4" class="tab <c:if test="${status == 'OK'}">active</c:if>">
              <c:if test="${empty list}">
                <div class="errorContent">
                  <img src="../../../static/front/img/error.png" alt="">
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
                      <a href="javascript:void(0);" class="row3-mod row3-mod_r open-about2"><input class="id" type="hidden" value="${val.id}">取消订单</a>
                      <a href="javascript:void(0);" class="row3-mod row3-mod_r open-about">立即付款<input class="money" type="hidden" value="${val.goodsTotalMoney}"><input class="id" type="hidden" value="${val.id}"></a>
                    </c:if>
                    <c:if test="${val.orderStatusEnum.name() == 'CLOSE'}">
                      <a href="javascript:void(0);" onclick="deleteOrder(${val.id})" class="row3-mod row3-mod_r">删除订单</a>
                    </c:if>
                    <c:if test="${val.orderStatusEnum.name() == 'TEAM_FAIL_PAID'}">
                      <a href="javascript:void(0);" onclick="goGoods(${val.goods.id})" class="row3-mod row3-mod_r">再次购买</a>
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
            </div>
          </div>
          <nav class="bar bar-tab footer-bar" style="position: fixed;height: 2.65rem;">
            <a class="tab-item external active" href="<%=path%>/">
            <span>
                <img src="../../../static/front/img/Icon_Tab_Bar_Home_Inactive.svg" alt="">
                <img src="../../../static/front/img/Icon_Tab_Bar_Home_Active.svg" alt="">
            </span>
                  <span class="tab-label">首页</span>
                </a>
                <a class="tab-item external" href="<%=path%>/rest/front/goodsList?columnId=-1">
            <span>
                <img src="../../../static/front/img/Icon_Tabbar_New_Arrival_Inactive.svg" alt="">
                <img src="../../../static/front/img/Icon_Tabbar_New_Arrival_Activve.svg" alt="">
            </span>
                  <span class="tab-label">上新</span>
                </a>
                <a class="tab-item external" href="<%=path %>/rest/front/orderList">
            <span>
               <img src="../../../static/front/img/Icon_TabBar_List_Active.svg" alt="">
            </span>
                  <span class="tab-label" style="color: #fa725a">订单</span>
                </a>
                <a class="tab-item external" href="<%=path%>/rest/front/personal">
            <span>
              <img src="../../../static/front/img/Icon_Tab_Bar_Person_Center_Active.svg" alt="">
              <img src="../../../static/front/img/Icon_Tab_Bar_Person_Center_Inactive.svg" alt="">
            </span>
              <span class="tab-label">个人中心</span>
            </a>
          </nav>
        </div>
    </div>
  </div>
</div>
<div class="popup popup-about">
  <header class="bar bar-nav" style="height: 2.6rem;line-height: 2.6rem;background: #fff;position: initial;  border-bottom: 1px solid #efefef;">
    <a class="button button-link button-nav pull-left" href="#" data-transition='slide-out' style="    margin-left: 0.25rem;line-height: 2.5rem;height: 2.6rem;">
      <span class="icon close-popup" style="color: #666; font-size: 1.2rem;">×</span>
    </a>
    <h1 class="title" style="font-size: 0.75rem;color: #333;height: 2.6rem;line-height: 2.6rem;">选择付款方式</h1>
  </header>
  <div class="popup-row"></div>
    <input type="hidden" id="payWayEnum">
    <input type="hidden" id="orderId">
    <div class="pay-wrap">
      <img src="<%=path %>/static/front/img/Wechat.svg" alt="微信logo">
      <p>微信支付</p>
      <img src="<%=path %>/static/front/img/kou.png"  class="kou" alt="">
      <input type="hidden" class="type" value="WECHAT_PAY">
    </div>
    <%--<div class="pay-wrap">--%>
      <%--<img src="<%=path %>/static/front/img/Unionpay.svg" alt="银联logo">--%>
      <%--<p>银联支付</p>--%>
      <%--<img src="<%=path %>/static/front/img/kou.png"  class="kou" alt="">--%>
      <%--<input type="hidden" class="type" value="UNION_PAY">--%>
    <%--</div>--%>
    <div class="pay-wrap">
      <img src="<%=path %>/static/front/img/Alipay.svg" alt="支付宝logo">
      <p>支付宝支付</p>
      <img src="<%=path %>/static/front/img/kou.png" class="kou" alt="">
      <input type="hidden" class="type" value="ALIPAY">
    </div>
    <a href="javascript:void(0);" onclick="payNow()" class="popup-footer">立即支付</a>
    </div>
  </div>
<div class="popup popup-about2">
  <input type="hidden" id="closeCause">
  <header class="bar bar-nav" style="height: 2.6rem;line-height: 2.6rem;background: #fff;position: initial;  border-bottom: 1px solid #efefef;">
    <a class="button button-link button-nav pull-left" href="#" data-transition='slide-out' style="    margin-left: 0.25rem;line-height: 2.5rem;height: 2.6rem;">
      <span class="icon close-popup" style="color: #666; font-size: 1.2rem;">×</span>
    </a>
    <h1 class="title" style="font-size: 0.75rem;color: #333;height: 2.6rem;line-height: 2.6rem;">选择取消原因</h1>
  </header>
  <div class="pay-wrap">
    <p style="margin-left: 0">不想买了</p>
    <img src="<%=path %>/static/front/img/kou.png" class="kou" alt="">
    <input type="hidden" class="closeCause" value="不想买了">
  </div>
  <div class="pay-wrap">
    <p style="margin-left: 0">选错了</p>
    <img src="<%=path %>/static/front/img/kou.png" class="kou" alt="">
    <input type="hidden" class="closeCause" value="选错了">
  </div>
  <a href="javascript:void(0);" onclick="cancel()" class="popup-footer">确认</a>
</div>
</div>
<script>
  var $j = jQuery.noConflict(); //自定义一个比较短快捷方式
  $j(function() {
    $.init();
  })
  $j(".pay-wrap").click(function () {
    $j(this).children(".kou").show();
    $j(this).siblings(".pay-wrap").children(".kou").hide();
    $j("#payWayEnum").val($j(this).children(".type").val());
    $j("#closeCause").val($j(this).children(".closeCause").val());
  })
  $j(".order_w").click(function () {
    $j(this).css({
      "border":"1px solid #FA725A",
      'color':'#FA725A'
    }).siblings().css({'border':'1px solid #999','color':'#999'});
  })
  $(document).on('click','.open-about', function () {
    $("#orderId").val($j(this).children(".id").val());
    $(".popup-row").html("您的订单已提交，请在半小时内完成支付，金额¥"+$j(this).children(".money").val());
    $.popup('.popup-about');
  });
  $(document).on('click','.open-about2', function () {
    $("#orderId").val($j(this).children(".id").val());
    $.popup('.popup-about2');
  });
</script>

<script>
  function goOrderDetail(orderNum){
    location.href = "<%=path %>/rest/front/orderDetail?orderNum="+orderNum;
  }
  function payNow(){
    location.href = "<%=path%>/rest/front/payNow?orderId="+$("#orderId").val()+"&payWayEnum="+$("#payWayEnum").val();
  }
  function goPersonal(){
    location.href = "<%=path %>/rest/front/personal";
  }
  function deleteOrder(id){
    swal({
      title: "您确定要删除这条订单?",
      type: "warning",
      showCancelButton: true,
      closeOnConfirm: false,
      cancelButtonText:"取消",
      confirmButtonText: "确定",
      confirmButtonColor: "#ec6c62"
    },function(){
      $.ajax({
        url:'<%=path %>/rest/front/updateOrderFalg',
        type:'post',
        data:{orderId:id},
        success: function (data) {
          if (data) {
            if (data.code == '1000') {
              swal("删除成功！", "", "success")
              $('.confirm').click(function () {   //额外绑定一个事件，当确定执行之后返回成功的页面的确定按钮，点击之后刷新当前页面或者跳转其他页面
                location.href="<%=path %>/rest/front/orderList?orderStatus=${state}";
              });
              //跳转支付页面
            } else if (data.code == '1100') {
              //弹出登录
            } else {
              alert(data.code);
            }
          }
        }
      })
    })
  }

  function cancel(){
    if($("#closeCause").val() == ''){
      alert('请选择取消原因');
      return false;
    }
    swal({
      title: "您确定要取消这条订单!",
      type: "warning",
      showCancelButton: true,
      closeOnConfirm: false,
      cancelButtonText:"取消",
      confirmButtonText: "确定",
      confirmButtonColor: "#ec6c62"
    },function(){
      console.info($("#orderId").val());
      console.info($("#closeCause").val());
      $.ajax({
        url:'<%=path %>/rest/front/cancel',
        type:'post',
        data:{orderId:$("#orderId").val(),closeCause:$("#closeCause").val()},
        success: function (data) {
          if (data) {
            if (data.code == '1000') {
              swal("取消成功！", "", "success")
              $('.confirm').click(function () {   //额外绑定一个事件，当确定执行之后返回成功的页面的确定按钮，点击之后刷新当前页面或者跳转其他页面
                location.href="<%=path %>/rest/front/orderList?orderStatus=${state}";
              });
              //跳转支付页面
            } else if (data.code == '1100') {
              //弹出登录
            } else {
              alert(data.code);
            }
          }
        }
      })
    })
  }

  function orderListByState(state,id){
    $.ajax({
      url:'<%=path %>/rest/front/orderListInfo',
      type:'post',
      data:{orderStatus:state},
      success: function (data) {
        $("#tab"+id).html(data);
      }
    })
  }

  function createInvoice(id) {

//      if (confirm("是否需要开票，开票后，将无法继续开票，如有问题，请联系客服！")) {
          $.ajax({
              url:'<%=path %>/rest/front/createInvoice',
              type:'post',
              data:{'id':id},
              dataType: "json",
              success: function (data) {

                  if (data.code == '1100') {
                      //弹出登录
                      $.popup('.popup-login');
                  }
                  if (data.ifSuccess == "true") {
                      window.location.href = data.url;
                      return;
                  }else {
                      swal(data.msg, "", "success")
                      return;
                  }
              },
              error:function () {
                  swal("系统繁忙，请稍后再试！", "", "success")
                  return;
              }
          })
//      }


  }

  function seeCoupons(id) {
      location.href="<%=path %>/rest/front/couponsList?orderId="+id;
  }

  function goGoods(id){
      location.href="<%=path %>/rest/front/goods/"+id;
  }
</script>
</body>
</html>
