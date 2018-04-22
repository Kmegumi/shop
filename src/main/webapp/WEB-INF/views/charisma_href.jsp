<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<link href="<%=path %>/static/Hplus/css/bootstrap.min.css?v=3.3.5" rel="stylesheet">
<link href="<%=path %>/static/Hplus/css/animate.min.css" rel="stylesheet">
<link href="<%=path %>/static/Hplus/css/style.min.css?v=4.0.0" rel="stylesheet">
<link href="<%=path %>/static/Hplus/js/plugins/layer/layim/layim.css" rel="stylesheet">
<link href="<%=path %>/static/Hplus/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
<link href="<%=path %>/static/Hplus/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
<script src="<%=path %>/static/Hplus/js/plugins/sweetalert/sweetalert.min.js"></script>
<script src="<%=path %>/static/Hplus/js/content.min.js?v=1.0.0"></script>
<script src="<%=path %>/static/Hplus/js/jquery.min.js?v=2.1.4"></script>
<script src="<%=path %>/static/Hplus/js/bootstrap.min.js?v=3.3.5"></script>
<script src="<%=path %>/static/Hplus/js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="<%=path %>/static/Hplus/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="<%=path %>/static/Hplus/js/plugins/layer/layer.min.js"></script>
<script src="<%=path %>/static/Hplus/js/hplus.min.js?v=4.0.0"></script>
<script src="<%=path %>/static/Hplus/js/contabs.min.js"></script>
<script src="<%=path %>/static/Hplus/js/plugins/pace/pace.min.js"></script>
<script src="<%=path %>/static/Hplus/js/plugins/validate/jquery.validate.min.js"></script>
<script src="<%=path %>/static/Hplus/js/plugins/validate/messages_zh.min.js"></script>
<script type="text/javascript" src="<%=path%>/static/My97DatePicker/WdatePicker.js" defer="defer"></script>
<script src="<%=path %>/static/Hplus/js/plugins/iCheck/icheck.min.js"></script>
<!-- Bootstrap table -->
<script src="<%=path %>/static/Hplus/js/plugins/bootstrap-table/bootstrap-table.min.js"></script>
<script src="<%=path %>/static/Hplus/js/plugins/bootstrap-table/bootstrap-table-mobile.min.js"></script>
<script src="<%=path %>/static/Hplus/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
<script src="<%=path %>/static/Hplus/js/ajaxfileupload.js?v=1.0.0"></script>
<script>
    $(function(){
        $(":reset").click(function(){
            history.back(-1);
        });
        $("#addForm").validate();
    })


    //表单验证样式
    $.validator.setDefaults({

        highlight: function(e) {
            $(e).closest(".form-group").removeClass("has-success").addClass("has-error")
        },
        success: function(e) {
            e.closest(".form-group").removeClass("has-error").addClass("has-success")
        },
        errorElement: "span",
        errorPlacement: function(e, r) {
            e.appendTo(r.is(":radio") || r.is(":checkbox") ? r.parent().parent().parent() : r.parent())
        },
        errorClass: "help-block m-b-none",
        validClass: "help-block m-b-none",
        submitHandler: function() {
            add();
        }
    })
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
    Date.prototype.Format = function (fmt) { //author: meizz
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "h+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    };

    function formatTime(time, text) {
        var data = new Date(time);
        if (typeof(text) == 'undefined') {
            document.write(data.Format("yyyy/MM/dd hh:mm"))
        } else {
            document.write(data.Format(text));
        }
    }

    function getFormatTime(time, text) {
        var data = new Date(time);
        if (typeof(text) == 'undefined') {
            return data.Format("yyyy/MM/dd hh:mm");
        } else {
            return data.Format(text);
        }
    }
</script>