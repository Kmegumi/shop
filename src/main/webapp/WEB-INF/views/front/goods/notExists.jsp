<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String path = request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="../../include_front_titile.jsp"%>
    <style>
        .out_w{text-align: center;  padding: 2rem 0 1.5rem 0;  background: #F2F2F2;}
        .out_w img{width: 64px;height: 64px;}
        .out_w p{font-size: 0.8rem;  margin-top: 0.8rem;  color: #666;}
        .pull-right>img{width: 1rem;  height: 1rem;}
    </style>
</head>
<body>
<div class="page-group">
    <div class="page page-current" id='router'>
        <header class="bar bar-nav header-z">
            <a class="icon icon-left pull-left" onclick="window.location.href='<%=path%>/rest/front/goodsList?columnId=-1'"></a>
            <a class="icon pull-right" onclick="window.location.href='<%=path%>/'">
                <img src="<%=path %>/static/front/img/Icon_Tab_Bar_Home_Inactive.svg" alt="">
            </a>
        </header>
        <div class="content">
            <div class="out_w">
                <img src="<%=path %>/static/front/img/noSell.png" alt="window.location.href='<%=path%>/'">
                <p>商品不可购买！</p>
            </div>
        </div>
    </div>
</div>




<script type='text/javascript' src='//g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
<script>
    //    $.config = {
    //        router: false
    //    }
</script>
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm.min.js' charset='utf-8'></script>
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm-extend.min.js' charset='utf-8'></script>
<script type='text/javascript' src='http://a.tbcdn.cn/libs/jquery/1.7.1/jquery.js' charset='utf-8'></script>

<!-- Initialize Swiper -->
<script>

</script>
</body>
</html>