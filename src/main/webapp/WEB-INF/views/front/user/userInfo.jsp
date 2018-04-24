<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
  String path=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>商城</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <%@include file="../../include_front_titile.jsp"%>
</head>
<body>
<div class="page-group">
  <div class="page page-current" id='router'>
    <header class="bar bar-nav header-z">
      <a href="javascript:void(0);" onclick="goPersonal()" class="icon icon-left pull-left"></a>
      <h1 class="title">个人资料</h1>
    </header>
    <div class="content">
      <a href="javascript:void(0);" class="row no-gutter profile-row" >
        <div class="col-60 profile-row_l personal-icon">
          <c:if test="${not empty customer.headImg and customer.headImg != ''}"><img src="${customer.headImg}" alt=""></c:if>
          <c:if test="${empty customer.headImg or customer.headImg == ''}"><img src="<%=path%>/static/front/img/Icon_Label_Avator.png" alt=""></c:if>
        </div>
    </a>
      <a href="javascript:void(0);" class="row no-gutter personal-mod">
        <div class="col-50 mod-left">昵称</div>
        <div class="col-50 mod-right">${customer.nickName}</div>
      </a>
      <a href="javascript:void(0);" class="row no-gutter personal-mod">
        <div class="col-50 mod-left">真名</div>
        <div class="col-50 mod-right">${customer.name}</div>
      </a>
      <a href="javascript:void(0);" class="row no-gutter personal-mod">
        <div class="col-50 mod-left">电话</div>
        <div class="col-50 mod-right">${customer.mobile}</div>
      </a>
      <a href="javascript:void(0);" class="row no-gutter personal-mod">
        <div class="col-50 mod-left">余额</div>
        <div class="col-50 mod-right">${customer.money}</div>
      </a>
      <div class="profile-footer" onclick="loginOut()">退出登录</div>
    </div>
  </div>
</div>

<script>
  function goPersonal(){
    location.href="<%=path%>/rest/front/personal";
  }
  function loginOut(){
    $.ajax({
      type: 'post',
      url: '/rest/front/loginOut',
      data: {},
      cache: false,
      dataType: "json",
      async: true,
      success: function (data) {
        if (data) {
          if (data.code == '200') {
            location.href="<%=path %>/";
          } else {
            alert(data.msg);
          }
        }
      }
    });
  }
</script>
</body>
</html>
