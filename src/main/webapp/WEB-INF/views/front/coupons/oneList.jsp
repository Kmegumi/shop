<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%String path=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
    <title>拼购商城</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <link rel="stylesheet" type="text/css" href="<%=path%>/static/front/css/swiper-3.3.1.min.css"/>
    <link rel="stylesheet" type="text/css" href="<%=path%>/static/front/css/coupons.css"/>
    <style type="text/css">
        html, body{height: 100%;font-family: "微软雅黑";}
        *{margin: 0;padding: 0;box-sizing: border-box;}
        a {color: #428bca;}
        a:focus {outline: thin dotted;outline: 5px auto -webkit-focus-ring-color;outline-offset: -2px;}
        .a{text-align:center;line-height: 40px;position: fixed;top: 0;left: 0;width: 100%;z-index: 10;border-bottom: 1px #ccc solid; background: #f50;color: #fff;}
        .tab{display:-webkit-box;  display:-moz-box;  display:-webkit-flex;  display:-moz-flex;  display:-ms-flexbox;  display: flex;  line-height: 40px;position: static;top: 40px;width: 100%;z-index: 10;border-bottom: 1px #ccc solid;}
        .tab a{background: #fff;text-align: center;color:#666;font-size: 14px;}
        .tab .active{border-bottom: 2px #FA725A solid; color: #FA725A;display: inline-block;}
        .panel{margin: 0;}
        .refreshtip {position: absolute;left: 0;width: 100%;margin: 10px 0;text-align: center;color: #999;}
        .swiper-container{overflow: visible;}
        .loadtip { display: block;width: 100%;line-height: 40px; height: 40px;text-align: center;color: #999;border-top: 1px solid #ddd;}
        .swiper-container, .w{height: calc(100vh - 120px);}
        .swiper-slide{height: auto;}
        .text-center{text-align: center;}
        .list-group{padding-left: 0;margin-bottom: 20px;}
        .list-group-item{    position: relative; display: block;padding: 10px 15px;margin-bottom: -1px;background-color: #fff;}
        .list-group-item:first-child {border-top-left-radius: 4px;border-top-right-radius: 4px;}
        .newslist01 li{    position: relative;margin-bottom: 8px;}
        .newslist01 li>img{    width: 100%;  display: block;  height: 144px;  -webkit-border-radius: 5px;  -o-border-radius:5px;  -ms-border-radius: 5px;  -moz-border-radius: 5px;  border-radius: 5px;}
        .newslist01 li>a{  position: absolute;  top: 30px;  left: 21px;  right: 21px;  bottom: 6px;  }
        .newslist01 li>a.examine{  font-family: PingFangSC-Light;  font-size: 13px;  color: #FA725A;  padding: 4px 6px;  background: #FFD5CC;  -webkit-border-radius: 2px;  -o-border-radius:2px;  -ms-border-radius: 2px;  -moz-border-radius: 2px;  border-radius: 2px;  display: block;  position: absolute;  top: 30px;  left: auto;  right: 21px;  bottom: auto;  }
        .newslist01 li>a>em{    font-family: PingFangSC-Light;  font-size: 22px;  color: #FFFFFF;  display: block;  line-height: 22px;  margin-bottom: 4px;}
        .newslist01 li>a>i{  filter:alpha(opacity=80);  -moz-opacity:0.8;  -khtml-opacity:0.8;  opacity: 0.8;  font-family: SFUIText-Light;  font-size: 13px;  color: #FFFFFF;  line-height: 16px;}
        .newslist01 li>a>p{  filter:alpha(opacity=80);  -moz-opacity:0.8;  -khtml-opacity:0.8;  opacity: 0.8;  font-family: PingFangSC-Light;  font-size: 15px;  color: #FFFFFF;  line-height: 18px;  position: absolute;  bottom: 0;  overflow: hidden;  width: 100%;  text-overflow: ellipsis;  white-space: nowrap;}
        .newslist01 li>a>p>em{  filter:alpha(opacity=80);  -moz-opacity:0.8;  -khtml-opacity:0.8;  opacity: 0.8;  font-family: PingFangSC-Regular;  font-size: 13px;  color: #FFFFFF;  float: right;  }
        .tab_w{    width: 33.3333%;  float: left;  -moz-box-sizing: border-box;  -webkit-box-sizing: border-box;  -o-box-sizing: border-box;  -ms-box-sizing: border-box;  box-sizing: border-box;  padding-left: 10%;  position: relative;}
    </style>
</head>
<body class="padd_40">
<div class="tab">
    <div class="tab_w">
        <a class="active" href="javascript:void (0);" data-type="ALL">全部</a>
    </div>
    <div class="tab_w">
        <a href="javascript:void (0);" data-type="UNUSED">未使用</a>
    </div>
    <div class="tab_w">
        <a href="javascript:void (0);" data-type="USED">已使用</a>
    </div>
</div>
<div class="swiper-container">
    <%--<div class="refreshtip">下拉可以刷新</div>--%>
    <div class="swiper-wrapper w">
        <div class="swiper-slide d">
            <div class="init-loading list-group-item text-center" style="display: none;">下拉可以刷新</div>
            <div class="swiper-container2">
                <div class="swiper-wrapper">
                    <div class="swiper-slide list-group">
                        <div class="list-group-item">
                            <ul class="newslist01" id="ALL">
                                <c:forEach items="${list}" var="coupons">
                                    <li>
                                        <c:choose>
                                            <c:when test="${coupons.voucherStateEnum.equals('NOTCANCELAFTERVERIFICATION')}">
                                                <img src="<%=path%>/static/front/img/Active@2x.png" alt="">
                                                <a href="<%=path%>/rest/front/couponsDetail/${coupons.voucherNum}" style="width: 300px;">
                                                    <em>${coupons.goodName}</em>
                                                    <i>${coupons.voucherNum}</i><br/>
                                                    <i>${fn:substring(coupons.validStartDate, 0, 10)} - ${fn:substring(coupons.validEndDate, 0, 10)} 有效</i>
                                                    <p>${coupons.activityName}</p>
                                                </a>
                                                <c:if test="${coupons.isIfBookVoucher()}"><a href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx9fd031cb2b974296&redirect_uri=http%3a%2f%2fwww.kaiyuanhotels.com.cn%2ffront%2fpublicOAuth.htm%3fextenalType%3dweixin%26urlType%3d0%26redirectUrl%3d%252Fm%252Fhotel%252FtoVoucherOrder.htm%253FvoucherNum%253D${coupons.voucherNum}&response_type=code&scope=snsapi_base&state=123#wechat_redirec" class="examine">立即预约</a></c:if>
                                            </c:when>
                                            <c:when test="${coupons.voucherStateEnum.equals('EXPIRED')}">
                                                <img src="<%=path%>/static/front/img/Inactive@2x.png" alt="">
                                                <a href="<%=path%>/rest/front/couponsDetail/${coupons.voucherNum}" style="width: 300px;">
                                                    <em>${coupons.goodName}</em>
                                                    <i>${coupons.voucherNum}</i><br/>
                                                    <i>${fn:substring(coupons.validStartDate, 0, 10)} - ${fn:substring(coupons.validEndDate, 0, 10)}有效</i>
                                                    <p>${coupons.activityName} <em>已过期</em></p>
                                                </a>
                                            </c:when>
                                            <c:when test="${coupons.voucherStateEnum.equals('CANCELAFTERVERIFICATIONFINISH')}">
                                                <img src="<%=path%>/static/front/img/Inactive@2x.png" alt="">
                                                <a href="<%=path%>/rest/front/couponsDetail/${coupons.voucherNum}" style="width: 300px;">
                                                    <em>${coupons.goodName}</em>
                                                    <i>${coupons.voucherNum}</i><br/>
                                                    <i>${fn:substring(coupons.validStartDate, 0, 10)} - ${fn:substring(coupons.validEndDate, 0, 10)}有效</i>
                                                    <p>${coupons.activityName} <em>已核销</em></p>
                                                </a>
                                            </c:when>
                                            <c:when test="${coupons.voucherStateEnum.equals('STORAGEFINISH')}">
                                                <img src="<%=path%>/static/front/img/Inactive@2x.png" alt="">
                                                <a href="<%=path%>/rest/front/couponsDetail/${coupons.voucherNum}" style="width: 300px;">
                                                    <em>${coupons.goodName}</em>
                                                    <i>${coupons.voucherNum}</i><br/>
                                                    <i>${fn:substring(coupons.validStartDate, 0, 10)} - ${fn:substring(coupons.validEndDate, 0, 10)}有效</i>
                                                    <p>${coupons.activityName} <em>已封存</em></p>
                                                </a>
                                            </c:when>
                                            <c:when test="${coupons.voucherStateEnum.equals('FROZEN')}">
                                                <img src="<%=path%>/static/front/img/Inactive@2x.png" alt="">
                                                <a href="<%=path%>/rest/front/couponsDetail/${coupons.voucherNum}" style="width: 300px;">
                                                    <em>${coupons.goodName}</em>
                                                    <i>${coupons.voucherNum}</i><br/>
                                                    <i>${fn:substring(coupons.validStartDate, 0, 10)} - ${fn:substring(coupons.validEndDate, 0, 10)}有效</i>
                                                    <p>${coupons.activityName} <em>已冻结</em></p>
                                                </a>
                                            </c:when>
                                        </c:choose>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                    <div class="swiper-slide list-group">
                        <div class="list-group-item">
                            <ul class="newslist01" id="UNUSED">
                            </ul>
                        </div>
                    </div>
                    <div class="swiper-slide list-group">
                        <div class="list-group-item">
                            <ul class="newslist01" id="USED">
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="loadtip">没有更多啦！</div>
    <div class="swiper-scrollbar"></div>
</div>
<script src="<%=path%>/static/front/js/jquery-2.1.4.min.js" type="text/javascript" charset="utf-8"></script>
<script src="<%=path%>/static/front/js/swiper.jquery.min.js" type="text/javascript" charset="utf-8"></script>
<script language="javascript">
    var mySwiper4 = new Swiper('.swiper-slide',{
        noSwiping : true,
    })
    var mySwiper5 = new Swiper('.tab',{
        noSwiping : true,
    })
    var mySwiper6 = new Swiper('.loadtip',{
        noSwiping : true,
    })
    var mySwiper7 = new Swiper('html',{
        noSwiping : true,
    })
</script>
<script type="text/javascript">
    $(function () {
        mySwiper.update();
    })
    var loadFlag = false;
    var pageNo = 1;
    var oi = 0;
    var mySwiper = new Swiper('.swiper-container',{
        direction: 'vertical',
        scrollbar: '.swiper-scrollbar',
        slidesPerView: 'auto',
        freeMode: true,
        onTouchMove: function(swiper){		//手动滑动中触发
            var _viewHeight = document.getElementsByClassName('swiper-wrapper')[0].offsetHeight;
            var _contentHeight = document.getElementsByClassName('swiper-slide')[0].offsetHeight;
            if(mySwiper.translate < 50 && mySwiper.translate > 0) {
                $(".init-loading").html('下拉刷新...').show();
            }else if(mySwiper.translate > 50 ){
                $(".init-loading").html('释放刷新...').show();
            }
        },
        onTouchEnd: function(swiper) {
            var _viewHeight = document.getElementsByClassName('swiper-wrapper')[0].offsetHeight;
            var _contentHeight = document.getElementsByClassName('swiper-slide')[0].offsetHeight;
            // 上拉加载
            if(mySwiper.translate <= _viewHeight - _contentHeight - 50 && mySwiper.translate < 0) {
                // console.log("已经到达底部！");
                if(loadFlag){
                    $(".loadtip").html('正在加载...');
                }
            }
            // 下拉刷新
            if(mySwiper.translate >= 50) {
                $(".init-loading").html('正在刷新...').show();
                var type = $('.active').attr('data-type');
                $.ajax({
                    type: 'get',
                    url: '<%=path%>/rest/front/couponsListForAsync',
                    data: { voucherTypeEnum:type, pageNo:1, orderId:${orderId} },
                    cache: true,
                    dataType: "html",
                    async: true,
                    beforeSend: function () { },
                    success: function (data) {
                        if (data) {
                            $('#'+type).html(data);
                            $(".refreshtip").show(0);
                            $(".init-loading").html('刷新成功！');
                            setTimeout(function(){
                                $(".init-loading").html('').hide();
                            },800);
                            $(".loadtip").show(0);
                            mySwiper.update();
                        }
                    },
                    error: function () { }
                });
            }else if(mySwiper.translate >= 0 && mySwiper.translate < 50){
                $(".init-loading").html('').hide();
            }
            return false;
        }
    });
    var mySwiper2 = new Swiper('.swiper-container2',{
        onTransitionEnd: function(swiper){
            $('.w').css('transform', 'translate3d(0px, 0px, 0px)')
            $('.swiper-container2 .swiper-slide-active').css('height','auto').siblings('.swiper-slide').css('height','0px');
            mySwiper.update();
            $('.tab .tab_w a').eq(mySwiper2.activeIndex).addClass('active').siblings(".tab .tab_w a").removeClass('active');
        }

    });
    $('.tab .tab_w').click(function(){
        $(this).parents().find(".tab .tab_w a").removeClass("active");
        $(this).children('.tab .tab_w a').addClass('active');
        mySwiper2.slideTo($(this).index(), 500, false);
        $('.w').css('transform', 'translate3d(0px, 0px, 0px)')
        $('.swiper-container2 .swiper-slide-active').css('height','auto').siblings('.swiper-slide').css('height','0px');
        var type = $('.active').attr('data-type');
        $.ajax({
            type: 'get',
            url: '<%=path%>/rest/front/couponsListForAsync',
            data: { voucherTypeEnum:type, pageNo:1, orderId:${orderId} },
            cache: true,
            dataType: "html",
            async: true,
            beforeSend: function () { },
            success: function (data) {
                if (data) {
                    $('#'+type).html(data);
                    $(".refreshtip").show(0);
                    $(".init-loading").html('刷新成功！');
                    setTimeout(function(){
                        $(".init-loading").html('').hide();
                    },800);
                    $(".loadtip").show(0);
                    mySwiper.update();
                }
            },
            error: function () {
                mySwiper.update();
            }
        });
    });
</script>
</body>
</html>
