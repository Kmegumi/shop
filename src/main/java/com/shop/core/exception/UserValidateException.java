package com.shop.core.exception;


public class UserValidateException extends RuntimeException{

  private static final long serialVersionUID = 1L;

  public UserValidateException() {
    super();
  }

  public UserValidateException(String s, Throwable throwable) {
    super(s, throwable);
  }

  public UserValidateException(String s) {
    super(s);
  }

  public UserValidateException(Throwable throwable) {
    super(throwable);
  }
}
