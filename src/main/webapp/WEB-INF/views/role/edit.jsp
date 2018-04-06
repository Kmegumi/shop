<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
							<label class="col-sm-3 control-label">角色名称：</label>
							<div class="col-sm-2">
								<input type="text" name="roleName" value="${role.roleName}" class="form-control"required>
								<input type="hidden" name="id" value="${role.id}" class="form-control">
							</div>
						</div>
						<div class="form-group draggable">
							<label class="col-sm-3 control-label ">角色标识：</label>
							<div class="col-sm-2">
								<input type="text" name="roleSign" value="${role.roleSign}" class="form-control"required>
							</div>
						</div>
						<div class="form-group draggable">
							<label class="col-sm-3 control-label">角色描述：</label>
							<div class="col-sm-2">
								<input type="text" name="roleDescription" value="${role.description}" class="form-control">
							</div>
						</div>
						<input name="version" type="hidden" value="${role.version}"/>
						<div class="form-group draggable">
							<label class="col-sm-3 control-label">选择权限：</label>
							<div class="col-sm-2">
								<input type="button" value="选择" class="form-control" onclick="showPermission()"><br/>
								<textarea cols="50" rows="5" id="permissionName">${permissionName}</textarea>
								<input type="hidden" name="permissionId" id="permissionId" value="${permissionId}" class="form-control">
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
					<div class="clearfix"></div>
					<input id="token" type="hidden" value="${CSRFToken}"/>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	function showPermission(){
		layer.open({
			type: 2,
			title: '选择权限',
			shadeClose: true, //点击遮罩关闭层
			area : ['800px' , '520px'],
			content: '<%=path %>/rest/permission/permissionCheck?permissionValue=' + $("#permissionId").val()
		});
	}
    function add(){
        $.ajax({
            type: 'POST',
            url: '<%=path %>/rest/role/saveOrUpdateRole',
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
                            window.location.href="<%=path%>/rest/role/list";
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