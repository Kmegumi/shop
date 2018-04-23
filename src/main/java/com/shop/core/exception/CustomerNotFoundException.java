package com.shop.core.exception;


public class CustomerNotFoundException extends RuntimeException{

  private static final long serialVersionUID = 1L;

  public CustomerNotFoundException() {
    super();
  }

  public CustomerNotFoundException(String s, Throwable throwable) {
    super(s, throwable);
  }

  public CustomerNotFoundException(String s) {
    super(s);
  }

  public CustomerNotFoundException(Throwable throwable) {
    super(throwable);
  }
}
