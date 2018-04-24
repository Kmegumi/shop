<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="utf-8">
<title>商城</title>
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<link rel="stylesheet" href="//g.alicdn.com/msui/sm/0.6.2/css/sm.min.css">
<link rel="stylesheet" href="<%=path %>/static/front/css/main.css">
<link rel="stylesheet" href="//g.alicdn.com/msui/sm/0.6.2/css/sm-extend.min.css">
<link rel="stylesheet" href="http://static.shands.cn/common/frozenui-1.3.0/css/table.css">
<link href="<%=path %>/static/Hplus/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
<script type='text/javascript' src='//g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm.min.js' charset='utf-8'></script>
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm-extend.min.js' charset='utf-8'></script>
<script type='text/javascript' src='<%=path %>/static/js/jquery.min.js' charset='utf-8'></script>
<script src="<%=path %>/static/Hplus/js/plugins/sweetalert/sweetalert.min.js"></script>
<style>
    .buttons-tab .button.active{color: #FA725A;    border-color: #FA725A;}
    .wait {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: url(/static/css/loading2.svg) no-repeat center center;
        background-color: #000;
        filter:Alpha(opacity=50);
        opacity: .5;
        text-align: center;
        font-size: 1.5rem;
    }
    .detailRight-row3Left{
        -prefix-box-flex: 2;-webkit-box-flex: 2;-webkit-flex: 2;-moz-box-flex: 2;-ms-flex: 2;flex: 2;
    }
</style>
<script>
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