<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <jsp:include page="../include_title.jsp"></jsp:include>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>推荐商品管理</h5>
                </div>
                <div class="ibox-content">
                    <div class="form-group">
                        <form  action="<%=path%>/rest/goodsRecommend/list" id="formPage" method="post">
                            <input type="hidden" name="pageNo" id="pageNo" value="${form.pageNo}"/>
                            名称：<input type="text" name="name" value="${form.name}" >
                <span style="float: right;">
                   <a class="btn btn-primary J_menuItem" type="button" href="<%=path%>/rest/goodsRecommend/add" >添加</a>
                   <a class="btn btn-primary" type="button" onclick="$('#formPage').submit();">查询</a>
                </span>
                        </form>
                    </div>
                </div>
                <div class="ibox-content">
                    <table class="table table-striped table-bordered table-hover dataTables-example">
                        <thead>
                        <tr>
                            <th>商品编号</th>
                            <th>商品名称</th>
                            <th>商品分类</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${page.content}" var="demo">
                            <tr>
                                <td class="center">${demo.goods.goodsCode}</td>
                                <td class="center">${demo.goods.goodsName}</td>
                                <td class="center">${demo.goods.goodsColumn.columnName}</td>
                                <td class="col-sm-2">
                                    <a class="btn btn-primary J_menuItem" type="button" href="<%=path%>/rest/goodsRecommend/add?id=${demo.id}" >编辑</a>
                                    <a class="btn btn-primary" type="button" onclick="del(${demo.id})" >删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <jsp:include page="../row_Bounds.jsp"></jsp:include>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function del(id){
        swal({
            title: "您确定要删除这条信息吗",
            text: "删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            cancelButtonText: "取消",
            closeOnConfirm: false
        }, function () {
            $.ajax({
                type: 'POST',
                url: '<%=path %>/rest/goodsRecommend/delete',
                data: {id:id},
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
        });
    }

</script>
</body>
</html>