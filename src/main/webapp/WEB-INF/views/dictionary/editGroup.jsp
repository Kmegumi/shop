<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<% String path=request.getContextPath();%>
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
					<h5>编辑字典分类</h5>
				</div>
				<div class="ibox-content">
					<form role="form" id="addForm" class="form-horizontal m-t">
						<input type="hidden" name="id" value="${group.id}" class="form-control">
						<div class="form-group draggable">
							<label class="col-sm-3 control-label text-center">名称：</label>
							<div class="col-sm-2">
								<input type="text" name="name" class="form-control" value="${group.name}" required>
							</div>
						</div>
						<div class="form-group draggable">
							<label class="col-sm-3 control-label ">代码：</label>
							<div class="col-sm-2">
								<input type="text" name="code" class="form-control" value="${group.code}" required>
							</div>
						</div>
						<div class="form-group draggable">
							<label class="col-sm-3 control-label">排序：</label>
							<div class="col-sm-2">
								<input type="number" name="sortCode" class="form-control" value="${group.sortCode}">
							</div>
						</div>
						<div class="form-group draggable">
							<label class="col-sm-3 control-label">描述：</label>
							<div class="col-sm-2">
								<textarea cols="50" rows="5" name="groupDescription">${group.description}</textarea>
							</div>
						</div>
						<div class="hr-line-dashed"></div>
						<div class="form-group draggable">
							<div class="col-sm-12 col-sm-offset-3">
								<button class="btn btn-primary" type="submit" >保存</button>
								<button class="btn btn-white" type="reset">返回</button>
							</div>
						</div>
						<input name="version" type="hidden" value="${group.version}"/>
					</form>
					<div class="clearfix"></div>
					<input id="token" type="hidden" value="${CSRFToken}"/>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
    function add(){
        $.ajax({
            type: 'POST',
            url: '<%=path %>/rest/dictionary/saveOrUpdateDictionaryGroup',
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
    }
</script>
</body>

</html>