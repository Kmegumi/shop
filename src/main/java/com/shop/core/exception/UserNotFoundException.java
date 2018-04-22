package com.shop.core.exception;


public class UserNotFoundException extends RuntimeException{

  private static final long serialVersionUID = 1L;

  public UserNotFoundException() {
    super();
  }

  public UserNotFoundException(String s, Throwable throwable) {
    super(s, throwable);
  }

  public UserNotFoundException(String s) {
    super(s);
  }

  public UserNotFoundException(Throwable throwable) {
    super(throwable);
  }
}
