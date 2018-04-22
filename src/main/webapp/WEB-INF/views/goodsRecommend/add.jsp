<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
                            <label class="col-sm-3 control-label">选择商品：</label>
                            <div class="col-sm-2">
                                <select name="goodsId" class="selectCss">
                                    <c:forEach items="${list}" var="val">
                                        <option value="${val.id}" <c:if test="${goodsRecommend.goodsId == val.id}">selected="selected"</c:if>>${val.goodsName}</option>
                                    </c:forEach>
                                </select>
                                <input type="hidden" name="id" value="${goodsRecommend.id}" class="form-control">
                                <input name="version" type="hidden" value="${goodsRecommend.version}"/>
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
            url: '<%=path%>/rest/goodsRecommend/saveOrUpdate',
            data: $('#addForm').serialize(),
            cache: false,
            dataType: "json",
            async: true,
            beforeSend: function () { },
            success: function (data) {
                if (data) {
                    if (data.code == '200') {
                        swal("操作成功！", data.msg, "success")
                        $('.confirm').click(function () {
                            window.location.href="<%=path%>/rest/goodsRecommend/list";
                        });
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