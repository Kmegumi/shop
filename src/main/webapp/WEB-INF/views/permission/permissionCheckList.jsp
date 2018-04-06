<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 2017/8/16
  Time: 16:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                    <h5>权限管理</h5>
                </div>
                <div class="ibox-content">
                    <div class="form-group">
                        <form  action="<%=path%>/rest/permission/permissionCheck" id="formPage" method="post">
                            <input type="hidden" name="pageNo" id="pageNo" value="${form.pageNo}"/>
                            <input type="hidden" id="permissionValue" name="permissionValue" value="${form.permissionValue}"/>
                            <input type="hidden" id="permissionName" name="permissionName" value="${form.permissionName}"/>
                            名称：<input type="text" name="name" value="${form.name}" >
                            <span style="float: right;">
                                <a class="btn btn-primary" type="button" onclick="$('#formPage').submit();">查询</a>
                                <a class="btn btn-primary" type="button" onclick="add_ok()">确定</a>
                            </span>
                        </form>
                    </div>
                </div>
                <div class="ibox-content">
                    <table class="table table-striped table-bordered table-hover dataTables-example">
                        <thead>
                        <tr>
                            <th>&nbsp;</th>
                            <th>权限名</th>
                            <th>权限标识</th>
                            <th>权限描述</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${dome.list}" var="permission">
                            <tr>
                                <td align="center">
                                    <c:choose>
                                        <c:when test="${form.permissionValue.indexOf(permission.id.toString()) > -1}">
                                            <input name="permission" type="checkbox" checked="checked" data-name="${permission.permissionName}" class="checkInput" value="${permission.id}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <input name="permission" type="checkbox"  class="checkInput" data-name="${permission.permissionName}" value="${permission.id}"/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="center" id="name_${permission.id}">
                                        ${permission.permissionName}
                                </td>
                                <td class="center">
                                        ${permission.permissionSign}
                                </td>
                                <td class="center">
                                        ${permission.description}
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
    $('.checkInput').click(function(){
        var checkInput = $(this);
        var permissionValue = $("#permissionValue").val();
        var permissionName = $('#permissionName').val();
        var checkPermission = checkInput.val();
        var checkPermissionName = checkInput.attr('data-name');
        var permissionArr = null;
        var permissionNameArr = null;
        if (permissionValue == ''){
            permissionArr = [];
        } else {
            permissionArr = permissionValue.split(",");
        }
        if (permissionName == ''){
            permissionNameArr = [];
        } else {
            permissionNameArr = permissionName.split(",");
        }
        if(checkInput.is(":checked")){
            permissionNameArr.push(checkPermissionName);
            permissionArr.push(checkPermission);
        } else {
            for(var i = 0; i < permissionArr.length; i++) {
                if (permissionArr[i] == checkPermission) {
                    permissionArr.splice(i,1);
                    break;
                }
            }
            for(var i = 0; i < permissionNameArr.length; i++) {
                if (permissionNameArr[i] == checkPermissionName) {
                    permissionNameArr.splice(i,1);
                    break;
                }
            }
        }
        $('#permissionValue').val(permissionArr.join(","));
        $('#permissionName').val(permissionNameArr.join(","));
    });

    function add_ok(){
        var index = parent.layer.getFrameIndex(window.name);
        parent.$("#permissionId").val($('#permissionValue').val());
        parent.$('#permissionName').text($('#permissionName').val());
        parent.layer.close(index);
    }
</script>

</body>
</html>
