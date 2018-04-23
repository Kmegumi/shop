<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../../include_front_titile.jsp"%>
    <link rel="stylesheet" href="<%=path %>/static/front/css/jquery.spinner.css">
    <link rel="stylesheet" href="<%=path %>/static/front/css/activityMain.css">
    <script src="<%=path%>/static/js/vue.js"></script>
    <style>
        .swiper-container{ padding-bottom: 0;}
        .swiper-slide img{  width: 100%;  height: 10.55rem;  }
        .m3_w{padding: 0.25rem;}
        .popup-about4 p{padding: 0rem 0.75rem;font-size: 0.65rem;color: #666;letter-spacing: 0.02rem;line-height: 1.5rem;}
        .popup-about4 p>em{font-weight: 600;text-align: center;display: block;font-size: 0.75rem;}
        .popup-about4 p>i{font-weight: 600}
        .footer-col4{font-size: 0.8rem;  -prefix-box-flex: 1;-webkit-box-flex: 1;-webkit-flex: 1;-moz-box-flex: 1;-ms-flex: 1;flex: 1;  background: #4C4C4C;  color: #fff;  text-align: center;  line-height: 2rem;  padding: 0.25rem 0;}
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
                        <em>1</em>人团<i style="font-size: xx-small">￥</i><i>1988.00</i>
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
                <div class="m2-row2">1人开团，即刻购买</div>
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
        <div class="footer">
            <div class="footer-col3" style="line-height: 2rem;font-size: 0.8rem;" onclick="checkOrder()">
                立即购买
            </div>
        </div>
        <div class="pop_up2 active" style="display: none;"></div>
        <div class="pop_up3 active" style="display: none;">
            <div class="pop_up-section2">
                <div class="pop_up2-row" >
                    <div style="width: 212px;margin:0 auto;text-align: center;">
                        报名参加“祺行梦想家”，完成任务获得更多奖励
                        <p style="font-size: 1rem; margin-top: 10px;;">是否报名？</p>
                    </div>
                </div>
                <div class="pop_up2-row2">
                    <div class="pop_up2-row2_k" style="border-right: 1px solid rgba(0,0,0,0.2);" data-type="1">放弃</div>
                    <div class="pop_up2-row2_k" style="color: #B39B6B;" data-type="0">好</div>
                </div>
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
    <%@include file="../login/_login.jsp"%>
    <form id="payForm" method="GET" action="/rest/front/checkOrder" style="display: none">
        <input name="goodsId" value="${goodsId}">
    </form>
</div>
</body>
<script type='text/javascript' src='<%=path %>/static/front/js/swiper.min.js' charset='utf-8'></script>
<script>
    var $j = jQuery.noConflict(); //自定义一个比较短快捷方式
    $j(function() {
        $.init();
        <c:if test="${detail.goodsDetail != null}">
        var detail ='${detail.goodsDetail}'
        document.getElementById('detail').innerHTML = decodeURI(detail);
        </c:if>
        var swiper = new Swiper('.swiper-container', {
            pagination: '.swiper-pagination',
            paginationClickable: true,
            autoplay : 3000,
        });
    })
    $(document).on('click','.open-about4', function () {
        $.popup('.popup-about4');
    });

    <c:if test="${isWX}">
    wx.config({
        debug: false,
        appId: '${signMap.get("appid")}',
        timestamp: ${signMap.get("timestamp")},
        nonceStr: '${signMap.get("nonceStr")}',
        signature: '${signMap.get("signature")}',
        jsApiList: [
            'onMenuShareTimeline',
            'onMenuShareAppMessage',
            'onMenuShareQQ',
            'onMenuShareWeibo',
            'onMenuShareQZone'
        ]
    });

    wx.ready(function(){
        // 2.1 监听“分享给朋友”，按钮点击、自定义分享内容及分享结果接口
        wx.onMenuShareAppMessage({
            title: '爱拼才会赢，${detail.name}，开元酒店集团拼购商城',
            desc: '爱拼才会赢，开元酒店集团拼购商城',
            link: 'http://pg.shands.cn/rest/front/goods/${detail.id}?to=wx',
            imgUrl: '${detail.img}',
            trigger: function (res) {

            },
            success: function (res) {
            },
            cancel: function (res) {
            },
            fail: function (res) {
            }
        });

        // 2.2 监听“分享到朋友圈”按钮点击、自定义分享内容及分享结果接口
        wx.onMenuShareTimeline({
            title: '爱拼才会赢，${detail.name}，开元酒店集团拼购商城',
            link: 'http://pg.shands.cn/rest/front/goods/${detail.id}?to=wx',
            imgUrl: '${detail.img}',
            trigger: function (res) {
                // 不要尝试在trigger中使用ajax异步请求修改本次分享的内容，因为客户端分享操作是一个同步操作，这时候使用ajax的回包会还没有返回
                console.log('用户点击分享到朋友圈');
            },
            success: function (res) {
                console.log('已分享');
            },
            cancel: function (res) {
                console.log('已取消');
            },
            fail: function (res) {
                console.log(JSON.stringify(res));
            }
        });
    });

    </c:if>

    function loginSuccess() {
        $.ajax({
            type: 'post',
            url: '/rest/front/checkJoinActivity',
            data: {},
            cache: true,
            dataType: "json",
            async: true,
            success: function (data) {
                if (data) {
                    if (data.code == '1000') {
                        $('#payForm').submit();
                    } else if (data.code == '1001') {
                        //弹出报名提示
                        $('.active').show();
                    } else if (data.code == '1100') {
                        $.popup('.popup-login');
                        //弹出登录
                    }
                }
            },
            error: function () {
                alert('规格加载失败,请刷新页面')
            }
        });
    }

    function checkOrder() {
        $.ajax({
            type: 'post',
            url: '/rest/front/checkLogin',
            data: {},
            cache: true,
            dataType: "json",
            async: true,
            success: function (data) {
                if (data) {
                    if (data.code == '1000') {
                        $.ajax({
                            type: 'post',
                            url: '/rest/front/checkJoinActivity',
                            data: {},
                            cache: true,
                            dataType: "json",
                            async: true,
                            success: function (data) {
                                if (data) {
                                    if (data.code == '1000') {
                                        //已经提示或已经报名
                                        $('#payForm').submit();
                                    } else if (data.code == '1001') {
                                        //弹出报名提示
                                        $('.active').show();
                                    } else if (data.code == '1100') {
                                        $.popup('.popup-login');
                                        //弹出登录
                                    }
                                }
                            },
                            error: function () {
                                alert('网络超时，请重试')
                            }
                        });
                    } else if (data.code == '1100') {
                        $.popup('.popup-login');
                        //弹出登录
                    } else {
                        alert(data.code);
                    }
                }
            },
            error: function () {
                alert('网络超时，请重试')
            }
        });
    }

    $('.pop_up2-row2_k').click(function () {
        $('.active').hide();
        var type = $(this).attr('data-type');
        if (type == 0) {
            window.location.href = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx9fd031cb2b974296&redirect_uri=http%3a%2f%2fwww.kaiyuanhotels.com.cn%2ffront%2fpublicOAuth.htm%3fextenalType%3dweixin%26urlType%3d1%26redirectUrl%3d%252Fm%252FbrandActivityTwo%252FtoSelect.htm%253FpgOrderId%253D${goodsId}&response_type=code&scope=snsapi_base&state=123#wechat_redirect';
        } else {
            $('#payForm').submit();
        }
    })


</script>
<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?05aec8ab7e2a14e7e78769bd4523db30";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>
</html>