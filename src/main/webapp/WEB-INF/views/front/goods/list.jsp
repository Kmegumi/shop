<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String path = request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>商城</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" href="//g.alicdn.com/msui/sm/0.6.2/css/sm.min.css">
    <link rel="stylesheet" href="<%=path %>/static/front/css/main.css">
    <link rel="stylesheet" href="//g.alicdn.com/msui/sm/0.6.2/css/sm-extend.min.css">
    <link rel="stylesheet" href="http://static.shands.cn/common/frozenui-1.3.0/css/table.css">
    <script type='text/javascript' src='//g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
    <script type="text/javascript" src="<%=path %>/static/front/js/touchslider.js"></script>
    <script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm.min.js' charset='utf-8'></script>
    <script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm-extend.min.js' charset='utf-8'></script>
    <style>
        .detailRight-row3Left{
            -prefix-box-flex: 2;-webkit-box-flex: 2;-webkit-flex: 2;-moz-box-flex: 2;-ms-flex: 2;flex: 2;
        }
        .errorContent {  position: absolute;  top: 0;  bottom: 0;  left: 0;  right: 0;  margin: auto;  height: 5.2rem;  width: 70%;  text-align: center;  }
        .error-font{  position: absolute;  bottom: 0;  left: 0;  right: 0;  font-size: 0.7rem;  color: #666;  }
    </style>
</head>
<body>
<div class="page-group">
    <div class="page page-current" id='router'>
        <header class="bar bar-nav header-z">
            <a class="icon icon-left pull-left" href="<%=path%>/"></a>
            <h1 class="title">商品列表</h1>
        </header>
        <div class="content" id="content">
            <div class="find_nav">
                <div class="find_nav_left">
                    <div class="find_nav_list">
                        <ul id="pagenavi1">
                            <li><a href="#" data-id="0">全部</a></li>
                            <c:forEach items="${columnList}" var="column">
                                <li><a href="#" data-id="${column.id}">${column.columnName}</a></li>
                            </c:forEach>
                            <li class="sideline"></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div id="slider1" class="swipe">
                <ul class="box01_list">
                    <li class="li_list" style="position: relative;">
                    </li>
                    <c:forEach items="${columnList}" var="column">
                        <li class="li_list" style="position: relative;">
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <nav class="bar bar-tab footer-bar" style="position: sticky; position: -webkit-sticky;height: 2.65rem;">
                <a class="tab-item external active" href="<%=path%>/">
                    <span>
                        <img src="<%=path %>/static/front/img/Icon_Tab_Bar_Home_Inactive.svg" />
                    </span>
                    <span class="tab-label">首页</span>
                </a>
                <a class="tab-item external" href="#">
                    <span>
                        <img src="<%=path %>/static/front/img/Icon_Tabbar_New_Arrival_Activve.svg" />
                    </span>
                    <span class="tab-label"  style="color: #fa725a">商品</span>
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
        </div>
    </div>
    <%@include file="../login/_login_botton_js.jsp"%>
    <%@include file="../login/_login.jsp"%>
</div>
<script type='text/javascript' src='http://a.tbcdn.cn/libs/jquery/1.7.1/jquery.js' charset='utf-8'></script>
<!-- Initialize Swiper -->
<script>
    var $j = jQuery.noConflict(); //自定义一个比较短快捷方式
    $j(function() {
        $.init();
        var columnId = QueryString('columnId');
        if (columnId == null) {
            columnId =0 ;
        }
        var aList = $('#pagenavi1').find("a");
        for(var i = 0; i< aList.length; i++) {
            var id = $(aList[i]).attr('data-id');
            //console.log(id)
            if (id == columnId) {
                $(aList[i]).click();
            }

        }

    })
    // 给li定义高度，配合css使li独立滚动
    var $jwindow = $j(window);
    var initialWindowHeight = null;
    $jwindow.resize(function() {
        sliderHeight();
    });
    sliderHeight();
    function sliderHeight(){
        var wHeight = $j(window).height();
        var sliderHeight = wHeight - 70

        $j(".swipe li").height(sliderHeight);
    }
    function QueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return decodeURIComponent(r[2]);
        return null;
    }
    $j(".find_nav_list").css("left",0);
    $j(".find_nav_list li").each(function(){
        $j(".sideline").css({left:0});
    });
    var nav_w=$j(".find_nav_list li").first().width();
    $j(".sideline").width(nav_w);
    $j(".find_nav_list li").on('click', function(){
        nav_w=$(this).width();
        $j(".sideline").stop(true);
        $j(".sideline").animate({left:$(this).position().left},300);
        $j(".sideline").animate({width:nav_w});
        $j(this).addClass("find_nav_cur").siblings().removeClass("find_nav_cur");
        var fn_w = ($j(".find_nav").width() - nav_w) / 2;
        var fnl_l;
        var fnl_x = parseInt($j(this).position().left);
        if (fnl_x <= fn_w) {
            fnl_l = 0;
        } else if (fn_w - fnl_x <= flb_w - fl_w) {
            fnl_l = flb_w - fl_w;
        } else {
            fnl_l = fn_w - fnl_x;
        }
        $j(".find_nav_list").animate({
            "left" : fnl_l
        }, 300);

    });
    var fl_w=$j(".find_nav_list").width();
    var flb_w=$j(".find_nav_left").width();
    $j(".find_nav_list").on('touchstart', function (e) {
        var touch1 = e.originalEvent.targetTouches[0];
        x1 = touch1.pageX;
        y1 = touch1.pageY;
        ty_left = parseInt($j(this).css("left"));
    });
    $j(".find_nav_list").on('touchmove', function (e) {
        var touch2 = e.originalEvent.targetTouches[0];
        var x2 = touch2.pageX;
        var y2 = touch2.pageY;
        if(ty_left + x2 - x1>=0){
            $j(this).css("left", 0);
        }else if(ty_left + x2 - x1<=flb_w-fl_w){
            $j(this).css("left", flb_w-fl_w);
        }else{
            $j(this).css("left", ty_left + x2 - x1);
        }
        if(Math.abs(y2-y1)>0){
            e.preventDefault();
        }
    });
    for(n=1 ; n<2 ; n++){
        var page = 'pagenavi'+n;
        var mslide = 'slider'+n;
        var mtitle = 'emtitle'+n;
        arrdiv = 'arrdiv' + n;
        var as = $j("#" + page + "").find("a");
        var tt = new TouchSlider({id:mslide,'auto':'-1',fx:'ease-out',direction:'left',speed:600,timeout:5000,'before':function(index, li, columnid){
            //console.log(columnid)
            var as=document.getElementById(this.page).getElementsByTagName('a');
            as[this.p].className='';
            this.p = index;
            //$j(".find_nav_list li").eq(this.p).html(异步加载页面)
            var li = $j("#"+mslide +" li").eq(this.p);
            addGoods(columnid, li);
            fnl_x =  parseInt($j(".find_nav_list li").eq(this.p).position().left);
            nav_w=$j(".find_nav_list li").eq(this.p).width();
            $j(".sideline").stop(true);
            $j(".sideline").animate({left:$j(".find_nav_list li").eq(this.p).position().left},300);
            $j(".sideline").animate({width:nav_w},100);
            $j(".find_nav_list li").eq(this.p).addClass("find_nav_cur").siblings().removeClass("find_nav_cur");
            var fn_w = ($j(".find_nav").width() - nav_w) / 2;
            var fnl_l;
            if (fnl_x <= fn_w) {
                fnl_l = 0;
            } else if (fn_w - fnl_x <= flb_w - fl_w) {
                fnl_l = flb_w - fl_w;
            } else {
                fnl_l = fn_w - fnl_x;
            }
            $j(".find_nav_list").animate({
                "left" : fnl_l
            }, 300);
        }});
        tt.page = page;
        tt.p = 0;
        //console.dir(tt); console.dir(tt.__proto__);
        //console.log(tt.id)
        for(var i=0;i<as.length;i++){
            (function(){
                var j=i;
                var columnId = $(as[j]).attr("data-id");
                as[j].tt = tt;
                as[j].onclick=function(){
                    this.tt.slide(j, 600, columnId);
                    return false;
                }
            })();
        }
    }
    function addGoods(columnId, o) {
        if ( typeof columnId == 'undefined'? true : false) {
            console.log(1)
            return false;
        }
        $.ajax({
            type: 'post',
            url: '<%=path%>/rest/front/goodsList',
            data: {columnId:columnId },
            cache: true,
            dataType: "html",
            async: true,
            beforeSend: function () { },
            success: function (data) {
                if (data) {
                    o.html(data);
                    //console.log(data)
                    var searchDetail = $('#searchDetail');//console.log(searchDetail)
                    if (searchDetail) {
                        $('#searchDetail').attr('style', 'text-align: center;')
                    }
                }
            },
            error: function () { }
        });
    }


</script>
</body>
</html>