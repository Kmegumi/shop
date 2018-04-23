<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%String path=request.getContextPath();%>
<c:if test="${list != null && list.size() > 0}">
    <c:forEach items="${list}" var="coupons">
        <li>
            <c:choose>
                <c:when test="${coupons.voucherStateEnum.equals('NOTCANCELAFTERVERIFICATION')}">
                    <img src="<%=path%>/static/front/img/Active@2x.png" alt="">
                    <a href="<%=path%>/rest/front/couponsDetail/${coupons.voucherNum}" style="width: 300px;">
                        <em>${coupons.goodName}</em>
                        <i>${coupons.voucherNum}</i><br/>
                        <i>${fn:substring(coupons.validStartDate, 0, 10)} - ${fn:substring(coupons.validEndDate, 0, 10)} 有效</i>
                        <p>${coupons.activityName}</p>
                    </a>
                    <c:if test="${coupons.isIfBookVoucher()}"><a href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx9fd031cb2b974296&redirect_uri=http%3a%2f%2fwww.kaiyuanhotels.com.cn%2ffront%2fpublicOAuth.htm%3fextenalType%3dweixin%26urlType%3d0%26redirectUrl%3d%252Fm%252Fhotel%252FtoVoucherOrder.htm%253FvoucherNum%253D${coupons.voucherNum}&response_type=code&scope=snsapi_base&state=123#wechat_redirec" class="examine">立即预约</a></c:if>
                </c:when>
                <c:when test="${coupons.voucherStateEnum.equals('EXPIRED')}">
                    <img src="<%=path%>/static/front/img/Inactive@2x.png" alt="">
                    <a href="<%=path%>/rest/front/couponsDetail/${coupons.voucherNum}" style="width: 300px;">
                        <em>${coupons.goodName}</em>
                        <i>${coupons.voucherNum}</i><br/>
                        <i>${fn:substring(coupons.validStartDate, 0, 10)} - ${fn:substring(coupons.validEndDate, 0, 10)}有效</i>
                        <p>${coupons.activityName} <em>已过期</em></p>
                    </a>
                </c:when>
                <c:when test="${coupons.voucherStateEnum.equals('CANCELAFTERVERIFICATIONFINISH')}">
                    <img src="<%=path%>/static/front/img/Inactive@2x.png" alt="">
                    <a href="<%=path%>/rest/front/couponsDetail/${coupons.voucherNum}" style="width: 300px;">
                        <em>${coupons.goodName}</em>
                        <i>${coupons.voucherNum}</i><br/>
                        <i>${fn:substring(coupons.validStartDate, 0, 10)} - ${fn:substring(coupons.validEndDate, 0, 10)}有效</i>
                        <p>${coupons.activityName} <em>已核销</em></p>
                    </a>
                </c:when>
                <c:when test="${coupons.voucherStateEnum.equals('STORAGEFINISH')}">
                    <img src="<%=path%>/static/front/img/Inactive@2x.png" alt="">
                    <a href="<%=path%>/rest/front/couponsDetail/${coupons.voucherNum}" style="width: 300px;">
                        <em>${coupons.goodName}</em>
                        <i>${coupons.voucherNum}</i><br/>
                        <i>${fn:substring(coupons.validStartDate, 0, 10)} - ${fn:substring(coupons.validEndDate, 0, 10)}有效</i>
                        <p>${coupons.activityName} <em>已封存</em></p>
                    </a>
                </c:when>
                <c:when test="${coupons.voucherStateEnum.equals('FROZEN')}">
                    <img src="<%=path%>/static/front/img/Inactive@2x.png" alt="">
                    <a href="<%=path%>/rest/front/couponsDetail/${coupons.voucherNum}" style="width: 300px;">
                        <em>${coupons.goodName}</em>
                        <i>${coupons.voucherNum}</i><br/>
                        <i>${fn:substring(coupons.validStartDate, 0, 10)} - ${fn:substring(coupons.validEndDate, 0, 10)}有效</i>
                        <p>${coupons.activityName} <em>已冻结</em></p>
                    </a>
                </c:when>
            </c:choose>
        </li>
    </c:forEach>
</c:if>
