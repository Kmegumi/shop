<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>商城</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <%@include file="../../include_front_titile.jsp" %>
</head>
<style>
    .detailRight-row3Left {
        flex: 2;
    }
</style>
<body>
<div class="page-group">
    <div class="page page-current" id='router'>
        <header class="bar bar-nav header-z">
            <h1 class="title">订单详情</h1>
        </header>
        <div class="content">
            <div class="message-wrap">
                <div class="address">
                    <div class="address_s">收件地址：</div>
                    <div class="address_d">${order.shippingDetail}</div>
                </div>
            </div>
            <div class="order-wrap">
                <div class="order" onclick="window.location.href='<%=path%>/rest/front/goods/${order.goods.id}'">
                    <div class="oreder_b">订单编号：</div>
                    <div class="oreder_h">${order.orderNum}</div>
                    <div class="oreder_s">${order.orderStatusEnum.description}</div>
                </div>
                <div class="order-detail">
                    <div class="order-detailLeft"
                         onclick="window.location.href='<%=path%>/rest/front/goods/${order.goods.id}'">
                        <img src="${order.goods.goodsImg}" alt="">
                    </div>
                    <div class="order-detailRight">
                        <div class="detailRight_f"
                             style="font-size: 0.75rem;color: #333;  margin-bottom: 0.4rem;    height: 1rem;"
                             onclick="window.location.href='<%=path%>/rest/front/goods/${order.goods.id}'">
                            <div class="f_left">${order.goods.goodsName}</div>
                            <div class="f_right">￥${order.goodsTotalMoney}</div>
                        </div>
                        <c:if test="${order.orderStatusEnum == 'PAY_WAIT'}">
                            <a href="javascript:void(0);" class="row3-mod row3-mod_r open-about2">
                                取消订单
                            </a>
                            <input class="id" type="hidden" value="${order.id}">
                            <a href="javascript:void(0);" class="row3-mod row3-mod_r open-about">
                                立即付款
                            </a>
                            <input class="money" type="hidden" value="${order.goodsTotalMoney}">
                            <input class="id" type="hidden" value="${order.id}">
                        </c:if>
                        <c:if test="${order.orderStatusEnum == 'OK' or order.orderStatusEnum == 'CLOSE'}">
                            <a href="javascript:void(0);" onclick="goGoodsInfo(${order.goods.id})">
                                <div class="detailRight_s">再次购买</div>
                            </a>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="order-wrap2">
                <div class="order-wrap2_c">
                    <div class="wrap2_left">应付金额</div>
                    <div class="wrap2_right">￥${order.goodsTotalMoney}</div>
                </div>
                <div class="order-wrap2_c">
                    <div class="wrap2_left wrap2_left2">商品价格</div>
                    <div class="wrap2_right wrap2_right2">￥${order.goodsTotalMoney}</div>
                </div>
            </div>
            <div class="order-wrap3">

                <div class="wrap3-row">
                    <div class="wrap3-left">支付金额：</div>
                    <div class="wrap3-right">￥${order.goodsTotalMoney}</div>
                </div>
                <div class="wrap3-row">
                    <div class="wrap3-left">下单时间：</div>
                    <div class="wrap3-right"><script>formatTime('${order.createTime}')</script></div>
                </div>
            </div>
        </div>
    </div>

</div>
<div class="popup popup-about2">
    <input type="hidden" id="closeCause">
    <header class="bar bar-nav"
            style="height: 2.6rem;line-height: 2.6rem;background: #fff;position: initial;  border-bottom: 1px solid #efefef;">
        <a class="button button-link button-nav pull-left" href="#" data-transition='slide-out'
           style="    margin-left: 0.25rem;line-height: 2.5rem;height: 2.6rem;">
            <span class="icon close-popup" style="color: #666; font-size: 1.2rem;">×</span>
        </a>
        <h1 class="title" style="font-size: 0.75rem;color: #333;height: 2.6rem;line-height: 2.6rem;">填写取消原因</h1>
    </header>
    <div class="pay-row2-wrap">
        <div class="pay-row2">取消原因：</div>
        <textarea class="leave" id="cancel" name="cancel" placeholder="取消原因"></textarea>
    </div>
    <a href="javascript:void(0);" onclick="cancelOrder()" class="popup-footer">确认</a>
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

    //付款请求
    $(document).on('click', '.open-about', function () {
        $.ajax({
            type: 'post',
            url: '/rest/front/payNow',
            data: {orderNum: '${order.orderNum}'},
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
    });
    //取消订单
    $(document).on('click', '.open-about2', function () {
        $.popup('.popup-about2');
    });
</script>
<script>
    function goGoodsInfo(id) {
        location.href = "<%=path %>/rest/front/goods/" + id;
    }
    function cancelOrder() {
        swal({
            title: "您确定要取消这条订单!",
            type: "warning",
            showCancelButton: true,
            closeOnConfirm: false,
            cancelButtonText: "取消",
            confirmButtonText: "确定",
            confirmButtonColor: "#ec6c62"
        }, function () {
            $.ajax({
                url: '<%=path %>/rest/front/cancelOrder',
                type: 'post',
                data: {orderId: ${order.id}, cancelCause: $("#cancel").val()},
                success: function (data) {
                    if (data) {
                        if (data.code == '200') {
                            swal("取消成功！", "", "success")
                            $('.confirm').click(function () {   //额外绑定一个事件，当确定执行之后返回成功的页面的确定按钮，点击之后刷新当前页面或者跳转其他页面
                                location.href = "<%=path%>/rest/front/orderDetail?orderNum=${order.orderNum}";
                            });
                            //跳转支付页面
                        }  else {
                            alert(data.msg);
                        }
                    }
                }
            })
        })
    }
</script>
</body>
</html>
