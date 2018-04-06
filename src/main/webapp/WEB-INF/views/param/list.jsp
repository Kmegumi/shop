<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <jsp:include page="../include_title.jsp"></jsp:include>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <form  action="<%=path%>/rest/param/list" id="formPageNo" method="post" style="display: none;">
        <input type="hidden" name="pageNo" id="pageNoHide" value="${pagination.pageNo}"/>
        <input type="text" name="name" value="${pojoAllForm.name}" >
    </form>
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>参数管理</h5>
                </div>
                <div class="ibox-content">
                    <div class="form-group">
                        <form  action="<%=path%>/rest/param/list" id="form" method="post">
                            <input type="hidden" name="pageNo" id="pageNo" value="${pagination.pageNo}"/>
                            名称：<input type="text" name="name" value="${pojoAllForm.name}" >
                            <span style="float: right;">
                               <a class="btn btn-primary J_menuItem" type="button" href="<%=path%>/rest/param/toAdd" >添加</a>
                               <a class="btn btn-primary" type="button" onclick="$('#form').submit();">查询</a>
                            </span>
                        </form>
                    </div>
                </div>
                <div class="ibox-content">
                    <table class="table table-striped table-bordered table-hover dataTables-example">
                        <thead>
                        <tr>
                            <th>名称</th>
                            <th>代码</th>
                            <th>value</th>
                            <th>scope</th>
                            <th>type</th>
                            <th>group</th>
                            <th>排序</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${list}" var="demo">
                            <tr>
                                <td class="center">${demo.name}</td>
                                <td class="center">${demo.code}</td>
                                <td class="center">${demo.paramValue}</td>
                                <td class="center">${demo.paramScope}</td>
                                <td class="center">${demo.paramType}</td>
                                <td class="center">${demo.paramGroup}</td>
                                <td class="center">${demo.sortCode}</td>
                                <td class="col-sm-2">
                                    <a class="btn btn-primary J_menuItem" type="button" href="<%=path%>/rest/param/toEdit?id=${demo.id}" >编辑</a>
                                    <a class="btn btn-primary" type="button" onclick="del(${demo.id},'param')" >删除</a>
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