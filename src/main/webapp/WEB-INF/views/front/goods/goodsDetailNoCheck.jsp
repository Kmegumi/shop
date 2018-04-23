<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../include_front_titile.jsp"%>
    <link rel="stylesheet" href="<%=path %>/static/front/css/jquery.spinner.css">
    <script src="<%=path%>/static/js/vue.js"></script>
    <style>
        .swiper-container{ padding-bottom: 0;}
        .swiper-slide img{  width: 100%;  height: 10.55rem;  }
        .m3_w{padding: 0.25rem;}
        .popup-about4 p{padding: 0rem 0.75rem;font-size: 0.65rem;color: #666;letter-spacing: 0.02rem;line-height: 1.5rem;}
        .popup-about4 p>em{font-weight: 600;text-align: center;display: block;font-size: 0.75rem;}
        .popup-about4 p>i{font-weight: 600}
        .footer-col4{font-size: 0.8rem;  -prefix-box-flex: 1;-webkit-box-flex: 1;-webkit-flex: 1;-moz-box-flex: 1;-ms-flex: 1;flex: 1;  background: #4C4C4C;  color: #fff;  text-align: center;  line-height: 2rem;  padding: 0.25rem 0;}
        [v-cloak] {
            display: none;
        }
    </style>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
</head>
<body>
<div class="page-group">
    <div class="page page-current" id='router'>
        <header class="bar bar-nav header-z">
            <a class="icon icon-left pull-left" href="javascript:void(0);" onclick="window.location.href='<%=path%>/rest/front/goodsList?columnId=0'"></a>
            <h1 class="title">商品详情</h1>
        </header>
        <div class="wait" style="z-index:999"></div>
        <div class="content">
            <div class="swiper-container" data-space-between='0'>
                <div class="swiper-wrapper">
                    <c:forEach items="${detail.banner}" var="banner">
                        <div class="swiper-slide">
                            <img src="${banner}" alt="">
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="item-detail_m1">
                <div class="m-row">${detail.name}</div>
                <div class="m-row2">${detail.intro}</div>
                <!--引用首页样式开始-->
                <div class="show-introduce3 row no-gutter">
                    <div class="col-50">
                        <em>${detail.teamNum}</em>人团<i style="font-size: xx-small">￥</i><i>${detail.teamPrice}</i><span>￥${detail.originalPrice}</span>
                    </div>
                    <div class="col-50" style="text-align: right;margin-top: 0.2rem;">
                        <div class="item-count">已团&nbsp;<em>${detail.sellNum}</em>份</div>
                    </div>
                </div>
                <!--引用首页样式结束-->
            </div>
            <div class="item-detail_m2">
                <div class="row no-gutter">
                    <div class="col-50 m2-rowLeft">拼团玩法</div>
                    <a href="#" class="col-50 m2-rowRight open-about4">规则说明&gt;</a>
                </div>
                <div class="m2-row2">开团并邀请${detail.teamNum - 1}人参团，${detail.teamTime}小时内人数不足自动退款</div>
            </div>
            <div class="item-detail_m3 no-gutter">
                <c:forEach items="${detail.server}" var="server">
                    <div class="m3_w">${server}</div>
                </c:forEach>
            </div>
            <div class="row no-gutter row-change2">商品详情</div>
            <div class="show-img" id="detail">
            </div>
        </div>
    </div>
    <div class="popup popup-about4">
        <header class="bar bar-nav" style="height: 2.6rem;line-height: 2.6rem;background: #fff;position: initial;">
            <a class="button button-link button-nav pull-left" href="#" data-transition='slide-out' style="    margin-left: 0.25rem;line-height: 2.5rem;height: 2.6rem;">
                <span class="icon close-popup" style="color: #666; font-size: 1.2rem;">×</span>
            </a>
        </header>
        <p>
            <em>拼团活动规则</em>
            <i>拼团流程：</i><br>
            ①选择心仪商品——②支付开团或参团——③等待好友参团——④达到人数拼团成功<br>
            <i>拼团说明：</i><br>
            ⑴ 选择商品开团：选择拼团商品下单，团长完成支付后，团即可开启。<br>
            ⑵ 团长：开团且该团第一位支付成功的人。<br>
            ⑶ 参团人员：通过团长邀请购买该商品的成员即为参团人员。<br>
            ⑷ 拼团成功：从团长开团团期内找到相应人员参团，则拼团成功。<br>
            ⑸ 拼团失败：从团长开团团期内未能找到相应开团人数的好友参团，则该团失败。系统会在1-2个工作日内自动原路退款。</p>
    </div>
</div>
</body>
<script type='text/javascript' src='<%=path %>/static/front/js/swiper.min.js' charset='utf-8'></script>
<script>
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        paginationClickable: true,
        autoplay : 3000,
    });
    var $j = jQuery.noConflict(); //自定义一个比较短快捷方式
    $j(function() {
        $.init();
        <c:if test="${detail.goodsDetail != null}">
        var detail ='${detail.goodsDetail}'
        document.getElementById('detail').innerHTML = decodeURI(detail);
        </c:if>
    })
    $(document).on('click','.open-about4', function () {
        $.popup('.popup-about4');
    });
</script>
</html>
