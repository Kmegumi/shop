<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String path = request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>拼购商城</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" href="//g.alicdn.com/msui/sm/0.6.2/css/sm.min.css">
    <link rel="stylesheet" href="<%=path %>/static/front/css/main.css">
    <link rel="stylesheet" href="//g.alicdn.com/msui/sm/0.6.2/css/sm-extend.min.css">
    <link rel="stylesheet" href="http://static.shands.cn/common/frozenui-1.3.0/css/table.css">
    <style>
        .errorContent {  position: absolute;  top: 0;  bottom: 0;  left: 0;  right: 0;  margin: auto;  height: 5.2rem;  width: 70%;  text-align: center;  }
        .error-font{  position: absolute;  bottom: 0;  left: 0;  right: 0;  font-size: 0.7rem;  color: #666;  }
    </style>
</head>
<body>
<div class="page-group">
    <form id="toCheck" style="display: none" method="post" action="/rest/front/checkOrder" >
        <input name="goodsId" id="goodsId" value="${dome.goodsId}" />
        <input name="specificationId" id="specificationId" value="${dome.specificationId}"/>
        <input name="num" id="num" value="${dome.num}"/>
        <input name="orderTypeEnum" id="orderTypeEnum" value="${dome.orderTypeEnum.name()}"/>
        <input name="message" id="message" value="${dome.message}"/>
        <input name="payWayEnum" id="payWayEnum" value="${dome.payWayEnum}"/>
        <input name="invoiceType" id="invoiceType" value="${dome.invoiceType}"/>
        <input name="invoiceId" id="invoiceId" value="${dome.invoiceId}"/>
        <input name="addressId" id="addressId" value="${dome.addressId}"/>
        <input name="teamOrderId" id="teamOrderId" value="${dome.teamOrderId}"/>
    </form>
    <div class="page page-current" id='router'>
        <header class="bar bar-nav header-z">
            <a class="icon icon-left pull-left" onclick="toorder()"></a>
            <h1 class="title">我的地址</h1>
        </header>
        <div class="content" id="detail">
            <c:forEach items="${list}" var="address">
                <div class="order-detail order-detail_c" >
                    <div style="overflow: hidden;-prefix-box-flex: 1;-webkit-box-flex: 1;-webkit-flex: 1;-moz-box-flex: 1;-ms-flex: 1;flex: 1;display:-webkit-box;display:-moz-box;display:-webkit-flex;display:-moz-flex;display:-ms-flexbox;display: flex;"  onclick="getAddressToOrder(${address.id})">
                        <div class="order-detailLeft">
                            <div class="detailLeft-top">${address.name}</div>
                            <c:if test="${address.defaultFlag}"><div class="detailLeft-bottom">默认</div></c:if>
                        </div>
                        <div class="order-detailRight">
                            <div class="detailRight_f" style="font-size: 0.75rem;color: #333;  margin-bottom: 0.4rem;    height: 1rem;">
                                <div class="f_left">${address.tel}</div>
                            </div>
                            <div class="detailRight_f" style="font-size: 0.65rem;color: #666;  margin-bottom: 0.4rem;">
                                <div  class="f_left_c">${address.addressAll}</div>
                            </div>
                        </div>
                    </div>
                    <%--<div class="f_right"><img src="<%=path%>/static/front/img/edit.png" alt=""></div>--%>
                </div>
            </c:forEach>
            <div class="address-footer" onclick="addAddress()">新增地址</div>
        </div>
    </div>
</div>
<script type='text/javascript' src='//g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm.min.js' charset='utf-8'></script>
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm-extend.min.js' charset='utf-8'></script>
<script type="text/javascript" src="//g.alicdn.com/msui/sm/0.6.2/js/sm-city-picker.min.js" charset="utf-8"></script>
<script type='text/javascript' src='<%=path %>/static/js/jquery.min.js' charset='utf-8'></script>
<script>
    var $j = jQuery.noConflict(); //自定义一个比较短快捷方式
    $j(function() {
        $.init();
    })
    function addAddress() {
        addflag = true;
        var html = '';
        html += '<div class="addAddress-row"><input type="hidden" id="addressId" value=""><input type="text" id="addressName" placeholder="姓名"></div>';
        html += '<div class="addAddress-row"><input type="tel" id="addressTel" placeholder="手机号码"></div>';
        html += '<div class="addAddress-row"><input type="text" id="city-picker" value="" placeholder="省份、城市、区县"/></div>';
        html += '<div class="addAddress-row"><input type="text" id="addressDetail" placeholder="详细地址（如街道、楼盘号等）"></div>';
        html += '<div class="default" id="default"  data-type="no">';
        html += '<div class="default-font">设为默认地址</div>';
        html += '</div>';
        html += '<div class="address-footer" onclick="saveAddress()">保存</div>';
        document.getElementById('detail').innerHTML = html;
        $.init();
        $("#city-picker").cityPicker({
            toolbarTemplate: '<header class="bar bar-nav">\
            <button class="button button-link pull-right close-picker">确定</button>\
            <h1 class="title">选择收货地址</h1>\
            </header>'
        });
    }

    var addflag = true;
    $("#default").live("click",function(){
        var type = $(this).attr("data-type");
        if(type == 'no'){
            $(".default-font").css({
                "background":"url(<%=path %>/static/front/img/Icon_Radio_Active.png) left no-repeat",
                "background-size":"contain"
            });
            $(this).attr("data-type", 'yes')
        } else{
            $(".default-font").css({
                "background":"url(<%=path %>/static/front/img/Icon_Radio_Inactive.png) left no-repeat",
                "background-size":"contain"
            });
            $(this).attr("data-type", 'no')
        }
    })

    function saveAddress() {
        var addressName = document.getElementById('addressName').value;
        if (addressName == null || addressName.trim() == '') {
            alert('请填写姓名');
            return false;
        }
        var addressTel = document.getElementById('addressTel').value;
        if (addressTel == null || addressTel.trim() == '') {
            alert('请填写电话');
            return false;
        }
        var city = document.getElementById('city-picker').value;
        if (city == null || city.trim() == '') {
            alert('请选择城市');
            return false;
        }
        var addressDetail = document.getElementById('addressDetail').value;
        if (addressDetail == null || addressDetail.trim() == '') {
            alert('请填写详细地址');
            return false;
        }
        var type = $('#default').attr('data-type');
        var falg = true;
        if (type == 'yes') {
            falg = true;
        } else if (type == 'no') {
            falg = false;
        }
        if (addflag) {
            addflag = false;
        } else {
            return false;
        }
        $.ajax({
            type: 'post',
            url: '/rest/front/saveAddress',
            data: {name:addressName, tel:addressTel, city:city, detail:addressDetail, defaultFlag:falg,},
            cache: false,
            dataType: "json",
            async: true,
            success: function (data) {
                if (data) {
                    if (data.code == '1000') {
                        getList();
                        //跳转支付页面
                    } else if (data.code == '1100') {
                        //弹出登录
                    } else {
                        alert(data.code);
                    }
                }
            },
            error: function () {
                alert('订单提交失败')
                addflag = true;
            }
        });
    }

    function getList() {
        $.ajax({
            type: 'post',
            url: '/rest/front/addressList',
            data: {},
            cache: false,
            dataType: "html",
            async: true,
            success: function (data) {
                if (data) {
                    document.getElementById('detail').innerHTML = data;
                }
            },
            error: function () {
                alert('订单提交失败')
            }
        });
    }

    function getAddressToOrder(o) {
        document.getElementById('addressId').value = o;
        $.ajax({
            type: 'post',
            url: '/rest/front/checkAddressTel',
            data: {id:o},
            cache: false,
            dataType: "json",
            async: true,
            success: function (data) {
                if (data) {
                    if (data.code == '1000') {
                        document.getElementById('toCheck').submit();
                    } else if (data.code == '1001') {
                        var end = confirm(data.message);
                        if (end) {
                            document.getElementById('toCheck').submit();
                        } else {
                            return false;
                        }
                    } else {
                        alert(data.message);
                    }
                }
            },
            error: function () {
                alert('选择地址失败。请检查你的网络！')
            }
        });

    }

    function toorder() {
        document.getElementById('toCheck').submit();
    }
    
</script>
</body>
</html>
