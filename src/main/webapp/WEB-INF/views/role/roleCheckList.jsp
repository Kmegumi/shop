<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 2017/8/11
  Time: 11:19
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
                    <h5>角色管理</h5>
                </div>
                <div class="ibox-content">
                    <div class="form-group">
                        <form  action="<%=path%>/rest/role/roleCheck" id="formPage" method="post">
                            <input type="hidden" name="pageNo" id="pageNo" value="${form.pageNo}"/>
                            <input type="hidden" id="roleValue" name="roleValue" value="${form.roleValue}"/>
                            <input type="hidden" id="roleName" name="roleName" value="${form.roleName}"/>
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
                            <th>角色名</th>
                            <th>角色标识</th>
                            <th>角色描述</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${dome.list}" var="role">
                            <tr>
                                <td align="center">
                                    <c:choose>
                                        <c:when test="${form.roleValue.indexOf(role.id.toString()) > -1}">
                                            <input name="role" type="checkbox" checked="checked" data-name="${role.roleName}" class="checkInput" value="${role.id}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <input name="role" type="checkbox"  class="checkInput" data-name="${role.roleName}" value="${role.id}"/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="center" id="name_${role.id}">
                                        ${role.roleName}
                                </td>
                                <td class="center">
                                        ${role.roleSign}
                                </td>
                                <td class="center">
                                        ${demo.description}
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
        var roleValue = $("#roleValue").val();
        var roleName = $('#roleName').val();
        var checkRole = checkInput.val();
        var checkRoleName = checkInput.attr('data-name');
        console.log(roleValue);
        console.log(roleName);
        var roleArr = null;
        var roleNameArr = null;
        if (roleValue == ''){
            roleArr = [];
        } else {
            roleArr = roleValue.split(",");
        }
        if (roleName == ''){
            roleNameArr = [];
        } else {
            roleNameArr = roleName.split(",");
        }
        if(checkInput.is(":checked")){
            roleNameArr.push(checkRoleName);
            roleArr.push(checkRole);
        } else {
            for(var i = 0; i < roleArr.length; i++) {
                if (roleArr[i] == checkRole) {
                    roleArr.splice(i,1);
                    break;
                }
            }
            for(var i = 0; i < roleNameArr.length; i++) {
                if (roleNameArr[i] == checkRoleName) {
                    roleNameArr.splice(i,1);
                    break;
                }
            }
        }
        console.log(roleArr);
        console.log(roleNameArr);
        $('#roleValue').val(roleArr.join(","));
        $('#roleName').val(roleNameArr.join(","));
    });

    function add_ok(){
        var index = parent.layer.getFrameIndex(window.name);
        parent.$("#roleId").val($('#roleValue').val());
        parent.$('#role_name').text($('#roleName').val());
        parent.layer.close(index);
    }
</script>

</body>
</html>