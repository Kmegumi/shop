<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <jsp:include page="../include_title.jsp"></jsp:include>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>订单管理</h5>
                </div>
                <div class="ibox-content">
                    <div class="form-group">
                        <form  action="<%=path%>/rest/order/list" id="formPage" method="post">
                            <input type="hidden" name="pageNo" id="pageNo" value="${form.pageNo}"/>
                            名称：<input type="text" name="name" value="${form.name}" >
                <span style="float: right;">
                   <a class="btn btn-primary" type="button" onclick="$('#formPage').submit();">查询</a>
                </span>
                        </form>
                    </div>
                </div>
                <div class="ibox-content">
                    <table class="table table-striped table-bordered table-hover dataTables-example">
                        <thead>
                        <tr>
                            <th>订单号</th>
                            <th>商品名称</th>
                            <th>订单总价</th>
                            <th>购买数量</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${page.content}" var="demo">
                            <tr>
                                <td class="center">${demo.orderNum}</td>
                                <td class="center">${demo.goods.goodsName}</td>
                                <td class="center">${demo.goodsTotalMoney}</td>
                                <td class="center">${demo.goodsNum}</td>
                                <td class="col-sm-2">
                                    <a class="btn btn-primary J_menuItem" type="button" href="<%=path%>/rest/order/see?id=${demo.id}" >查看</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <jsp:include page="../row_Bounds.jsp"></jsp:include>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
</script>
</body>
</html>