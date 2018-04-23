<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
  <style>
    ::-webkit-input-placeholder { /* WebKit browsers */
      color: #CCC;
    }
    :-moz-placeholder { /* Mozilla Firefox 4 to 18 */
      color: #CCC;
    }
    ::-moz-placeholder { /* Mozilla Firefox 19+ */
      color: #CCC;
    }
    :-ms-input-placeholder { /* Internet Explorer 10+ */
      color: #CCC;
    }
  </style>
</head>
<body>
<div class="page-group">
  <div class="page page-current" id='router'>
    <header class="bar bar-nav header-z">
      <a href="javascript:void(0);" onclick="history.go(-1)" class="icon icon-left pull-left"></a>
      <h1 class="title">申请售后</h1>
    </header>
    <div class="content">
      <input id="afterSaleReasonsName" type="hidden" value="${afterSaleReasonsName}">
      <input id="orderId" type="hidden" value="${order.id}">
      <div class="order-detail" style="margin-bottom: 0.4rem;">
        <div class="order-detailLeft">
          <img src="${order.goods.url}${order.goods.img}" alt="">
        </div>
        <div class="order-detailRight">
          <div class="detailRight_f" style="font-size: 0.75rem;color: #333;  margin-bottom: 0.4rem;    height: 1rem;">
            <div class="f_left">${order.goods.name}</div>
            <div class="f_right">￥${order.goodsMoney}</div>
          </div>
          <div class="detailRight_f" style="font-size: 0.65rem;color: #666;  margin-bottom: 0.4rem;    height: 0.9rem;">
            <div class="f_left"><em>${order.goods.teamNum}</em>人团</div>
            <div class="f_right">×<em>${order.goodsNum}</em></div>
          </div>
          <div class="detailRight_f2">实付金额：<em>￥${order.orderMoney}</em></div>
        </div>
      </div>
      <div class="service-row">
        <div class="service-title">申请售后原因</div>
        <div class="service-content">
          <input type="text" id='picker' placeholder="选择原因"/>
        </div>
      </div>
      <div class="service-row">
        <div class="service-title">选择售后商品数量</div>
        <div class="service-content">
          <input type="text" id='num' placeholder="选择数量"/>
        </div>
      </div>
      <div class="service-row">
        <div class="service-title">问题描述</div>
        <div class="service-content2">
          <textarea name="" id="describe" cols="30" rows="10" placeholder="请详细描述问题"></textarea>
        </div>
        <div class="service-content3">
          <div class="content3-left">退款金额将根据退款说明进行确认</div>
          <div class="content3-right">0/100</div>
        </div>
      </div>
      <div class="invoice-footer" onclick="saveAfterSale()">提交</div>
    </div>
  </div>
</div>
<script type='text/javascript' src='//g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm.min.js' charset='utf-8'></script>
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm-extend.min.js' charset='utf-8'></script>
<script type="text/javascript" src="//g.alicdn.com/msui/sm/0.6.2/js/sm-city-picker.min.js" charset="utf-8"></script>
<script type='text/javascript' src='<%=path %>/static/js/jquery.min.js' charset='utf-8'></script>
<script src="<%=path %>/static/Hplus/js/plugins/sweetalert/sweetalert.min.js"></script>
<script>
  var $j = jQuery.noConflict(); //自定义一个比较短快捷方式
  $j(function() {
    $.init();
  })

  var str = $("#afterSaleReasonsName").val();
  var arr=new Array();
  arr=str.split(',');
  $("#picker").picker({
    toolbarTemplate: '<header class="bar bar-nav">\
          <button class="button button-link pull-left"></button>\
          <button class="button button-link pull-right close-picker">确定</button>\
          <h1 class="title">选择申请售后原因</h1>\
          </header>',
    cols: [
      {
        textAlign: 'center',
        values: arr
      }
    ]
  });

  var goodsNum = '${order.goodsNum}';
  var numArr = [];
  for(var i = 1; i <= parseInt(goodsNum); i++) {
      numArr.push(i);
  }

  $("#num").picker({
      toolbarTemplate: '<header class="bar bar-nav">\
          <button class="button button-link pull-left"></button>\
          <button class="button button-link pull-right close-picker">确定</button>\
          <h1 class="title">选择售后数量</h1>\
          </header>',
      cols: [
          {
              textAlign: 'center',
              values: numArr
          }
      ]
  });

  function saveAfterSale() {
    var orderId = document.getElementById('orderId').value;
    var afterSaleReasons = document.getElementById('picker').value;
    var afterSaleNum = document.getElementById('num').value;
    if (afterSaleReasons == null || afterSaleReasons.trim() == '') {
      alert('请选择理由');
      return false;
    }
    var describe = document.getElementById('describe').value;
    if (describe == null || describe.trim() == '') {
      alert('请填写描述');
      return false;
    }
    swal({
      title: "",
      text:"申请成功后相应款项将在15个工作日内原路退回您的账户，并将扣除10%的手续费，确定继续申请吗?",
      type: "warning",
      showCancelButton: true,
      closeOnConfirm: false,
      cancelButtonText:"再考虑考虑",
      confirmButtonText: "确定",
      confirmButtonColor: "#ec6c62"
    },function(){
      $j.ajax({
        type: 'post',
        url: '/rest/front/saveAfterSale',
        data: {orderId:orderId, afterSaleReasonsName:afterSaleReasons, describe:describe, afterSaleNum:afterSaleNum},
        cache: false,
        dataType: "json",
        async: true,
        success: function (data) {
          if (data) {
            if (data.code == '1000') {
              swal("售后申请已提交", "","success")
              $('.confirm').click(function () {   //额外绑定一个事件，当确定执行之后返回成功的页面的确定按钮，点击之后刷新当前页面或者跳转其他页面
                location.href="<%=path %>/rest/front/afterSaleInfo?id="+data.id;
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
      });
    })

  }
</script>
</body>
</html>
