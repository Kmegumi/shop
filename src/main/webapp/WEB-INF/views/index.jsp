<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path=request.getContextPath();%>
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
                <li>
                    <a href="#">
                        <i class="fa fa-home"></i>
                        <span class="nav-label">系统设置</span>
                        <span class="fa arrow"></span>
                    </a>
                    <ul class="nav nav-second-level">
                        <li><a class="J_menuItem" href="<%=path%>/rest/admin/list">用户管理</a></li>
                        <li><a class="J_menuItem" href="<%=path%>/rest/banner/list">banner管理</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">
                        <i class="fa fa-home"></i>
                        <span class="nav-label">商品管理</span>
                        <span class="fa arrow"></span>
                    </a>
                    <ul class="nav nav-second-level">
                        <li><a class="J_menuItem" href="<%=path%>/rest/goods/list">商品列表</a></li>
                        <li><a class="J_menuItem" href="<%=path%>/rest/column/list">栏目列表</a></li>
                        <li><a class="J_menuItem" href="<%=path%>/rest/goodsRecommend/list">推荐商品列表</a></li>
                        <li><a class="J_menuItem" href="<%=path%>/rest/goodsUpNew/list">上新商品列表</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">
                        <i class="fa fa-home"></i>
                        <span class="nav-label">订单管理</span>
                        <span class="fa arrow"></span>
                    </a>
                    <ul class="nav nav-second-level">
                        <li><a class="J_menuItem" href="<%=path%>/rest/order/list">订单列表</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">
                        <i class="fa fa-home"></i>
                        <span class="nav-label">客户管理</span>
                        <span class="fa arrow"></span>
                    </a>
                    <ul class="nav nav-second-level">
                        <li><a class="J_menuItem" href="<%=path%>/rest/customer/list">客户列表</a></li>
                    </ul>
                </li>
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
                    <li class="hidden-xs">
                        <a href="javaScript:uploadImg();" data-index="0"><i class="fa fa-key fa-fw"></i>
                            上传图片
                        </a>
                    </li>
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
    function uploadImg() {
        layer.open({
            type: 2,
            title: '上传图片',
            shadeClose: true, //点击遮罩关闭层
            area : ['800px' , '520px'],
            content: '<%=path%>/rest/img/upload'
        });
    }
</script>

</body>