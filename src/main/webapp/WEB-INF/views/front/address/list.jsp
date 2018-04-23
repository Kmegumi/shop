<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>拼购商城</title>

    <%@include file="../../include_front_titile.jsp"%>
    <style>
        .errorContent {  position: absolute;  top: 0;  bottom: 0;  left: 0;  right: 0;  margin: auto;  height: 5.2rem;  width: 70%;  text-align: center;  }
        .error-font{  position: absolute;  bottom: 0;  left: 0;  right: 0;  font-size: 0.7rem;  color: #666;  }
    </style>
</head>
<body>
<div class="page-group">
    <div class="page page-current" id='router'>
        <header class="bar bar-nav header-z">
            <a href="javascript:void(0);" onclick="goPersonal()" class="icon icon-left pull-left"></a>
            <h1 class="title">爱拼才会赢</h1>
        </header>
        <div class="content">
            <c:if test="${empty list}">
                <div class="errorContent">
                    <img src="<%=path%>/static/front/img/error.png" alt="">
                    <div class="error-font">您还没有设置地址</div>
                </div>
            </c:if>
            <c:forEach items="${list}" var="val">
                <div class="order-detail order-detail_c">
                    <div class="order-detailLeft">
                        <div class="detailLeft-top">${val.name}</div>
                        <c:if test="${val.defaultFlag == true}"><div class="detailLeft-bottom">默认</div></c:if>
                    </div>
                    <div class="order-detailRight">
                        <div class="detailRight_f" style="font-size: 0.75rem;color: #333;  margin-bottom: 0.4rem;    height: 1rem;">
                            <div class="f_left">${val.tel}</div>
                        </div>
                        <div class="detailRight_f" style="font-size: 0.65rem;color: #666;  margin-bottom: 0.4rem;">
                            <div  class="f_left_c">${val.city}${val.detail}</div>
                            <div class="f_right" onclick="goEdit(${val.id})"><img src="../../../../static/front/img/edit.png" alt=""></div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <div onclick="goAdd()" style="margin-top: 110%" class="address-footer">新增地址</div>
        </div>


    </div>
</div>
<script>
    function goAdd(){
        location.href="<%=path %>/rest/front/frontAddressAdd";
    }
    function goEdit(id){
        location.href="<%=path %>/rest/front/frontAddressEdit?id="+id;
    }
    function goPersonal(){
        location.href="<%=path %>/rest/front/personal";
    }
</script>
</body>
</html>
