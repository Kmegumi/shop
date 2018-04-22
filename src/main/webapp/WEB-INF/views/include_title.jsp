<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<link href="<%=path %>/static/Hplus/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="<%=path %>/static/Hplus/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
<link href="<%=path %>/static/Hplus/css/animate.min.css" rel="stylesheet">
<link href="<%=path %>/static/Hplus/css/style.min.css?v=4.1.0" rel="stylesheet">
<link href="<%=path %>/static/Hplus/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">

<link href="<%=path %>/static/Hplus/css/plugins/iCheck/custom.css" rel="stylesheet">


<!-- Data Tables -->
<link href="<%=path %>/static/Hplus/css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">

<script src="<%=path %>/static/Hplus/js/plugins/dataTables/jquery.dataTables.js"></script>
<script src="<%=path %>/static/Hplus/js/plugins/dataTables/dataTables.bootstrap.js"></script>

<script src="<%=path %>/static/Hplus/js/plugins/sweetalert/sweetalert.min.js"></script>

<script src="<%=path %>/static/Hplus/js/jquery.min.js?v=2.1.4"></script>
<script src="<%=path %>/static/Hplus/js/bootstrap.min.js?v=3.3.6"></script>
<script src="<%=path %>/static/Hplus/js/content.min.js?v=1.0.0"></script>
<script src="<%=path %>/static/Hplus/js/plugins/iCheck/icheck.min.js"></script>
<style>
    .wait {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: url("<%=path %>/static/css/wait.gif") no-repeat center center;
        background-color: #000;
        opacity: .5;
        text-align: center;
        font-size: 1.5rem;
    }
    .selectCss{
        width: 200px;padding: 6px 12px;border: 1px solid #e5e6e7;border-radius: 1px;background-color: #FFF;background-image: none;font-size: 14px;
    }
</style>
<script>
    function getToken() {
        $.ajax({
            type: 'POST',
            url: '<%=path %>/rest/token',
            cache: false,
            dataType: "json",
            async: true,
            beforeSend: function () { },
            success: function (data) {
                if (data) {
                    if (data.code == 'token') {
                        $('#token').val(data.msg);
                    }
                }
            },
            error: function () { }
        });
    }
</script>