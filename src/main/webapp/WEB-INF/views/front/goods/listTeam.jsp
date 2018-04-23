<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String path = request.getContextPath();%>
<c:if test="${goodsList == null}">
    <div class="errorContent">
        <img src="<%=path %>/static/front/img/error.png" alt="">
        <div class="error-font">没有找到相关商品</div>
    </div>
</c:if>
<c:forEach items="${goodsList}" var="goods">
    <div class="package-detail" onclick="window.location.href='<%=path%>/rest/front/goods/${goods.id}'">
        <div class="package-detailLeft">
            <img src="${goods.goodsImg}" alt="">
            <%--<div class="detailLeft-font">已团：<em>${goods.sellNum}</em>件</div>--%>
        </div>
        <div class="package-detailRight">
            <div class="detailRight-row">${goods.goodsName}</div>
            <div class="detailRight-row2">${goods.goodsIntro}</div>
            <div class="detailRight-row3">
                <div class="detailRight-row3Left">
                    <em> </em><i><b>￥</b>${goods.goodsPrice}</i><em></em>
                </div>
                <div class="group" style="background: #4C4C4C">购买</div>
            </div>
        </div>
    </div>
</c:forEach>
