<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>商城</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="/favicon.ico">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" href="<%=path %>/static/front/css/swiper.min.css">
    <link rel="stylesheet" href="<%=path %>/static/front/css/main.css">
    <link rel="stylesheet" href="//g.alicdn.com/msui/sm/0.6.2/css/sm-extend.min.css">
    <link rel="stylesheet" href="//g.alicdn.com/msui/sm/0.6.2/css/sm.min.css">
    <script type='text/javascript' src='<%=path %>/static/front/js/swiper.min.js' charset='utf-8'></script>
    <script type='text/javascript' src='//g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
    <script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm.min.js' charset='utf-8'></script>
    <script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm-extend.min.js' charset='utf-8'></script>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
    <style>
        html, body {
            position: relative;
            /*height: 100%;*/
            overflow: inherit;
            overflow-x: hidden;
        }
        body {
            background: #eee;
            font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
            font-size: 14px;
            color:#000;
            margin: 0;
            padding: 0;
        }
        .swiper-container {
            width: 100%;
        }
        .swiper-slide img{  width: 100%;  }
        .swiper-slide {
            background-position: center;
            background-size: cover;
        }
        .login-screen, .popup {
            position: fixed;
        }
        .swiper-container2 .swiper-slide img{
            -webkit-border-radius: 4px;-moz-border-radius: 4px; -o-border-radius: 4px; -ms-border-radius: 4px; border-radius: 4px;
        }
    </style>
</head>
<body>
<header class="bar bar-nav">
    <h1 class="title">商城</h1>
</header>
<div class="swiper-container" style="margin-top: 2.2rem">
    <div class="swiper-wrapper">
        <c:forEach items="${bannerList}" var="banner">
            <div class="swiper-slide" >
                <img src="${banner.url}" alt="" >
            </div>
        </c:forEach>
    </div>
</div>
<nav class="bar bar-tab" style="position: inherit;margin-top: -30px;height: 4.4rem;">
    <c:forEach items="${columnList}" var="column">
        <a class="tab-item item-adjust" href="<%=path%>/rest/front/goodsList?columnId=${column.id}">
            <span class="icon"><img src="http://upload.shands.cn/pinmall/GOODS_COLUMN/1707211415125659.png" /></span>
            <span class="tab-label label-adjust">${column.columnName}</span>
        </a>
    </c:forEach>
</nav>
<div class="row home-title">
    <div class="col-50 home-titleLeft">热门推荐</div>
</div>
<div class="recommend-wrap">
    <c:forEach items="${goodsRecommendList}" var="recommend">
        <div class="recommend-details" onclick="window.location.href='<%=path%>/rest/front/goods/${recommend.id}'">
            <div class="showImg-wrap"><img src="${recommend.goods.goodsImg}" style="border-radius: 4px;" alt="展示图1"></div>
            <div class="show-introduce">${recommend.goods.goodsName}</div>
            <div class="show-introduce2">${recommend.goods.goodsIntro}</div>
            <div class="show-introduce3 row no-gutter">
                <div class="col-50">
                    <em></em><i style="font-size: xx-small">￥</i><i>${recommend.goods.goodsPrice}</i><span></span>
                </div>
                <div class="col-50" style="text-align: right;margin-top: 0.2rem;">
                    <a href="javascript:void(0)" style=" background: #4C4C4C">购买</a>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
<nav class="bar bar-tab footer-bar" style="    position: fixed;height: 2.65rem;">
    <a class="tab-item external active" href="#">
        <span>
            <img src="<%=path %>/static/front/img/Icon_Tab_Bar_Home_Active.svg" />
        </span>
        <span class="tab-label"  style="color: #fa725a">首页</span>
    </a>
    <a class="tab-item external" href="<%=path%>/rest/front/goodsList">
        <span>
            <img src="<%=path %>/static/front/img/Icon_Tabbar_New_Arrival_Inactive.svg" />
        </span>
        <span class="tab-label">商品</span>
    </a>
    <a class="tab-item external" id="open-login-trade" href="javascript:void(0)">
        <span>
            <img src="<%=path %>/static/front/img/Icon_TabBar_Orderlist_Inactive.svg" />
        </span>
        <span class="tab-label">订单</span>
    </a>
    <a class="tab-item external" id="open-login-personal" href="javascript:void(0)">
        <span>
            <img src="<%=path %>/static/front/img/Icon_Tab_Bar_Person_Center_Active.svg" />
        </span>
        <span class="tab-label">个人中心</span>
    </a>
</nav>
<script type='text/javascript' src='<%=path %>/static/front/js/swiper.min.js' charset='utf-8'></script>
<script type='text/javascript' src='http://a.tbcdn.cn/libs/jquery/1.7.1/jquery.js' charset='utf-8'></script>
<script>
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        paginationClickable: true,
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
        spaceBetween: 30,
//        effect: 'slide',
        effect: 'fade',
        autoplay : 3000,
        autoplayDisableOnInteraction : false,
    });
    var swiper2 = new Swiper('.swiper-container2', {
        pagination: '.swiper-pagination',
        slidesPerView: 3,
        paginationClickable: true,
        spaceBetween: 16,
        freeMode: true,
    });
    var $j = jQuery.noConflict(); //自定义一个比较短快捷方式
    $j(function() {
        $.init();
    })
</script>
</body>
</html>
