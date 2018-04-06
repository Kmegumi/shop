<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String path=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta content="ie=7" http-equiv="x-ua-compatible">
    <title>首页</title>
    <jsp:include page="charisma_href.jsp"></jsp:include>
</head>
<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
<div id="wrapper">
    <!--左侧导航开始-->
    <nav class="navbar-default navbar-static-side" role="navigation">
        <div class="nav-close"><i class="fa fa-times-circle"></i>
        </div>
        <div class="sidebar-collapse">
            <ul class="nav" id="side-menu">
                <li class="nav-header">
                    <div class="dropdown profile-element">
                        <%--<img src="<%=path%>/static/image/headImg.jpg" style="margin-bottom: 10px;margin-top: -10px;width: 50px;height: 50px;">--%>
                        <span>
                            <img alt="image" class="img-circle" src="<%=path%>/static/image/headImg.jpg" style="width: 50px;height: 50px;" />
                        </span>
                        <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                            <span class="clear">
                                <span class="block m-t-xs">
                                    <strong class="font-bold">${admin.name}</strong>
                                </span>
                                <span class="block m-t-xs">
                                    <a href="<%=path%>/rest/login/logout">注销</a>
                                </span>
                            </span>
                        </a>
                    </div>

                </li>
                <shiro:hasPermission name="admin:list">
                <li>
                    <a href="#">
                        <i class="fa fa-home"></i>
                        <span class="nav-label">系统设置</span>
                        <span class="fa arrow"></span>
                    </a>
                    <ul class="nav nav-second-level">
                        <shiro:hasPermission name="admin:list">
                            <li><a class="J_menuItem" href="<%=path%>/rest/admin/list">用户管理</a></li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="role:list">
                            <li><a class="J_menuItem" href="<%=path%>/rest/role/list">角色管理</a></li>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="permission:list">
                            <li><a class="J_menuItem" href="<%=path%>/rest/permission/list">权限管理</a></li>
                        </shiro:hasPermission>
                    </ul>
                </li>
                </shiro:hasPermission>
            </ul>
        </div>
    </nav>
    <!--左侧导航结束-->
    <!--右侧部分开始-->
    <div id="page-wrapper" class="gray-bg dashbard-1">
        <div class="row border-bottom">
            <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header"><a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i> </a>
                </div>
                <ul class="nav navbar-top-links navbar-right">
                </ul>
            </nav>
        </div>
        <div class="row content-tabs">
            <button class="roll-nav roll-left J_tabLeft"><i class="fa fa-backward"></i>
            </button>
            <nav class="page-tabs J_menuTabs">
                <div class="page-tabs-content">
                    <a href="javascript:;" class="active J_menuTab" data-id="">首页</a>
                </div>
            </nav>
        </div>
        <div class="row J_mainContent" id="content-main">
            <iframe class="J_iframe"  width="100%" height="100%" src="<%=path%>/rest/main" frameborder="0" data-id="" seamless></iframe>
        </div>
        <div class="footer">
            <div class="pull-right"></a>
            </div>
        </div>
    </div>
    <!--右侧部分结束-->
</div>
<script>

</script>

</body>