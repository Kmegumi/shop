<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="s"%>
<% String path = request.getContextPath(); %>
<link href="<%=path%>/static/css/tabs.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="<%=path%>/static/js/jquery.tabso_yeso.js"></script>
<script>
	//淡隐淡现选项卡切换
	$("#fadetab").tabso({
		cntSelect:"#fadecon",
		tabEvent:"click",
		tabStyle:"fade"
	});
</script>
<div class="demo">
	<ul class="tabbtn" id="fadetab">
		<li class="current"><a href="javascript:void(0);">用户信息</a></li>
	</ul>
	<div class="tabcon" id="fadecon">
		<div class="sublist">
			<div class="row">
				<div class="dialog-col-md-1">用户名：${userInfo.username}</div>
				<div class="dialog-col-md-1">姓名：${userInfo.name}</div>
			</div>
			<div class="row">
				<div class="dialog-col-md-1">联系电话  ：${userInfo.mobile}</div>
				<div class="dialog-col-md-1">状态：${userInfo.userStatus.desc}</div>
			</div>
			<div class="row">
				<div class="dialog-col-md-1">邮箱：${userInfo.email}</div>
				<div class="dialog-col-md-1"></div>
			</div>
			<div class="row">
				<div class="dialog-col-md-1">所属角色：${strRole}</div>
				<div class="dialog-col-md-1"></div>
			</div>

		</div>
	</div>
</div>
