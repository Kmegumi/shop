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
	<jsp:include page="../charisma_href.jsp"></jsp:include>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content">
	<div class="row">
		<div class="col-sm-12">
			<div class="ibox float-e-margins">
				<div class="ibox-title">
					<h5>编辑</h5>
				</div>
				<div class="ibox-content">
					<form role="form" id="addForm" class="form-horizontal m-t">
						<div class="form-group draggable">
							<label class="col-sm-3 control-label text-center">用户名：</label>
							<div class="col-sm-2">
								<input type="text" name="username" value="${user.username}" class="form-control" required>
								<input type="hidden" name="id" id="id" value="${user.id}" class="form-control">
							</div>
						</div>
						<div class="form-group draggable">
							<label class="col-sm-3 control-label ">密码：</label>
							<div class="col-sm-2">
								<input type="password" name="password" value="${user.password}" class="form-control" required>
							</div>
						</div>
						<div class="form-group draggable">
							<label class="col-sm-3 control-label">姓名：</label>
							<div class="col-sm-2">
								<input type="text" name="name" value="${user.name}" class="form-control" required>
							</div>
						</div>
						<div class="form-group draggable">
							<label class="col-sm-3 control-label">手机号：</label>
							<div class="col-sm-2">
								<input type="mobile" name="mobile" value="${user.mobile}" class="form-control" required>
							</div>
						</div>
						<div class="form-group draggable">
							<label class="col-sm-3 control-label">邮箱：</label>
							<div class="col-sm-2">
								<input type="text" name="email" value="${user.email}" class="form-control" required>
							</div>
						</div>

						<div class="form-group draggable">
							<label class="col-sm-3 control-label">选择角色：</label>
							<div class="col-sm-2">
								<input type="button" value="选择" class="form-control" onclick="showRole()"><br/>
								<textarea cols="50" rows="5" id="role_name" name="roleName">${roleName}</textarea>
								<input type="hidden" name="roleId" id="roleId" value="${roleId}" class="form-control"required>
							</div>
						</div>
						<input name="version" type="hidden" value="${user.version}"/>
						<div class="form-group draggable">
							<label class="col-sm-3 control-label ">状态：</label>
							<div class="col-sm-2">
								<select class="form-control" name="status" >
									<c:forEach items="${statusEnum}" var="val">
										<option value="${val.name()}" <c:if test="${user.status == val}">selected="selected"</c:if>>${val.desc}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="hr-line-dashed"></div>
						<div class="form-group draggable">
							<div class="col-sm-12 col-sm-offset-3">
								<button class="btn btn-primary" type="submit" >保存</button>
								<button class="btn btn-white" type="reset">返回</button>
							</div>
						</div>
					</form>
					<input id="token" type="hidden" value="${CSRFToken}"/>
					<div class="clearfix"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	function showRole(){
		layer.open({
			type: 2,
			title: '选择角色',
			shadeClose: true, //点击遮罩关闭层
			area : ['800px' , '520px'],
			content: '<%=path %>/rest/role/roleCheck?roleValue=' + $("#roleId").val()
		});
	}
	function add(){
        $.ajax({
            type: 'POST',
            url: '<%=path %>/rest/admin/saveOrUpdateAdmin',
            data: $('#addForm').serialize(),
            cache: false,
            dataType: "json",
            async: true,
            headers: {token: $('#token').val()},
            beforeSend: function () { },
            success: function (data) {
                if (data) {
                    if (data.code == '1000' || data.code == '1001') {
                        swal("操作成功！", data.msg, "success")
                        $('.confirm').click(function () {
                            window.location.href="<%=path%>/rest/admin/list";
                        });
                        getToken();
                    } else {
                        swal("修改失败！", data.msg, "error");
                    }
                }
            },
            error: function () { }
        });
	}
</script>
</body>

</html>