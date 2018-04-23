<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
  <link rel="stylesheet" href="//g.alicdn.com/msui/sm/0.6.2/css/sm.min.css">
  <link rel="stylesheet" href="<%=path %>/static/front/css/main.css">
  <link rel="stylesheet" href="//g.alicdn.com/msui/sm/0.6.2/css/sm-extend.min.css">
  <link rel="stylesheet" href="http://static.shands.cn/common/frozenui-1.3.0/css/table.css">
  <link href="<%=path %>/static/Hplus/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
</head>
<body>
<div class="page-group">
  <div class="page page-current" id='router'>
    <header class="bar bar-nav header-z">
      <a href="javascript:void(0);" onclick="goafterSaleList()" class="icon icon-left pull-left"></a>
      <h1 class="title">申请售后</h1>
    </header>
    <div class="content">
      <div class="service-header">
        <c:if test="${afterSale.afterSaleStatusEnum == 'NO_CHECK'}">
          <div class="service-header_h"><img src="../../../static/front/img/Icon_Banner_Success_Primary.png" /></div>
          <div class="service-header_h2">申请售后提交成功，请耐心等待客服审核！</div>
          <div class="service-header_h3">
            <div onclick="goSaleEdit(${afterSale.id})" class="h3-left">修改售后申请</div>
            <div onclick="updateFalg(${afterSale.id})" class="h3-left">撤销售后申请</div>
          </div>
        </c:if>
        <c:if test="${afterSale.afterSaleStatusEnum == 'CHECK_OK'}">
          <div class="service-header_h"><img src="../../../static/front/img/Icon_Banner_Success_Primary.png" /></div>
          <div class="service-header_h2">您的售后申请已审核通过,正在处理退款!</div>
        </c:if>
        <c:if test="${afterSale.afterSaleStatusEnum == 'CHECK_NO'}">
          <div class="service-header_h"><img src="../../../static/image/badTeam.png" /></div>
          <div class="service-header_h2">您的售后申请审核未通过!</div>
        </c:if>
        <c:if test="${afterSale.afterSaleStatusEnum == 'REFUNDS_OK'}">
          <div class="service-header_h"><img src="../../../static/front/img/Icon_Banner_Success_Primary.png" /></div>
          <div class="service-header_h2">退款成功!</div>
        </c:if>
        <c:if test="${afterSale.afterSaleStatusEnum == 'REFUNDS_NO'}">
          <div class="service-header_h"><img src="../../../static/image/badTeam.png" /></div>
          <div class="service-header_h2">退款失败!</div>
        </c:if>
        <c:if test="${afterSale.afterSaleStatusEnum == 'REVOKED'}">
          <div class="service-header_h"><img src="../../../static/front/img/Icon_Banner_Success_Primary.png" /></div>
          <div class="service-header_h2">您的售后申请审核已撤销!</div>
        </c:if>
      </div>
      <div class="order-detail">
        <div class="order-detailLeft">
          <img src="${afterSale.order.goods.url}${afterSale.order.goods.img}" alt="">
        </div>
        <div class="order-detailRight">
          <div class="detailRight_f" style="font-size: 0.75rem;color: #333;  margin-bottom: 0.4rem;    height: 1rem;">
            <div class="f_left">${afterSale.order.goods.name}</div>
            <div class="f_right">￥${afterSale.order.goodsMoney}</div>
          </div>
          <div class="detailRight_f" style="font-size: 0.65rem;color: #666;  margin-bottom: 0.4rem;    height: 0.9rem;">
            <div class="f_left"><em>${afterSale.order.goods.teamNum}</em>人团</div>
            <div class="f_right">×<em>${afterSale.order.goodsNum}</em></div>
          </div>
          <div class="detailRight_f2">实付金额：<em>￥${afterSale.order.goodsTotalMoney}</em></div>
        </div>
      </div>
      <div class="service-wrap">
        <div class="service-detail">
          <div class="service-detail_l">申请售后原因：</div>
          <div class="service-detail_r">${afterSale.afterSaleReasons.name}</div>
        </div>
        <div class="service-detail">
          <div class="service-detail_l">申请售后份数：</div>
          <div class="service-detail_r">${afterSale.refundNum}</div>
        </div>
        <div class="service-detail">
          <div class="service-detail_l">问题描述：</div>
          <div class="service-detail_r">${afterSale.describe}</div>
        </div>
        <div class="service-detail">
          <div class="service-detail_l">退款金额：</div>
          <div class="service-detail_r">${afterSale.refundMoney}</div>
        </div>
      </div>
      <div class="address-footer" onclick="goIndex()">首页逛逛</div>
    </div>
  </div>
</div>
<script type='text/javascript' src='//g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
<script>
      $.config = {
          router: false
      }
</script>
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm.min.js' charset='utf-8'></script>
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm-extend.min.js' charset='utf-8'></script>
<script type='text/javascript' src='http://a.tbcdn.cn/libs/jquery/1.7.1/jquery.js' charset='utf-8'></script>
<script src="<%=path %>/static/Hplus/js/plugins/sweetalert/sweetalert.min.js"></script>

<script>
  function goIndex(){
    location.href = "<%=path%>/";
  }
  function goSaleEdit(id){
    location.href = "<%=path %>/rest/front/afterSaleEdit?id="+id;
  }
  function goafterSaleList(){
    location.href="<%=path %>/rest/front/afterSaleList";
  }
  function updateFalg(id){
    swal({
      title: "您确定要删除这条数据?",
      type: "warning",
      showCancelButton: true,
      closeOnConfirm: false,
      cancelButtonText:"取消",
      confirmButtonText: "确定",
      confirmButtonColor: "#ec6c62"
    },function(){
      $.ajax({
        url:'<%=path %>/rest/front/updateFalg?id='+id,
        type:'post',
        data:{id:id},
        success: function (data) {
          if (data) {
            if (data.code == '1000') {
              swal("售后申请以撤回！", "", "success")
              $('.confirm').click(function () {   //额外绑定一个事件，当确定执行之后返回成功的页面的确定按钮，点击之后刷新当前页面或者跳转其他页面
                location.href="<%=path %>/rest/front/afterSaleList";
              });
              //跳转支付页面
            } else if (data.code == '1100') {
              //弹出登录
            } else {
                alert(data.code);
                location.href="<%=path %>/rest/front/afterSaleList";
            }
          }
        }
      })
    })
  }
</script>
</body>
</html>
