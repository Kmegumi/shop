package com.shop.primary.pojo.vo;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * Created by Dell on 2017/9/13.
 */
public class ResultCodeVO {

    private String code;

    @JSONField(name = "msg")
    private String message;

    public final static ResultCodeVO ERR_CODE = new ResultCodeVO("-1", "CSRF ERROR:无效的token，或者token过期");

    public final static ResultCodeVO UN_LOGIN_CODE = new ResultCodeVO("-2", "你的登录信息已过期，请重新登录");

    public final static ResultCodeVO NO_PERMISSION = new ResultCodeVO("-3", "你的权限不足,请联系管理员");

    public final static ResultCodeVO LOGIN_SUCCESS = new ResultCodeVO("200", "");

    public final static ResultCodeVO PASSWORD_ERROR = new ResultCodeVO("201", "用户名或密码错误，请重试!");

    public final static ResultCodeVO PASSWORD_NULL = new ResultCodeVO("202", "用户名或密码为空，请输入完整后再试!");

    public final static ResultCodeVO ACCOUNT_ERR = new ResultCodeVO("203", "账号异常，请联系管理员处理!");

    public ResultCodeVO() {

    }

    public ResultCodeVO(String code, String message) {
        this.code = code;
        this.message = message;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

}
