<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String path1 = request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>拼购商城</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" href="//g.alicdn.com/msui/sm/0.6.2/css/sm.min.css">
    <link rel="stylesheet" href="<%=path1 %>/static/front/css/main.css">
    <link rel="stylesheet" href="//g.alicdn.com/msui/sm/0.6.2/css/sm-extend.min.css">
    <link rel="stylesheet" href="http://static.shands.cn/common/frozenui-1.3.0/css/table.css">
    <script type='text/javascript' src='//g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
    <script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm.min.js' charset='utf-8'></script>
    <script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm-extend.min.js' charset='utf-8'></script>
    <script type='text/javascript' src='<%=path1 %>/static/js/jquery.min.js' charset='utf-8'></script>
    <style>
        .content-block{margin:0;  padding:0;}
        .buttons-tab .button.active{color: #FA725A;    border-color: #FA725A;}
        .detailRight-row3Left{
            -prefix-box-flex: 2;-webkit-box-flex: 2;-webkit-flex: 2;-moz-box-flex: 2;-ms-flex: 2;flex: 2;
        }
        .errorContent {  position: absolute;  top: 0;  bottom: 0;  left: 0;  right: 0;  margin: auto;  height: 5.2rem;  width: 70%;  text-align: center;  }
        .error-font{  position: absolute;  bottom: 0;  left: 0;  right: 0;  font-size: 0.7rem;  color: #666;  }
        .detailRight-row3Left{
            -prefix-box-flex: 2;-webkit-box-flex: 2;-webkit-flex: 2;-moz-box-flex: 2;-ms-flex: 2;flex: 2;
        }
    </style>
</head>
<body>
<div class="page-group">
    <div class="page page-current" id='router'>
        <header class="bar bar-nav header-z">
            <a href="javascript:void(0);" class="icon icon-left pull-left" onclick="window.location.href='<%=path1%>/'" ></a>
            <h1 class="title">商品列表</h1>
        </header>
        <div class="content">
            <c:if test="${dome.goodSList.size() == 0}">
                <div class="errorContent">
                    <img src="<%=path1 %>/static/front/img/error.png" alt="">
                    <div class="error-font">没有找到相关商品</div>
                </div>
            </c:if>
            <c:forEach items="${dome.goodSList}" var="goods">
                <div class="package-detail" onclick="window.location.href='<%=path1%>/rest/front/goods/${goods.id}'">
                    <div class="package-detailLeft">
                        <img src="${goods.img}" alt="">
                        <div class="detailLeft-font">已团：<em>${goods.sellNum}</em>件</div>
                    </div>
                    <div class="package-detailRight">
                        <div class="detailRight-row">${goods.goodsName}</div>
                        <div class="detailRight-row2">${goods.goodsIntro}</div>
                        <div class="detailRight-row3">
                            <div class="detailRight-row3Left">
                                <em>${goods.teamNum}</em>人团<i><b>￥</b>${goods.teamPrice}</i>单价<em>￥${goods.onePrice}</em>
                            </div>
                            <c:choose>
                                <c:when test="${goods.goodsStatusEnum.name().equals('SELL_OUT')}">
                                    <div class="group" style="background: #4C4C4C">已售罄</div>
                                </c:when>
                                <c:when test="${goods.upNow}">
                                    <div class="group" >我要开团</div>
                                </c:when>
                                <c:otherwise>
                                    <div class="group" style="background: #4C4C4C">即将售卖</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

</body>
</html>
