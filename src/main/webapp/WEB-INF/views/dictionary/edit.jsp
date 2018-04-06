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
					<h5>编辑字典数据</h5>
				</div>
				<div class="ibox-content">
					<form role="form" id="addForm" class="form-horizontal m-t">
						<input type="hidden" name="id" value="${dictionary.id}" class="form-control">
						<div class="form-group draggable">
							<label class="col-sm-3 control-label ">编码：</label>
							<div class="col-sm-2">
								<input type="text" name="code" class="form-control" value="${dictionary.code}" required>
							</div>
						</div>
						<div class="form-group draggable">
							<label class="col-sm-3 control-label text-center">名称：</label>
							<div class="col-sm-2">
								<input type="text" name="name" class="form-control" value="${dictionary.name}" required>
							</div>
						</div>
						<div class="form-group draggable">
							<label class="col-sm-3 control-label text-center">短名称：</label>
							<div class="col-sm-2">
								<input type="text" name="shortName" class="form-control" value="${dictionary.shortName}">
							</div>
						</div>
						<div class="form-group draggable">
							<label class="col-sm-3 control-label ">分组：</label>
							<div class="col-sm-2">
								<input value="${dictionaryGroup.name}" readonly="readonly" />
								<input name="groupId" type="hidden" value="${dictionaryGroup.id}">
							</div>
						</div>
						<div class="form-group draggable">
							<label class="col-sm-3 control-label">排序：</label>
							<div class="col-sm-2">
								<input type="number" name="sortCode" class="form-control" value="${dictionary.sortCode}">
							</div>
						</div>
						<div class="form-group draggable">
							<label class="col-sm-3 control-label">描述：</label>
							<div class="col-sm-2">
								<textarea cols="50" rows="5" name="description">${dictionary.description}</textarea>
							</div>
						</div>
						<input name="version" type="hidden" value="${dictionary.version}"/>
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
	<c:if test="${flag}">
		alert('缺少分组参数');
		window.location.href = '<%=path%>/rest/dictionary/list';
	</c:if>
    function add(){
        $.ajax({
            type: 'POST',
            url: '<%=path %>/rest/dictionary/saveOrUpdateDictionary',
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