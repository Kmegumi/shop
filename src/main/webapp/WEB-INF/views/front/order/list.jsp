<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String path = request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>商城</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <%@include file="../../include_front_titile.jsp" %>
    <style>
        .buttons-tab .button.active {
            color: #FA725A;
            border-color: #FA725A;
        }
        .errorContent {
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            margin: auto;
            height: 5.2rem;
            width: 70%;
            text-align: center;
        }
        .error-font {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            font-size: 0.7rem;
            color: #666;
        }
        .pay-wrap img.kou {
            width: 25px;
            height: 20px;
        }
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
                <a href="#tab1" onclick="orderListByState('',1)"
                   class="tab-link <c:if test="${status == ''}">active</c:if> button">全部</a>
                <a href="#tab2" onclick="orderListByState('PAY_WAIT',2)"
                   class="tab-link <c:if test="${status == 'PAY_WAIT'}">active</c:if> button">待付款</a>
                <a href="#tab3" onclick="orderListByState('SEND_WAIT',3)"
                   class="tab-link <c:if test="${status == 'SEND_WAIT'}">active</c:if> button">待发货</a>
                <a href="#tab4" onclick="orderListByState('OK',4)"
                   class="tab-link <c:if test="${status == 'OK'}">active</c:if> button">完成</a>
            </div>
            <div class="content-block">
                <div class="tabs">
                    <div id="tab1" class="tab <c:if test="${status == ''}">active</c:if>">
                        <c:if test="${empty list}">
                            <div class="errorContent">
                                <img src="<%=path%>/static/front/img/error.png" alt="">
                                <div class="error-font">您还没有相关的订单</div>
                            </div>
                        </c:if>
                        <c:forEach items="${list}" var="val">
                            <div onclick="goOrderDetail('${val.orderNum}')" class="order">
                                <div class="oreder_b">订单编号：</div>
                                <div class="oreder_h">${val.orderNum}</div>
                                <div class="oreder_c">${val.orderStatusEnum.description}</div>
                            </div>
                            <div class="order-detail" onclick="goOrderDetail('${val.orderNum}')"
                                 style="    border-bottom: 1px solid #efefef; background: #fff;">
                                <div class="order-detailLeft">
                                    <img src="${val.goods.goodsImg}" alt="">
                                </div>
                                <div class="order-detailRight" style="padding: 0.6rem 0;">
                                    <div class="detailRight_f"
                                         style="font-size: 0.75rem;color: #333;  margin-bottom: 0.4rem; height: 1rem;">
                                        <div class="f_left">${val.goods.goodsName}</div>
                                        <div class="f_right">￥${val.goodsTotalMoney}</div>
                                    </div>
                                    <%--<div class="detailRight_f" style="font-size: 0.65rem;color: #666;  margin-bottom: 0.4rem; height: 0.9rem;">
                                        <div class="f_left"><em>${val.teamOrder.teamNum}</em>人团</div>
                                        <div class="f_right">×<em>${val.goodsNum}</em></div>
                                    </div>--%>
                                </div>
                            </div>
                            <div class="progress-mod">
                                <div class="progress-row2">合计：<i>￥${val.goodsTotalMoney}</i></div>
                                <div class="progress-row3">
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div id="tab2" class="tab <c:if test="${status == 'PAY_WAIT'}">active</c:if>">
                        <c:if test="${empty list}">
                            <div class="errorContent">
                                <img src="<%=path%>/static/front/img/error.png" alt="">
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
                            <div class="order-detail" onclick="goOrderDetail('${val.orderNum}')"
                                 style="    border-bottom: 1px solid #efefef; background: #fff;">
                                <div class="order-detailLeft">
                                    <img src="${val.goods.goodsImg}" alt="">
                                </div>
                                <div class="order-detailRight" style="padding: 0.6rem 0;">
                                    <div class="detailRight_f"
                                         style="font-size: 0.75rem;color: #333;  margin-bottom: 0.4rem; height: 1rem;">
                                        <div class="f_left">${val.goods.goodsName}</div>
                                        <div class="f_right">￥${val.goodsTotalMoney}</div>
                                    </div>
                                    <%--<div class="detailRight_f" style="font-size: 0.65rem;color: #666;  margin-bottom: 0.4rem; height: 0.9rem;">
                                        <div class="f_left"><em>${val.teamOrder.teamNum}</em>人团</div>
                                        <div class="f_right">×<em>${val.goodsNum}</em></div>
                                    </div>--%>
                                </div>
                            </div>
                            <div class="progress-mod">
                                    <%--共<em>1</em>件&nbsp;--%>
                                <div class="progress-row2">合计：<i>￥${val.goodsTotalMoney}</i></div>
                                <div class="progress-row3">
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div id="tab3" class="tab <c:if test="${status == 'SEND_WAIT'}">active</c:if>">
                        <c:if test="${empty list}">
                            <div class="errorContent">
                                <img src="<%=path%>/static/front/img/error.png" alt="">
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
                            <div class="order-detail" onclick="goOrderDetail('${val.orderNum}')"
                                 style="    border-bottom: 1px solid #efefef; background: #fff;">
                                <div class="order-detailLeft">
                                    <img src="${val.goods.goodsImg}" alt="">
                                </div>
                                <div class="order-detailRight" style="padding: 0.6rem 0;">
                                    <div class="detailRight_f"
                                         style="font-size: 0.75rem;color: #333;  margin-bottom: 0.4rem; height: 1rem;">
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
                    </div>
                    <div id="tab4" class="tab <c:if test="${status == 'OK'}">active</c:if>">
                        <c:if test="${empty list}">
                            <div class="errorContent">
                                <img src="<%=path%>/static/front/img/error.png" alt="">
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
                            <div class="order-detail" onclick="goOrderDetail('${val.orderNum}')"
                                 style="    border-bottom: 1px solid #efefef; background: #fff;">
                                <div class="order-detailLeft">
                                    <img src="${val.goods.goodsImg}" alt="">
                                </div>
                                <div class="order-detailRight" style="padding: 0.6rem 0;">
                                    <div class="detailRight_f"
                                         style="font-size: 0.75rem;color: #333;  margin-bottom: 0.4rem; height: 1rem;">
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
                    </div>
                </div>
                <nav class="bar bar-tab footer-bar" style="position: fixed;height: 2.65rem;">
                    <a class="tab-item external active" href="<%=path%>/">
                        <span>
                            <img src="<%=path%>/static/front/img/Icon_Tab_Bar_Home_Inactive.svg" alt="">
                            <img src="<%=path%>/static/front/img/Icon_Tab_Bar_Home_Active.svg" alt="">
                        </span>
                        <span class="tab-label">首页</span>
                    </a>
                    <a class="tab-item external" href="<%=path%>/rest/front/goodsList?columnId=-1">
                        <span>
                            <img src="<%=path%>/static/front/img/Icon_Tabbar_New_Arrival_Inactive.svg" alt="">
                            <img src="<%=path%>/static/front/img/Icon_Tabbar_New_Arrival_Activve.svg" alt="">
                        </span>
                        <span class="tab-label">商品</span>
                    </a>
                    <a class="tab-item external" href="<%=path %>/rest/front/orderList">
                        <span>
                           <img src="<%=path%>/static/front/img/Icon_TabBar_List_Active.svg" alt="">
                        </span>
                        <span class="tab-label" style="color: #fa725a">订单</span>
                    </a>
                    <a class="tab-item external" href="<%=path%>/rest/front/personal">
                        <span>
                          <img src="<%=path%>/static/front/img/Icon_Tab_Bar_Person_Center_Active.svg" alt="">
                          <img src="<%=path%>/static/front/img/Icon_Tab_Bar_Person_Center_Inactive.svg" alt="">
                        </span>
                        <span class="tab-label">个人中心</span>
                    </a>
                </nav>
            </div>
        </div>
    </div>
</div>
<script>
    var $j = jQuery.noConflict(); //自定义一个比较短快捷方式
    $j(function () {
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
            "border": "1px solid #FA725A",
            'color': '#FA725A'
        }).siblings().css({'border': '1px solid #999', 'color': '#999'});
    })
    $(document).on('click', '.open-about', function () {
        $("#orderId").val($j(this).children(".id").val());
        $(".popup-row").html("您的订单已提交，请在半小时内完成支付，金额¥" + $j(this).children(".money").val());
        $.popup('.popup-about');
    });
    $(document).on('click', '.open-about2', function () {
        $("#orderId").val($j(this).children(".id").val());
        $.popup('.popup-about2');
    });
</script>

<script>
    function goOrderDetail(orderNum) {
        location.href = "<%=path %>/rest/front/orderDetail?orderNum=" + orderNum;
    }
    function goPersonal() {
        location.href = "<%=path %>/rest/front/personal";
    }
    function orderListByState(state, id) {
        $.ajax({
            url: '<%=path %>/rest/front/orderListInfo',
            type: 'post',
            data: {orderStatus: state},
            success: function (data) {
                $("#tab" + id).html(data);
            }
        })
    }
    function goGoods(id) {
        location.href = "<%=path %>/rest/front/goods/" + id;
    }
</script>
</body>
</html>
