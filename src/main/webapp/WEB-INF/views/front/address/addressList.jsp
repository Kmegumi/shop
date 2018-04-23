<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String path=request.getContextPath();%>
<c:if test="${list.size() == 0}">
    <p style="text-align: center;margin-top: 10px;">暂无可用地址，请新增地址</p>
</c:if>
<c:forEach items="${list}" var="address">
    <div class="order-detail order-detail_c" >
        <div style="overflow: hidden;-prefix-box-flex: 1;-webkit-box-flex: 1;-webkit-flex: 1;-moz-box-flex: 1;-ms-flex: 1;flex: 1;display:-webkit-box;display:-moz-box;display:-webkit-flex;display:-moz-flex;display:-ms-flexbox;display: flex;"  onclick="getAddressToOrder(${address.id})">
            <div class="order-detailLeft">
                <div class="detailLeft-top">${address.name}</div>
                <c:if test="${address.defaultFlag}"><div class="detailLeft-bottom">默认</div></c:if>
            </div>
            <div class="order-detailRight">
                <div class="detailRight_f" style="font-size: 0.75rem;color: #333;  margin-bottom: 0.4rem;    height: 1rem;">
                    <div class="f_left">${address.tel}</div>
                </div>
                <div class="detailRight_f" style="font-size: 0.65rem;color: #666;  margin-bottom: 0.4rem;">
                    <div  class="f_left_c">${address.addressAll}</div>
                </div>
            </div>
        </div>
        <%--<div class="f_right"><img src="<%=path%>/static/front/img/edit.png" alt=""></div>--%>
    </div>
</c:forEach>
<div class="address-footer" onclick="addAddress()">新增地址</div>
