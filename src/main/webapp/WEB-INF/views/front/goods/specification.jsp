<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .checkStyle{
        border: 1px solid #51A3CC;
        background-color:#51A3CC;
        color: white;
    }
    .swiper-container{
        padding-bottom: 0;
    }
    .swiper-slide img{
        width: 100%;
        height: 10.55rem;
    }
    .m3_w{
        padding: 0.25rem;
    }
</style>
<div class="popup popup-about3 " style="bottom: 0px;height: auto;padding-bottom: 3rem;top: auto;">
    <div class="close-popup close-change" id="clear">×</div>
    <!--引用orderDetail2开始-->
    <div class="standard">
        <div class="standard-left">数量：</div>
        <div class="standard-right" id="numChuang">
            <input type="text" id="num" class="spinner"/>
        </div>

    </div>
    <a href="#" class="popup-footer" onclick="checkOrder()">立即下单</a>
</div>
<form id="payForm" method="GET" action="/rest/front/checkOrder" style="display: none">
    <input id="goodsId" name="goodsId" value="${goods.id}" />
    <input id="goodsNum" name="goodsNum" value="" />
</form>
<script type="text/javascript" src="<%=path%>/static/front/js/jquery.spinner.js"></script>
<script>
    var $j = jQuery.noConflict(); //自定义一个比较短快捷方式
    $j(function() {
        $.init();
    })
    $j( "#num" ).spinner({max : ${goods.goodsStock}});
    $('.open-about3').on('click', function () {
        $.popup('.popup-about3');
    });
    function checkOrder() {
        var num = document.getElementById('num').value;
        if (num == null || num == '') {
            alert('请选择数量!');
            return false;
        }
        $.ajax({
            type: 'post',
            url: '/rest/front/loginStatus',
            data: {},
            cache: true,
            dataType: "json",
            async: true,
            success: function (data) {
                if (data) {
                    if (data.code == '200') {
                        var num = document.getElementById('num').value;
                        if (parseInt(num) < 1) {
                            alert('请输入正确的购买数量！')
                            return false;
                        }
                        document.getElementById('goodsNum').value = num;
                        $('#payForm').submit();
                        //submit购买信息
                    } else {
                        $.popup('.popup-login');
                    }
                }
            },
            error: function () {
                alert('检查登录状态失败')
            }
        });
    }
</script>
