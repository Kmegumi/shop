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
                            <label class="col-sm-3 control-label">栏目名称：</label>
                            <div class="col-sm-2">
                                <input type="text" name="columnName" value="" class="form-control"required>
                                <input type="hidden" name="id" value="" class="form-control">
                            </div>
                        </div>

                        <input name="version" type="hidden" value=""/>

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
            type: 'POST',
            url: '<%=path%>/rest/column/save',
            data: $('#addForm').serialize(),
            cache: false,
            dataType: "json",
            async: true,
            beforeSend: function () { },
            success: function (data) {
                alert("操作成功"+data.msg)
            },
            error: function () { }
        });
    }

</script>
</body>

</html>