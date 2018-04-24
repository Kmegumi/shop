<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>商城</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <%@include file="../include_front_titile.jsp" %>
    <style>
        ::-webkit-input-placeholder { /* WebKit browsers */
            color: #CCC;
        }
        :-moz-placeholder { /* Mozilla Firefox 4 to 18 */
            color: #CCC;
        }
        ::-moz-placeholder { /* Mozilla Firefox 19+ */
            text-indent: 0.75rem;
        }
        :-ms-input-placeholder { /* Internet Explorer 10+ */
            color: #CCC;
        }
    </style>
</head>
<body style="overflow: initial;">
<div class="page-group">
    <div class="page page-current" id='router'>
        <header class="bar bar-nav header-z">
            <a href="javascript:void(0);" onclick="history.go(-1)" class="icon icon-left pull-left"></a>
            <h1 class="title">个人中心</h1>
        </header>
        <div class="content">
            <div class="personal-wrap">
                <div class="personal-icon">
                    <c:if test="${not empty customer.headImg and customer.headImg != ''}">
                        <img src="${customer.headImg}" alt=""></c:if>
                    <c:if test="${empty customer.headImg or customer.headImg == ''}">
                        <img src="<%=path%>/static/front/img/Icon_Label_Avator.png" alt="">
                    </c:if>
                </div>
                <div class="personal-row">${customer.mobile}</div>
                <div class="personal-row2" onclick="goUserInfo()">个人信息</div>
            </div>
            <a href="javascript:void(0);" onclick="goOrderList()" class="row no-gutter personal-mod">
                <div class="col-50 mod-left">我的订单</div>
                <div class="col-50 mod-right">
                    <img src="<%=path%>/static/front/img/Icon_Label_Forward_Primary.png" alt="">
                </div>
            </a>
            <nav class="bar bar-tab bar-change">
                <a class="tab-item external" href="<%=path %>/rest/front/orderList">
                    <span><img src="<%=path%>/static/front/img/Icon_Bubble_Primary.png" alt=""></span>
                    <span class="tab-label">全部</span>
                </a>
                <a class="tab-item external active" href="<%=path %>/rest/front/orderList?orderStatus=PAY_WAIT">
                    <span><img src="<%=path%>/static/front/img/Icon_Wallet_Primary.png" alt=""></span>
                    <span class="tab-label">待付款</span>
                </a>
                <a class="tab-item external" href="<%=path %>/rest/front/orderList?orderStatus=SEND_WAIT">
                    <span><img src="<%=path%>/static/front/img/Icon_Package_Primary.png" alt=""></span>
                    <span class="tab-label">待发货</span>
                </a>
                <a class="tab-item external" href="<%=path %>/rest/front/orderList?orderStatus=OK">
                    <span><img src="<%=path%>/static/front/img/Icon_Shipping_Primary.png" alt=""></span>
                    <span class="tab-label">完成</span>
                </a>
            </nav>
            <div class="personal-mod2">
                <a href="javascript:void(0);" onclick="goCollect()" class="row no-gutter personal-mod">
                    <div class="col-50 mod-left">我的收藏</div>
                    <div class="col-50 mod-right">
                        <img src="<%=path%>/static/front/img/Icon_Label_Forward_Primary.png" alt="">
                    </div>
                </a>
            </div>
            <nav class="bar bar-tab footer-bar" style="    position: fixed;height: 2.65rem;">
                <a class="tab-item external active" href="<%=path%>/">
                    <span>
                        <img src="<%=path%>/static/front/img/Icon_Tab_Bar_Home_Inactive.svg" alt="">
                        <img src=".<%=path%>/static/front/img/Icon_Tab_Bar_Home_Active.svg" alt="">
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
                       <img src="<%=path%>/static/front/img/Icon_TabBar_Orderlist_Inactive.svg" alt="">
                       <img src="<%=path%>/static/front/img/Icon_TabBar_List_Active.svg" alt="">
                    </span>
                    <span class="tab-label">订单</span>
                </a>
                <a class="tab-item external" href="<%=path%>/rest/front/personal">
                    <span>
                      <img src="<%=path%>/static/front/img/Icon_Tab_Bar_Person_Center_Inactive.svg" alt="">
                    </span>
                    <span class="tab-label" style="color: #fa725a">个人中心</span>
                </a>
            </nav>
        </div>
    </div>
    <%@include file="login/_login.jsp" %>
</div>
<script>
    var $j = jQuery.noConflict(); //自定义一个比较短快捷方式
    $j(function () {
        $.init();
    })
    $j(".tab-item").click(function () {
        $j(this).children().children("img:nth-child(2)").show().siblings("img").hide();
        $j(this).children(".tab-label").css("color", "#FA725A")
        $j(this).siblings(".tab-item").children().children("img:first-child").show().siblings("img:nth-child(2)").hide();
        $j(this).siblings(".tab-item").children(".tab-label").css("color", "#333")
    })

    function goOrderList() {
        location.href = "<%=path %>/rest/front/orderList";
    }
    function goUserInfo() {
        location.href = "<%=path %>/rest/front/userInfo";
    }
    function goCollect() {
        location.href = "<%=path %>/rest/front/collectList";
    }
    $(document).on('click', '.open-login', function () {
        $.popup('.popup-login');
    });
    function loginSuccess() {
        location.href = "<%=path %>/rest/front/userInfo";
    }
</script>
</body>
</html>
