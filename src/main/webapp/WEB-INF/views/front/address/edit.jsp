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
      <a href="javascript:void(0);" onclick="gofrontAddressList()" class="icon icon-left pull-left"></a>
      <h1 class="title">地址设置</h1>
    </header>
    <div class="content">
      <form>
        <div class="addAddress-row"><input type="hidden" id="addressId" value="${address.id}"><input type="text" id="addressName" value="${address.name}" placeholder="姓名"></div>
        <div class="addAddress-row"><input type="tel" id="addressTel" value="${address.tel}" placeholder="手机号码"></div>
        <div class="addAddress-row"><input type="text" id="city-picker" value="${address.city}" placeholder="省份、城市、区县"/></div>
        <div class="addAddress-row"><input type="text" id="addressDetail" value="${address.detail}" placeholder="详细地址（如街道、楼盘号等）"></div>
        <div class="default" id="default"  data-type="no">
          <input type="hidden" id="defaultFlag" value="${address.defaultFlag}">
          <!--<img src="img/Icon_Radio_Inactive.png" alt=""  style="display: none;">
          <img src="img/Icon_Radio_Active.png" alt="">-->
          <div class="default-font" <c:if test="${address.defaultFlag == true}">style="background: url(<%=path %>/static/front/img/Icon_Radio_Active.png) left no-repeat;background-size: contain;"</c:if>>
            设为默认地址
          </div>
        </div>
        <div class="address-footer" onclick="saveAddress()">保存</div>
        <div class="address-footer" style="margin-top: 5px" onclick="deleteAddress(${address.id})">删除</div>
      </form>
    </div>
  </div>
</div>
<script type='text/javascript' src='//g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm.min.js' charset='utf-8'></script>
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm-extend.min.js' charset='utf-8'></script>
<script type="text/javascript" src="//g.alicdn.com/msui/sm/0.6.2/js/sm-city-picker.min.js" charset="utf-8"></script>
<script type='text/javascript' src='<%=path %>/static/js/jquery.min.js' charset='utf-8'></script>
<script src="<%=path %>/static/Hplus/js/plugins/sweetalert/sweetalert.min.js"></script>
<!-- Initialize Swiper -->
<script>
  var $j = jQuery.noConflict(); //自定义一个比较短快捷方式
  $j(function() {
    $.init();
    $("#city-picker").cityPicker({
      toolbarTemplate: '<header class="bar bar-nav">\
            <button class="button button-link pull-right close-picker">确定</button>\
            <h1 class="title">选择收货地址</h1>\
            </header>'
    });
  })

  var flag = $("#defaultFlag").val();
  $(".default").click(function(){
    if(flag == false){
      $(".default-font").css({
        "background":"url(<%=path %>/static/front/img/Icon_Radio_Active.png) left no-repeat",
      "background-size":"contain"
      });
      flag = true;
    } else{
      $(".default-font").css({
        "background":"url(<%=path %>/static/front/img/Icon_Radio_Inactive.png) left no-repeat",
        "background-size":"contain"
      });
      flag = false;
    }
  })
  function saveAddress() {
    var addressId = document.getElementById('addressId').value;
    var addressName = document.getElementById('addressName').value;
    if (addressName == null || addressName.trim() == '') {
      alert('请填写姓名');
      return false;
    }
    var addressTel = document.getElementById('addressTel').value;
    if (addressTel == null || addressTel.trim() == '') {
      alert('请填写电话');
      return false;
    }
    var city = document.getElementById('city-picker').value;
    if (city == null || city.trim() == '') {
      alert('请选择城市');
      return false;
    }
    var addressDetail = document.getElementById('addressDetail').value;
    if (addressDetail == null || addressDetail.trim() == '') {
      alert('请填写详细地址');
      return false;
    }
    var type = $('#default').attr('data-type');
    $.ajax({
      type: 'post',
      url: '/rest/front/saveAddress',
      data: {id:addressId, name:addressName, tel:addressTel, city:city, detail:addressDetail, defaultFlag:flag},
      cache: false,
      dataType: "json",
      async: true,
      success: function (data) {
        if (data) {
          if (data.code == '1000') {
            swal("操作成功！", "地址已成功修改", "success")
            $('.confirm').click(function () {   //额外绑定一个事件，当确定执行之后返回成功的页面的确定按钮，点击之后刷新当前页面或者跳转其他页面
              location.href="<%=path %>/rest/front/frontAddressList";
            });
            //跳转支付页面
          } else if (data.code == '1100') {
            //弹出登录
          } else {
            alert(data.code);
          }
        }
      }
    });
  }

  function gofrontAddressList(){
    location.href="<%=path %>/rest/front/frontAddressList";
  }

  function deleteAddress(id){
    swal({
      title: "您确认要删除吗！",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#c9dae1",
      confirmButtonText: "确认",
      cancelButtonText: "取消",
      closeOnConfirm: false
    }, function () {
      $.ajax({
        type: 'post',
        url: '/rest/front/deleteAddress',
        data: {id:id},
        cache: false,
        dataType: "json",
        async: true,
        success: function (data) {
          if (data) {
            if (data.code == '1000') {
              swal("地址已成功删除！","", "success")
              $('.confirm').click(function () {   //额外绑定一个事件，当确定执行之后返回成功的页面的确定按钮，点击之后刷新当前页面或者跳转其他页面
                location.href="<%=path %>/rest/front/frontAddressList";
              });
              //跳转支付页面
            } else if (data.code == '1100') {
              //弹出登录
            } else {
              alert(data.code);
            }
          }
        }
      });
    });

  }
</script>
</body>
</html>
