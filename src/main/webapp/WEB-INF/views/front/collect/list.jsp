<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
  String path=request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>商城</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <%@include file="../../include_front_titile.jsp"%>
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
      <a href="javascript:void(0);" onclick="goPersonal()" class="icon icon-left pull-left"></a>
      <h1 class="title">我的收藏</h1>
    </header>
    <div class="content">
      <div class="row no-gutter itemlist-row">
        <div class="col-50 itemlist-row_l">喜欢的</div>
        <div class="col-50 itemlist-row_r">共<em>${list.size()}</em>件</div>
      </div>
      <c:if test="${empty list}">
        <div class="page-group" style="background: #eee;">
          <div class="errorContent">
            <img src="<%=path %>/static/front/img/error.png" alt="">
            <div class="error-font">您还没有相关的收藏</div>
          </div>
        </div>
      </c:if>
      <c:forEach items="${list}" var="val">
        <div class="package-detail"  onclick="goGoodsInfo(${val.goods.id})">
          <div class="package-detailLeft">
            <img src="${val.goods.goodsImg}" alt="">
            <div class="detailLeft-font"><em></em></div>
          </div>
          <div class="package-detailRight">
            <div class="detailRight-row">${val.goods.goodsName}</div>
            <div class="detailRight-row2">${val.goods.goodsIntro}</div>
            <div class="detailRight-row3">
              <div class="detailRight-row3Left">
                <em></em><i><b>￥</b>${val.goods.goodsPrice}</i><em></em>
              </div>
              <div class="col-50" style="text-align: right;margin-top: 0.2rem;">
                <a href="javascript:void(0)" style=" background: #4C4C4C">购买</a>
              </div>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>
</div>
<script>
  function goGoodsInfo(id){
    location.href="<%=path %>/rest/front/goods/"+id;
  }
  function goPersonal(id){
    location.href="<%=path%>/rest/front/personal";
  }
</script>
</body>
</html>
