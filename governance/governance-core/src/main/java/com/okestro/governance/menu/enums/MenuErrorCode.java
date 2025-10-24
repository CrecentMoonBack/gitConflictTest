package com.okestro.governance.menu.enums;

import com.okestro.common.code.BaseCode;

public enum MenuErrorCode implements BaseCode {
  MAIN_PAGE_NOT_INCLUDE_MENU_PAGE("GOV-ERR-000100", "메뉴에 메인 페이지가 메뉴 하위 페이지에 포함되지 않았습니다."),
  INVALID_MAPPED_PAGE("GOV-ERR-000101", "연결하려는 페이지가 유효하지 않습니다."),
  INVALID_MENU("GOV-ERR-000105", "메뉴가 유효하지 않습니다."),
  INVALID_PAGE("GOV-ERR-000106", "페이지가 유효하지 않습니다."),
  INVALID_MENU_PARENT_ID("GOV-ERR-000122", "잘못된 메뉴 부모 형식입니다."),
  ;

  private final String code;
  private final String message;

  MenuErrorCode(String code, String message) {
    this.code = code;
    this.message = message;
  }

  @Override
  public String getCode() {
    return this.code;
  }

  @Override
  public String getMessage() {
    return this.message;
  }

  @Override
  public String getModule() {
    return "governance:menu";
  }

  @Override
  public CodeType getCodeType() {
    return CodeType.ERROR;
  }
}
