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
					<h5>添加</h5>
				</div>
				<div class="ibox-content">
					<form role="form" id="addForm" class="form-horizontal m-t">
						<div class="form-group draggable">
							<label class="col-sm-3 control-label">名称：</label>
							<div class="col-sm-2">
								<input type="text" name="name" class="form-control"required>
							</div>
						</div>
						<div class="form-group draggable">
							<label class="col-sm-3 control-label">编码：</label>
							<div class="col-sm-2">
								<input type="text" name="code" class="form-control"required>
							</div>
						</div>
						<div class="form-group draggable">
							<label class="col-sm-3 control-label">value：</label>
							<div class="col-sm-2">
								<input type="text" name="paramValue" class="form-control"required>
							</div>
						</div>
						<div class="form-group draggable">
							<label class="col-sm-3 control-label">scope：</label>
							<div class="col-sm-2">
								<input type="text" name="paramScope" class="form-control"required>
							</div>
						</div>
						<div class="form-group draggable">
							<label class="col-sm-3 control-label">type：</label>
							<div class="col-sm-2">
								<input type="text" name="paramType" class="form-control"required>
							</div>
						</div>
						<div class="form-group draggable">
							<label class="col-sm-3 control-label">group：</label>
							<div class="col-sm-2">
								<input type="text" name="paramGroup" class="form-control"required>
							</div>
						</div>
						<div class="form-group draggable">
							<label class="col-sm-3 control-label">排序：</label>
							<div class="col-sm-2">
								<input type="text" name="sortCode" class="form-control"required>
							</div>
						</div>

						<div class="form-group draggable">
							<label class="col-sm-3 control-label">描述：</label>
							<div class="col-sm-2">
								<input type="text" name="description" class="form-control">
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
				</div>
			</div>
		</div>
	</div>
</div>
<script>

	function add(){
		$.ajax({
			url : '<%=path %>/rest/param/add',
			data : $('#addForm').serialize(),
			type : "POST",
			success : function(data) {
				if (data.name == 100) {
					swal("操作成功！", "这条记录已成功添加。", "success")
					$('.confirm').click(function () {   //额外绑定一个事件，当确定执行之后返回成功的页面的确定按钮，点击之后刷新当前页面或者跳转其他页面
						window.location.href="<%=path%>/rest/param/list";
					});
				} else {
					swal("新增失败！", "" + data.name + "", "error");
				}
			}
		});
	}
</script>
</body>

</html>