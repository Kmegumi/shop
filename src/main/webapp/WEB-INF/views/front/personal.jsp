<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
  String path=request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>拼购商城</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">

  <%@include file="../include_front_titile.jsp"%>

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
          <c:if test="${not empty booker.headImg and booker.headImg != ''}"><img src="${booker.headImg}" alt=""></c:if>
          <c:if test="${empty booker.headImg or booker.headImg == ''}"><img src="../../../static/front/img/Icon_Label_Avator.png" alt=""></c:if>
        </div>
        <div class="personal-row">${booker.mobile}</div>
        <div class="personal-row2" onclick="goUserInfo()">个人信息</div>
      </div>
      <a href="javascript:void(0);" onclick="goOrderList()" class="row no-gutter personal-mod">
        <div class="col-50 mod-left">我的订单</div>
        <div class="col-50 mod-right"><img src="../../../static/front/img/Icon_Label_Forward_Primary.png" alt=""></div>
      </a>
      <nav class="bar bar-tab bar-change">
        <a class="tab-item external active" href="<%=path %>/rest/front/orderList?orderStatus=PAY_WAIT">
          <span ><img src="../../../static/front/img/Icon_Wallet_Primary.png" alt=""></span>
          <span class="tab-label">待付款</span>
          <c:if test="${payWaitCount != 0}"><span class="badge">${payWaitCount}</span></c:if>
        </a>
        <a class="tab-item external" href="<%=path %>/rest/front/orderList?orderStatus=TEAM_WAIT">
          <span><img src="../../../static/front/img/Icon_Bubble_Primary.png" alt=""></span>
          <span class="tab-label">待成团</span>
          <c:if test="${teamWaitCount != 0}"><span class="badge">${teamWaitCount}</span></c:if>
        </a>
        <a class="tab-item external" href="<%=path %>/rest/front/orderList?orderStatus=SEND_WAIT">
          <span><img src="../../../static/front/img/Icon_Package_Primary.png" alt=""></span>
          <span class="tab-label">待发货</span>
          <c:if test="${sendWaitCount != 0}"><span class="badge">${sendWaitCount}</span></c:if>
        </a>
        <a class="tab-item external" href="<%=path %>/rest/front/orderList?orderStatus=OK">
          <span><img src="../../../static/front/img/Icon_Shipping_Primary.png" alt=""></span>
          <span class="tab-label">完成</span>
          <c:if test="${okCount != 0}"><span class="badge">${okCount}</span></c:if>
        </a>
      </nav>
      <div class="personal-mod2">
        <a href="javascript:void(0);" onclick="window.location.href='<%=path %>/rest/front/myTeamOrder'" class="row no-gutter personal-mod">
          <div class="col-50 mod-left">我的拼团</div>
          <div class="col-50 mod-right"><img src="../../../static/front/img/Icon_Label_Forward_Primary.png" alt=""></div>
        </a>
        <a href="javascript:void(0);" onclick="window.location.href='<%=path %>/rest/front/couponsList'" class="row no-gutter personal-mod">
          <div class="col-50 mod-left">在线预约</div>
          <div class="col-50 mod-right"><img src="../../../static/front/img/Icon_Label_Forward_Primary.png" alt=""></div>
        </a>
        <a href="javascript:void(0);" onclick="goCollect()" class="row no-gutter personal-mod">
          <div class="col-50 mod-left">我的收藏</div>
          <div class="col-50 mod-right"><img src="../../../static/front/img/Icon_Label_Forward_Primary.png" alt=""></div>
        </a>
        <a href="javascript:void(0);" onclick="goafterSaleList()" class="row no-gutter personal-mod">
          <div class="col-50 mod-left">售后申请</div>
          <div class="col-50 mod-right"><img src="../../../static/front/img/Icon_Label_Forward_Primary.png" alt=""></div>
        </a>
        <a href="javascript:void(0);" onclick="gofrontAddressList()" class="row no-gutter personal-mod">
          <div class="col-50 mod-left">收货地址</div>
          <div class="col-50 mod-right"><img src="../../../static/front/img/Icon_Label_Forward_Primary.png" alt=""></div>
        </a>
        <a href="javascript:void(0);" onclick="location.href='https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx9fd031cb2b974296&redirect_uri=http%3a%2f%2fwww.kaiyuanhotels.com.cn%2ffront%2fpublicOAuth.htm%3fredirectUrl%3dhttp%253a%252f%252feb.kaiyuanhotels.com%252ffront%252findex.htm%253fspaceName%253dfront%2526actionName%253dorderList%26extenalType%3dweixin&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect'" class="row no-gutter personal-mod">
          <div class="col-50 mod-left">切换旧版</div>
          <div class="col-50 mod-right"><img src="../../../static/front/img/Icon_Label_Forward_Primary.png" alt=""></div>
        </a>
      </div>
      <nav class="bar bar-tab footer-bar" style="    position: fixed;height: 2.65rem;">
        <a class="tab-item external active" href="<%=path%>/">
        <span>
            <img src="../../../static/front/img/Icon_Tab_Bar_Home_Inactive.svg" alt="">
            <img src="../../../static/front/img/Icon_Tab_Bar_Home_Active.svg" alt="">
        </span>
          <span class="tab-label">首页</span>
        </a>
        <a class="tab-item external" href="<%=path%>/rest/front/goodsList?columnId=-1">
        <span>
            <img src="../../../static/front/img/Icon_Tabbar_New_Arrival_Inactive.svg" alt="">
            <img src="../../../static/front/img/Icon_Tabbar_New_Arrival_Activve.svg" alt="">
        </span>
          <span class="tab-label">上新</span>
        </a>
        <a class="tab-item external" href="<%=path %>/rest/front/orderList">
        <span>
           <img src="../../../static/front/img/Icon_TabBar_Orderlist_Inactive.svg" alt="">
           <img src="../../../static/front/img/Icon_TabBar_List_Active.svg" alt="">
        </span>
          <span class="tab-label">订单</span>
        </a>
        <a class="tab-item external" href="<%=path%>/rest/front/personal">
        <span>
          <img src="../../../static/front/img/Icon_Tab_Bar_Person_Center_Inactive.svg" alt="">
        </span>
          <span class="tab-label" style="color: #fa725a">个人中心</span>
        </a>
      </nav>
    </div>
  </div>
  <%@include file="login/_login.jsp"%>
</div>

<script>
  //    $.config = {
  //        router: false
  //    }
</script>

<!-- Initialize Swiper -->
<script>
  var $j = jQuery.noConflict(); //自定义一个比较短快捷方式
  $j(function() {
    $.init();
  })
  $j(".tab-item").click(function () {
    $j(this).children().children("img:nth-child(2)").show().siblings("img").hide();
    $j(this).children(".tab-label").css("color","#FA725A")
    $j(this).siblings(".tab-item").children().children("img:first-child").show().siblings("img:nth-child(2)").hide();
    $j(this).siblings(".tab-item").children(".tab-label").css("color","#333")
  })
  function gofrontAddressList(){
    location.href="<%=path %>/rest/front/frontAddressList";
  }
  function goOrderList(){
    location.href="<%=path %>/rest/front/orderList";
  }
  function goafterSaleList(){
    location.href="<%=path %>/rest/front/afterSaleList";
  }
  function goUserInfo(){
    location.href="<%=path %>/rest/front/userInfo";
  }
  function goCollect(){
    location.href="<%=path %>/rest/front/collectList";
  }


  $(document).on('click','.open-login', function () {
    $.popup('.popup-login');
  });

  function loginSuccess(){
    location.href="<%=path %>/rest/front/userInfo";
  }
</script>
</body>
</html>
