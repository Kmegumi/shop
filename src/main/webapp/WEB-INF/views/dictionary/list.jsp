<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String path = request.getContextPath();
%>
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
                    <h5>字典管理</h5>
                </div>
                <div class="ibox-content">
                    <div class="form-group">
                        <form  action="<%=path%>/rest/dictionary/list" id="formPage" method="post">
                            <input type="hidden" name="pageNo" id="pageNo" value="${form.pageNo}"/>
                            <select name="dictionaryEnum" class="selectCss" id="dictionaryEnum" onchange="changeGroup();">
                                <c:forEach items="${statusList}" var="status">
                                    <option value="${status.name()}" <c:if test="${status == form.dictionaryEnum}">selected="selected"</c:if>>${status.desc}</option>
                                </c:forEach>
                            </select>
                            <select name="dictionaryGroupId" id="dictionaryGroupId" class="selectCss" <c:if test="${form.dictionaryEnum.name().equals('GROUP')}">disabled="disabled"</c:if>>
                                <option value="">全部</option>
                                <c:if test="${dome!= null}">
                                    <c:forEach items="${dome.list}" var="group">
                                        <option value="${group.id}" <c:if test="${group.id.intValue() == form.dictionaryGroupId.intValue()}">selected="selected"</c:if>>${group.name}</option>
                                    </c:forEach>
                                </c:if>

                            </select>
                            名称：<input type="text" name="name" value="${form.name}" >
                            <span style="float: right;">
                               <a class="btn btn-primary J_menuItem" type="button" href="javascript:void(0);" onclick="window.location.href='<%=path%>/rest/dictionary/addGroup'">添加分组</a>
                               <a class="btn btn-primary" type="button" onclick="$('#formPage').submit();">查询</a>
                            </span>
                        </form>
                    </div>
                </div>
                <c:if test="${form.dictionaryEnum.name().equals('GROUP')}">
                    <div class="ibox-content">
                        <table class="table table-striped table-bordered table-hover dataTables-example">
                            <thead>
                            <tr>
                                <th>编码</th>
                                <th>名称</th>
                                <th>排序</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${dome!= null}">
                                <c:forEach items="${dome.list}" var="var">
                                    <tr>
                                        <td class="center">${var.code}</td>
                                        <td class="center">${var.name}</td>
                                        <td class="center">${var.sortCode}</td>
                                        <td class="col-sm-2">
                                            <a class="btn btn-primary J_menuItem" type="button" href="javascript:void(0);" onclick="window.location.href='<%=path%>/rest/dictionary/editGroup/${var.id}'">编辑</a>
                                            <a class="btn btn-primary" type="button" onclick="deleteDictionaryGroup(${var.id})" >删除</a>
                                            <a class="btn btn-primary J_menuItem" type="button" href="javascript:void(0);" onclick="window.location.href='<%=path%>/rest/dictionary/add/${var.id}'">添加字典数据</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            </tbody>
                        </table>
                        <jsp:include page="../row_Bounds.jsp"></jsp:include>
                    </div>
                </c:if>
                <c:if test="${form.dictionaryEnum.name().equals('INFO')}">
                    <div class="ibox-content">
                        <table class="table table-striped table-bordered table-hover dataTables-example">
                            <thead>
                            <tr>
                                <th>编码</th>
                                <th>名称</th>
                                <th>短名称</th>
                                <th>所属分类</th>
                                <th>排序</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${dome!= null}">
                                <c:forEach items="${dome.list}" var="var">
                                    <tr>
                                        <td class="center">${var.code}</td>
                                        <td class="center">${var.name}</td>
                                        <td class="center">${var.shortName}</td>
                                        <td class="center">${var.groupName}</td>
                                        <td class="center">${var.sortCode}</td>
                                        <td class="col-sm-2">
                                            <a class="btn btn-primary J_menuItem" type="button" href="javascript:void(0);" onclick="window.location.href='<%=path%>/rest/dictionary/edit/${var.id}'">编辑</a>
                                            <a class="btn btn-primary" type="button" onclick="deleteDictionary(${var.id})" >删除</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            </tbody>
                        </table>
                        <jsp:include page="../row_Bounds.jsp"></jsp:include>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    <input id="token" type="hidden" value="${CSRFToken}"/>
</div>
<script>
    $(function(){
        changeGroup();
    });


    function changeGroup(){
        if($("#dictionaryEnum").val()== 'GROUP'){
            $("#dictionaryGroupId").attr("disabled","disabled");
            $("#dictionaryGroupId").css("background-color","#ddd");
        }
        else{
            $("#dictionaryGroupId").removeAttr("disabled");
            $("#dictionaryGroupId").css("background-color","#fff");
        }
    }

    function deleteDictionary(id){
        swal({
            title: "您确定要删除这条信息吗",
            text: "删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            cancelButtonText: "取消",
            closeOnConfirm: false
        }, function () {
            $.ajax({
                type: 'POST',
                url: '<%=path %>/rest/dictionary/deleteDictionary',
                data: {id:id},
                cache: false,
                dataType: "json",
                async: true,
                headers: {token: $('#token').val()},
                beforeSend: function () { },
                success: function (data) {
                    if (data) {
                        if (data.code == '1000') {
                            swal("操作成功！", data.msg, "success")
                            $('.confirm').click(function () {
                                window.location.href="<%=path%>/rest/dictionary/list";
                            });
                            getToken();
                        } else {
                            swal("修改失败！", data.msg, "error");
                        }
                    }
                },
                error: function () { }
            });
        });
    }
    
    function deleteDictionaryGroup(id) {
        swal({
            title: "您确定要删除这条信息吗",
            text: "删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            cancelButtonText: "取消",
            closeOnConfirm: false
        }, function () {
            $.ajax({
                type: 'POST',
                url: '<%=path %>/rest/dictionary/deleteDictionaryGroup',
                data: {id:id},
                cache: false,
                dataType: "json",
                async: true,
                headers: {token: $('#token').val()},
                beforeSend: function () { },
                success: function (data) {
                    if (data) {
                        if (data.code == '1000') {
                            swal("操作成功！", data.msg, "success")
                            $('.confirm').click(function () {
                                window.location.href="<%=path%>/rest/dictionary/list";
                            });
                            getToken();
                        } else {
                            swal("修改失败！", data.msg, "error");
                        }
                    }
                },
                error: function () { }
            });
        });
    }
</script>
</body>
</html>