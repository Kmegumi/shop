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
            <%--<a class="icon icon-left pull-left" href="javascript:void(0);" onclick="window.location.href='<%=path%>/rest/front/goodsList?columnId=0'"></a>--%>
            <h1 class="title">商品详情</h1>
        </header>
        <%--<div class="wait" style="z-index:999"></div>--%>
        <div class="content">
            <div class="swiper-container" data-space-between='0'>
                <div class="swiper-wrapper">
                    <div class="swiper-slide">
                        <img src="${goods.goodsImg}" alt="">
                    </div>
                </div>
            </div>
            <div class="item-detail_m1">
                <div class="m-row">${goods.goodsName}</div>
                <div class="m-row2">${goods.goodsIntro}</div>
                <!--引用首页样式开始-->
                <div class="show-introduce3 row no-gutter">
                    <div class="col-50">
                        <em></em><i style="font-size: xx-small">￥</i><i>${goods.goodsPrice}</i><span></span>
                    </div>
                    <div class="col-50" style="text-align: right;margin-top: 0.2rem;">
                        <div class="item-count"><em></em></div>
                    </div>
                </div>
                <!--引用首页样式结束-->
            </div>
            <div class="row no-gutter row-change2">商品详情</div>
            <div class="show-img" id="detail">

            </div>
        </div>
        <div class="footer">
            <div class="footer-col">
                <img src="<%=path %>/static/front/img/back.png" onclick="window.location.href='<%=path %>/rest/front/goodsList?columnId=0'">
                <img id="collectImg" <c:if test="${collect}">src="<%=path %>/static/front/img/collect.png"</c:if> <c:if test="${!collect}">src="<%=path %>/static/front/img/noCollect.png"</c:if> onclick="goodsCollect()" >
            </div>
            <c:if test="${sellOut}">
                <div class="footer-col3" style="line-height: 2rem;font-size: 0.8rem;">
                    商品已售罄
                </div>
            </c:if>
            <c:if test="${!startFlag}">
                <div class="footer-col3 change" data-type="Team">
                    <div class="col2_t">距离正式开团时间:</div>
                    <div class="col2_b" id="startTime" v-cloak style="color:#fbdc14;">{{timeMessage}}</div>
                </div>
                <div class="footer-col3 open-about3 change" data-type="Team" style="line-height: 2rem;font-size: 0.8rem;display: none;">
                    立即购买
                </div>
            </c:if>
            <c:if test="${startFlag}">
                <div class="footer-col3 open-about3" data-type="Team" style="line-height: 2rem;font-size: 0.8rem;">
                    立即购买
                </div>
            </c:if>
        </div>
    </div>
    <input type="hidden" id="collectStatus" value="${collect}" />
    <%@include file="specification.jsp"%>
    <%@include file="../login/_login.jsp"%>
</div>
</body>
<script type='text/javascript' src='<%=path %>/static/front/js/swiper.min.js' charset='utf-8'></script>
<script>
    var systemTime = ${time};
    setInterval(function () {
        systemTime = systemTime + 1000;
    },999)
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        paginationClickable: true,
        autoplay : 3000,
    });
    <c:choose>
        <c:when test="${!startFlag}">
            var teamStartTime = ${startTime};
            var startTime = new Vue({
                el: '#startTime',
                data: {
                    timeMessage: getTeamTime(teamStartTime)
                },
                methods: {
                    startAway: function () {
                        var message = getTeamTime(teamStartTime);
                        document.getElementById('startTime').innerText = message;
                        if (message == '已结束') {
                            return true;
                        } else {
                            return false;
                        }
                    }
                },
                created() {
                    var time = setInterval(function () {
                        if (startTime.startAway()) {
                            clearInterval(time);
                            $('.change').toggle();
                        }
                    },999)
                }
            })
        </c:when>
    </c:choose>
    var collect = '<%=path %>/static/front/img/collect.png';
    var noCollect = '<%=path %>/static/front/img/noCollect.png';
    var $j = jQuery.noConflict(); //自定义一个比较短快捷方式
    $j(function() {
        $.init();
        document.getElementById('detail').innerHTML = decodeURIComponent('${goods.encoderGoodsInfo}');
    })
    $(document).on('click','.open-about4', function () {
        $.popup('.popup-about4');
    });
    function getTeamTime(timeLong) {
        var time = '';
        var nowTime = systemTime;//new Date().getTime();
        var limit = timeLong - nowTime;
        if (limit <= 0){
            return '已结束';
        }
        if (limit > 86399999) {
            var day = parseInt(limit/86400000);
            time = day + '天';
            limit = limit % 86400000;
        }
        if (limit > 3599999) {
            var hour = parseInt(limit/3600000);
            if (hour < 10) {
                time += '0';
            }
            time += hour;
            time += ":";
            limit  = limit % 3600000;
        } else {
            time += "00:";
        }
        if (limit > 59999) {
            var min = parseInt(limit/60000);
            if (min < 10) {
                time += '0';
            }
            time += min;
            time += ":";
            limit = limit % 60000;
        } else {
            time + "00:";
        }
        if (limit > 1000) {
            var s = parseInt(limit/1000);
            if (s < 10) {
                time += '0';
            }
            time += s;
        } else {
            time += "00";
        }
        return time;
    }



    function goodsCollect() {
        var type = document.getElementById('collectStatus').value;
        if(type == null || type == ''){
            type = true;
        } else if(type == 'true') {
            type = false;
        }else {
            type = true;
        }
        $.ajax({
            type: 'post',
            url: '/rest/front/goodsCollect',
            data: {id:${goods.id},type:type},
            cache: true,
            dataType: "json",
            async: true,
            success: function (data) {
                if (data) {
                    if (data.code == '200') {
                        $('#collectImg').attr('src', collect);
                        document.getElementById('collectStatus').value = 'true';
                        //收藏成功
                    } else if (data.code == '201') {
                        $('#collectImg').attr('src', noCollect);
                        document.getElementById('collectStatus').value = 'false';
                        //取消收藏成功
                    } else if (data.code == '401') {
                        alert(data.msg)
                        $.popup('.popup-login');
                    } else {
                        alert(data.msg);
                    }
                }
            },
            error: function () {
                alert('修改收藏失败，请检查你的网络')
            }
        });
    }

    function loginSuccess() {
        $('#payForm').submit();
    }



</script>
</html>
