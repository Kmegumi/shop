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
    <link href="<%=path %>/static/css/jquery.datetimepicker.css" rel="stylesheet">
    <jsp:include page="../charisma_href.jsp"></jsp:include>
    <script src="<%=path %>/static/js/jquery.datetimepicker.full.js"></script>
    <script src="<%=path %>/static/js/jquery.datetimepicker.js"></script>
    <script src="<%=path %>/static/ckeditor/ckeditor.js"></script>
    <script src="<%=path %>/static/ckeditor/samples/js/sample.js"></script>
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
                            <label class="col-sm-3 control-label">所属栏目：</label>
                            <div class="col-sm-2">
                                <select name="columnId">
                                    <c:forEach items="${list}" var="val">
                                        <option value="${val.id}" <c:if test="${goods.columnId == val.id}">selected="selected"</c:if>>${val.columnName}</option>
                                    </c:forEach>
                                </select>
                                <input type="hidden" name="id" value="${goods.id}" class="form-control">
                            </div>
                        </div>
                        <div class="form-group draggable">
                            <label class="col-sm-3 control-label ">商品编号：</label>
                            <div class="col-sm-2">
                                <input type="text" name="goodsCode" value="${goods.goodsCode}" class="form-control"required>
                            </div>
                        </div>
                        <div class="form-group draggable">
                            <label class="col-sm-3 control-label">商品名称：</label>
                            <div class="col-sm-2">
                                <input type="text" name="goodsName" value="${goods.goodsName}" class="form-control">
                            </div>
                        </div>
                        <div class="form-group draggable">
                            <label class="col-sm-3 control-label">商品简介：</label>
                            <div class="col-sm-2">
                                <input type="text" name="goodsIntro" value="${goods.goodsIntro}" class="form-control">
                            </div>
                        </div>
                        <div class="form-group draggable">
                            <label class="col-sm-3 control-label">商品图片：</label>
                            <div class="col-sm-2">
                                <input type="text" name="goodsImg" value="${goods.goodsImg}" class="form-control">
                            </div>
                        </div>
                        <div class="form-group draggable">
                            <label class="col-sm-3 control-label">商品价格：</label>
                            <div class="col-sm-2">
                                <input type="text" name="goodsPrice" value="${goods.goodsPrice}" class="form-control">
                            </div>
                        </div>
                        <div class="form-group draggable">
                            <label class="col-sm-3 control-label">商品库存：</label>
                            <div class="col-sm-2">
                                <input type="text" name="goodsStock" value="${goods.goodsStock}" class="form-control">
                            </div>
                        </div>
                        <div class="form-group draggable">
                            <label class="col-sm-3 control-label">开始时间：</label>
                            <div class="col-sm-2">
                                <input type="text" id="startTime" name="startTime" value="" class="form-control">
                            </div>
                        </div>
                        <div class="form-group draggable">
                            <label class="col-sm-3 control-label">商品排序号：</label>
                            <div class="col-sm-2">
                                <input type="text" name="sortNum" value="${goods.sortNum}" class="form-control">
                            </div>
                        </div>
                        <div class="form-group draggable" id="goodsDetail">
                            <label class="col-sm-2 control-label">商品详情</label>
                            <div class="col-sm-10">
                                <div id="editor">
                                    <h1>Hello world!</h1>
                                    <p>I'm an instance of </p>
                                </div>
                            </div>
                        </div>
                        <input type="hidden" name="goodsInfo" id="goodsInfo" value="${goods.goodsInfo}" class="form-control">
                        <input name="version" type="hidden" value="${goods.version}"/>
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
    $('#startTime').datetimepicker({ lang: 'ch' });
    $('#startTime').val(getFormatTime('${goods.startTime}'));
    CKEDITOR.document.getById( 'editor' ).setHtml(decodeURIComponent('${goods.encoderGoodsInfo}'));
    initSample();
    function add(){
        $('#goodsInfo').val(CKEDITOR.instances.editor.getData());
        var obj = {};
        var form = $('#addForm').serializeArray();
        $.each(form, function () {
            if (obj[this.name]) {
                if (!obj[this.name].push) {
                    obj[this.name] = [obj[this.name]];
                }
                obj[this.name].push(this.value || '');
            } else {
                obj[this.name] = this.value || '';
            }
        });
        $.ajax({
            type: 'POST',
            url: '<%=path%>/rest/goods/saveOrUpdate',
            data: JSON.stringify(obj),
            cache: false,
            dataType: "json",
            async: true,
            processData: false,
            contentType: 'application/json; charset=UTF-8',
            beforeSend: function () { },
            success: function (data) {
                if (data) {
                    if (data.code == '200') {
                        swal("操作成功！", data.msg, "success")
                        $('.confirm').click(function () {
                            window.location.href="<%=path%>/rest/goods/list";
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