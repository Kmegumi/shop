<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    /**登录相关**/
    $(document).ready(function () {
        $("#open-login-personal").click(function () {
            redirectUrl = "<%=path%>/rest/front/personal"
            if(loginStatus == 1) {
                location.href=redirectUrl;
            }else if(loginStatus == 2 || loginStatus == 0){
                isExecFunction = true;
                $.popup('.popup-login');
            }else {
                return;
            }
        });
        $("#open-login-trade").click(function () {
            redirectUrl = "<%=path%>/rest/front/orderList";
            if(loginStatus == 1) {
                location.href=redirectUrl;
            }else if(loginStatus == 2 || loginStatus == 0){
                isExecFunction = true;
                $.popup('.popup-login');
            }else {
                return;
            }
        });
    });
    function loginSuccess(){
        location.href=redirectUrl;
    }

</script>
