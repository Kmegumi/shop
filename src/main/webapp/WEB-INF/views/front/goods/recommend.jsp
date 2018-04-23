<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String recommendPath = request.getContextPath();%>
<c:forEach items="${recommendList}" var="recommend">
    <div class="package-detail" onclick="window.location.href='<%=recommendPath%>/rest/front/goods/${recommend.goodsId}'">
        <div class="package-detailLeft">
            <img src="${recommend.goodsUrl}${recommend.goodsImg}" alt="">
            <div class="detailLeft-font">已团：<em>${recommend.sellNum + recommend.sellNumDeviation}</em>件</div>
        </div>
        <div class="package-detailRight">
            <div class="detailRight-row">${recommend.goodsName}</div>
            <div class="detailRight-row2">${recommend.goodsIntro}</div>
            <div class="detailRight-row3">
                <div class="detailRight-row3Left">
                    <em>${recommend.teamNum}</em>人团<i><b>￥</b>${recommend.teamPrice}</i>单价￥<em>${recommend.onePrice}</em>
                </div>
                <c:choose>
                    <c:when test="${recommend.goodsStatusEnum.name().equals('SELL_OUT')}">
                        <div class="group" style=" background: #4C4C4C">已售罄</div>
                    </c:when>
                    <c:when test="${time < recommend.startTime.longValue()}">
                        <div class="group" style=" background: #4C4C4C">即将售卖</div>
                    </c:when>
                    <c:otherwise>
                        <div class="group" >我要开团</div>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
    </div>
</c:forEach>