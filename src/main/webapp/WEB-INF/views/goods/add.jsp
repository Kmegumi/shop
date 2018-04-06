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
                            <label class="col-sm-3 control-label">所属栏目：</label>
                            <div class="col-sm-2">
                                <select name="colummId">
                                    <option value="1">彩电</option>
                                    <option value="2">冰箱</option>
                                    <option value="3">彩电</option>
                                    <option value="4">彩电</option>
                                </select>
                                <input type="hidden" name="id" value="" class="form-control">
                            </div>
                        </div>
                        <div class="form-group draggable">
                            <label class="col-sm-3 control-label ">商品编号：</label>
                            <div class="col-sm-2">
                                <input type="text" name="goodsNum" value="" class="form-control"required>
                            </div>
                        </div>
                        <div class="form-group draggable">
                            <label class="col-sm-3 control-label">商品名称：</label>
                            <div class="col-sm-2">
                                <input type="text" name="goodsName" value="" class="form-control">
                            </div>
                        </div>
                        <div class="form-group draggable">
                            <label class="col-sm-3 control-label">商品简介：</label>
                            <div class="col-sm-2">
                                <input type="text" name="goodsIntro" value="" class="form-control">
                            </div>
                        </div>
                        <div class="form-group draggable">
                            <label class="col-sm-3 control-label">商品图片：</label>
                            <div class="col-sm-2">
                                <input type="text" name="file" value="" >
                            </div>
                        </div>
                        <div class="form-group draggable">
                            <label class="col-sm-3 control-label">商品价格：</label>
                            <div class="col-sm-2">
                                <input type="text" name="goodsPrice" value="" class="form-control">
                            </div>
                        </div>
                        <div class="form-group draggable">
                            <label class="col-sm-3 control-label">商品库存：</label>
                            <div class="col-sm-2">
                                <input type="text" name="goodsStock" value="" class="form-control">
                            </div>
                        </div>
                        <div class="form-group draggable">
                            <label class="col-sm-3 control-label">开始时间：</label>
                            <div class="col-sm-2">
                                <input type="text" name="startTime" value="" class="form-control">
                            </div>
                        </div>
                        <div class="form-group draggable">
                            <label class="col-sm-3 control-label">商品排序号：</label>
                            <div class="col-sm-2">
                                <input type="text" name="sortNumber" value="" class="form-control">
                            </div>
                        </div>
                        <div class="form-group draggable">
                            <label class="col-sm-3 control-label">商品详情：</label>
                            <div class="col-sm-2">
                                <input type="text" name="goodsInfo" value="" class="form-control">
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
            url: '<%=path%>/rest/goods/save',
            data: $('#addForm').serialize(),
            cache: false,
            dataType: "json",
            async: true,
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