<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../include_front_titile.jsp"%>
</head>
<style>
    ::-webkit-input-placeholder { /* WebKit browsers */
        text-indent: 0.75rem;
    }
    :-moz-placeholder { /* Mozilla Firefox 4 to 18 */
        text-indent: 0.75rem;
    }
    ::-moz-placeholder { /* Mozilla Firefox 19+ */
        text-indent: 0.75rem;
    }
    :-ms-input-placeholder { /* Internet Explorer 10+ */
        text-indent: 0.75rem;
    }
</style>
<body>
<div class="page-group">
    <div class="page page-current" id='router'>
        <header class="bar bar-nav header-z">
            <a class="icon icon-left pull-left" onclick="window.location.href='/rest/front/goods/${dome.goodsId}'"></a>
            <h1 class="title">订单确认</h1>
        </header>
        <form id="orderForm" method="post" >
            <input name="goodsId" type="hidden" id="goodsId" value="${goods.id}" />
            <input name="goodsNum" type="hidden" id="goodsNum" value="${goodsNum}"/>
            <input name="shippingDetail" type="shippingDetail" id="shippingDetail" value="${goodsNum}"/>
            <input name="message" type="hidden" id="message" value="${goodsNum}"/>
        </form>
            <div class="content" style="padding-bottom: 5rem;">
                <div class="order-detail order-detail_c">
                    <div class="order-detailLeft">
                        <img src="${goods.goodsImg}" alt="">
                    </div>
                    <div class="order-detailRight" style="padding: 0.6rem 0">
                        <div class="detailRight_f" style="font-size: 0.75rem;color: #333;margin-bottom: 0.4rem;height: 1rem;">
                            <div class="f_left">${goods.goodsName}</div>
                            <div class="f_right">￥${goods.goodsPrice}</div>
                        </div>
                        <div class="detailRight_f" style="font-size: 0.65rem;color: #666;  margin-bottom: 0.4rem;height: 0.9rem;">
                            <div class="f_left"></div>
                            <div class="f_right">×<em>${goodsNum}</em></div>
                        </div>
                    </div>
                </div>
                <div class="pay-row2-wrap">
                    <div class="pay-row2">收货地址：</div>
                    <textarea class="leave" id="shipping" name="shipping" placeholder="收货地址联系信息"></textarea>
                </div>
                <div class="pay-row2-wrap">
                    <div class="pay-row2">要求说明</div>
                    <textarea class="leave" id="orderMessage" placeholder="留言"></textarea>
                </div>
                <div class="pay-footer">
                    <div class="pay-footer-col1">
                        <img src="<%=path %>/static/front/img/back.png" onclick="window.location.href='<%=path %>/rest/front/goods/${goods.id}'">
                    </div>
                    <div class="pay-footer-col2">实付：<em><fmt:formatNumber value="${goods.goodsPrice * goodsNum}" type="currency" pattern="￥0.00"/></em></div>
                    <div class="pay-footer-col3" onclick="pay()">立即支付</div>
                </div>
            </div>

        <%@include file="../login/_login.jsp"%>
    </div>
</div>
<script>
    var $j = jQuery.noConflict(); //自定义一个比较短快捷方式
    var payFlag = false;
    $j(function() {
        $.init();
    });

    function pay() {
        var shippingDetail = $('#shipping').val();
        if (shippingDetail == null || shippingDetail.trim() == '') {
            alert('请选择收货信息！');
            return false;
        }
        $('#shippingDetail').val(shippingDetail);
        $('#message').val($('#orderMessage').val());
        if(payFlag) {
            return false;
        }
        payFlag = true;
        $.ajax({
            type: 'post',
            url: '/rest/front/submitOrder',
            data:  $('#orderForm').serialize(),
            cache: false,
            dataType: "json",
            async: true,
            success: function (data) {
                if (data) {
                    if (data.code == '200') {
                        $.ajax({
                            type: 'post',
                            url: '/rest/front/payNow',
                            data: {orderNum: data.msg},
                            cache: false,
                            dataType: "json",
                            async: true,
                            success: function (data1) {
                                if (data1) {
                                    if (data1.code == '200') {
                                        alert("支付成功")
                                        payFlag = true;
                                        window.location.href = '<%=path%>/rest/front/orderDetail?orderNum='+data1.msg
                                    } else if (data1.code == '401') {
                                        payFlag = false;
                                        $.popup('.popup-login');
                                        //弹出登录
                                    } else {
                                        alert(data1.msg);
                                        payFlag = false;
                                    }
                                }
                            },
                            error: function () {
                                payFlag = false;
                                alert('订单支付失败')
                            }
                        });
                    } else if (data.code == '401') {
                        payFlag = false;
                        $.popup('.popup-login');
                        //弹出登录
                    } else {
                        alert(data.msg);
                        payFlag = false;
                    }
                }
            },
            error: function () {
                payFlag = false;
                alert('订单提交失败')
            }
        });
    }
</script>
</body>
</html>
