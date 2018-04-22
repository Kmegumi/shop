<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta content="ie=7" http-equiv="x-ua-compatible">
	<jsp:include page="charisma_href.jsp"></jsp:include>
	<script src="<%=path %>/static/js/localResizeIMG2.js?v=1234"></script>
	<style>
		.img-border{
			width: 250px;
			height: 250px;
			border: 1px solid #ccc;
			text-align: center;
			line-height: 250px;
		}
		.img-div{
			margin-left: 15px;
			width: 70px;
			float: left;
			cursor: pointer;
		}
		.img-close {
			color: #fff;
			top: 0;
			position: absolute;
			font-size: 20px;
			background: #666;
			padding: 1;
		}
	</style>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content">
	<div class="row">
		<div class="col-sm-12">
			<div class="ibox float-e-margins">
				<div class="ibox-title">
					<h5>上传图片</h5>
				</div>
				<div class="ibox-content">
					<form role="form" id="addForm" class="form-horizontal m-t" enctype="application/x-www-form-urlencoded">
						<div class="form-group">
							<label class="col-sm-2 control-label">点击添加图片</label>
							<div class="col-sm-2">
								<div class="img-div" style="margin-left: 0px;">
									<div id="img-div" class="img-div">
									</div>
									<div onclick="imgClose()" id="img-close" class="img-close" style="display: none;">
										<i>×</i>
									</div>
									<div id="img-click" onclick="imgAdd()">
										<div class="img-border">✚</div>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">图片地址</label>
							<div class="col-sm-2">
								<input id="url" type="text" style="width: 400px;"/>
							</div>
						</div>
						<div class="hr-line-dashed"></div>
						<div class="form-group draggable">
							<div class="col-sm-12 col-sm-offset-3">
								<input class="btn btn-primary" type="button" onclick="getClose()" value="关闭"/>
							</div>
						</div>
					</form>
					<form id="img-form" enctype="multipart/form-data">
						<input type="file" name="file" style="display: none;" onchange="upLode(this)"  id="img-file"/>
					</form>
					<div class="clearfix"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
    function imgAdd() {
        $('#img-file').click();
    }
    function upLode(o) {
        var form = new FormData($('#img-form')[0]);
        $.ajax({
            type: 'post',
            url: '<%=path%>/rest/img/toUpload',
            data: form,
            cache: true,
            dataType: "json",
            async: true,
            processData: false,
            contentType: false,
            beforeSend: function () { },
            success: function (data) {
                if (data) {
                    if(data.code == 'true') {
                        var sHtml = '<img src=' + data.url + ' id="img" style="width:250px; height:250px;" />'
                        $("#img-div").html(sHtml);
                        $('#img-click').hide();
                        $('#img-close').show();
                        $('#url').val(data.url);
                    }
                    else {
                        alert(data.msg)
                    }
                }
                else{
                    alert('图片上传失败');
                }
            },
            error: function () {
                alert('图片上传失败，请检查网络');
            }
        });
    }

    function imgClose() {
        $("#img-div").html('');
        $('#url').val('');
        $('#img-click').show();
        $('#img-close').hide();
    }

    function  getClose() {
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
    }
</script>
</body>

</html>