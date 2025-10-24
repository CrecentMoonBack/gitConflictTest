#!/bin/bash

# Git 충돌 재현 시나리오 스크립트
# 2025-10-24 okestro-cmp-java Branch Conflict 재현

set -e  # 에러 발생 시 중단

echo "=========================================="
echo "Git 충돌 시나리오 재현 시작"
echo "=========================================="

# 1. 초기 설정
echo -e "\n[1/15] 초기 레포 설정..."
git checkout -b main 2>/dev/null || git checkout main
git pull origin main 2>/dev/null || echo "새 레포입니다"

# MenuErrorCode.java 파일 생성 (초기 상태 - 122번까지만)
mkdir -p governance/governance-core/src/main/java/com/okestro/governance/menu/enums
cat > governance/governance-core/src/main/java/com/okestro/governance/menu/enums/MenuErrorCode.java << 'EOF'
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
EOF

git add .
git commit -m "Feature: menu 모듈 정보 governance-core으로 이동" || echo "이미 커밋됨"
git push origin main -f 2>/dev/null || echo "Push 건너뜀"

# 2. nam-7391 브랜치 생성 (아이콘 업로드)
echo -e "\n[2/15] nam-7391 브랜치 생성 (아이콘 업로드)..."
git checkout -b feature/CMPMGMT-7391-아이콘-업로드

# 7391: 123, 124, 125번 추가
cat > governance/governance-core/src/main/java/com/okestro/governance/menu/enums/MenuErrorCode.java << 'EOF'
package com.okestro.governance.menu.enums;

import com.okestro.common.code.BaseCode;

public enum MenuErrorCode implements BaseCode {
  MAIN_PAGE_NOT_INCLUDE_MENU_PAGE("GOV-ERR-000100", "메뉴에 메인 페이지가 메뉴 하위 페이지에 포함되지 않았습니다."),
  INVALID_MAPPED_PAGE("GOV-ERR-000101", "연결하려는 페이지가 유효하지 않습니다."),
  INVALID_MENU("GOV-ERR-000105", "메뉴가 유효하지 않습니다."),
  INVALID_PAGE("GOV-ERR-000106", "페이지가 유효하지 않습니다."),
  INVALID_MENU_PARENT_ID("GOV-ERR-000122", "잘못된 메뉴 부모 형식입니다."),
  EXCEED_MENU_ICON_SIZE("GOV-ERR-000123", "메뉴 아이콘은 2MB를 초과 할 수 없습니다."),
  MENU_ICON_UPLOAD_FAILED("GOV-ERR-000124", "메뉴 아이콘 업로드에 실패 했습니다."),
  DUPLICATE_MENU_ICON("GOV-ERR-000125", "이미 존재하는 메뉴 아이콘명 입니다."),
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
EOF

git add .
git commit -m "CMPMGMT-7391(feature): 이용자 정의 메뉴 아이콘 업로드"

# 3. chan-7156 브랜치 생성 (메뉴 목록 조회)
echo -e "\n[3/15] chan-7156 브랜치 생성 (메뉴 목록 조회)..."
git checkout main
git checkout -b feature/CMPMGMT-7156-메뉴-목록-조회-api

# 7156: 123번에 DONT_MODIFY_CLOUD_PLATFORM 추가
cat > governance/governance-core/src/main/java/com/okestro/governance/menu/enums/MenuErrorCode.java << 'EOF'
package com.okestro.governance.menu.enums;

import com.okestro.common.code.BaseCode;

public enum MenuErrorCode implements BaseCode {
  MAIN_PAGE_NOT_INCLUDE_MENU_PAGE("GOV-ERR-000100", "메뉴에 메인 페이지가 메뉴 하위 페이지에 포함되지 않았습니다."),
  INVALID_MAPPED_PAGE("GOV-ERR-000101", "연결하려는 페이지가 유효하지 않습니다."),
  INVALID_MENU("GOV-ERR-000105", "메뉴가 유효하지 않습니다."),
  INVALID_PAGE("GOV-ERR-000106", "페이지가 유효하지 않습니다."),
  INVALID_MENU_PARENT_ID("GOV-ERR-000122", "잘못된 메뉴 부모 형식입니다."),
  DONT_MODIFY_CLOUD_PLATFORM("GOV-ERR-000123", "클라우드 플랫폼 메뉴는 수정, 생성, 삭제 작업은 진행할 수 없습니다."),
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
EOF

git add .
git commit -m "CMPMGMT-7156(feature): 메뉴 목록 조회"

# 4. base와 dev 브랜치 생성
echo -e "\n[4/15] base와 dev 브랜치 생성..."
git checkout main
git checkout -b base
git checkout main
git checkout -b dev

# 5. chan-7156을 dev에 merge
echo -e "\n[5/15] chan-7156을 dev에 merge..."
git checkout dev
git merge feature/CMPMGMT-7156-메뉴-목록-조회-api -m "Merged in feature/CMPMGMT-7156-메뉴-목록-조회-api"

# 6. chan-7156을 base에 merge
echo -e "\n[6/15] chan-7156을 base에 merge..."
git checkout base
git merge feature/CMPMGMT-7156-메뉴-목록-조회-api -m "Merged in feature/CMPMGMT-7156-메뉴-목록-조회-api"

# 7. nam-7391을 base에 merge (충돌 발생 → 해결)
echo -e "\n[7/15] nam-7391을 base에 merge (충돌 해결)..."
git checkout feature/CMPMGMT-7391-아이콘-업로드
git merge base -m "Merge base into 7391" || true

# 충돌 해결: 123번을 DONT_MODIFY로 유지하고, 124, 125, 126 추가
cat > governance/governance-core/src/main/java/com/okestro/governance/menu/enums/MenuErrorCode.java << 'EOF'
package com.okestro.governance.menu.enums;

import com.okestro.common.code.BaseCode;

public enum MenuErrorCode implements BaseCode {
  MAIN_PAGE_NOT_INCLUDE_MENU_PAGE("GOV-ERR-000100", "메뉴에 메인 페이지가 메뉴 하위 페이지에 포함되지 않았습니다."),
  INVALID_MAPPED_PAGE("GOV-ERR-000101", "연결하려는 페이지가 유효하지 않습니다."),
  INVALID_MENU("GOV-ERR-000105", "메뉴가 유효하지 않습니다."),
  INVALID_PAGE("GOV-ERR-000106", "페이지가 유효하지 않습니다."),
  INVALID_MENU_PARENT_ID("GOV-ERR-000122", "잘못된 메뉴 부모 형식입니다."),
  DONT_MODIFY_CLOUD_PLATFORM("GOV-ERR-000123", "클라우드 플랫폼 메뉴는 수정, 생성, 삭제 작업은 진행할 수 없습니다."),
  EXCEED_MENU_ICON_SIZE("GOV-ERR-000124", "메뉴 아이콘은 2MB를 초과 할 수 없습니다."),
  MENU_ICON_UPLOAD_FAILED("GOV-ERR-000125", "메뉴 아이콘 업로드에 실패 했습니다."),
  DUPLICATE_MENU_ICON("GOV-ERR-000126", "이미 존재하는 메뉴 아이콘명 입니다."),
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
EOF

git add .
git commit -m "Resolve conflict: 7391 + 7156 통합" || echo "이미 해결됨"

# 8. nam-7391을 base에 merge
echo -e "\n[8/15] nam-7391을 base에 merge..."
git checkout base
git merge feature/CMPMGMT-7391-아이콘-업로드 -m "Merged in feature/CMPMGMT-7391-아이콘-업로드"

# 9. nam-7391을 dev에도 merge
echo -e "\n[9/15] nam-7391을 dev에도 merge..."
git checkout dev
git merge feature/CMPMGMT-7391-아이콘-업로드 -m "Merged in feature/CMPMGMT-7391-아이콘-업로드"

echo -e "\n=========================================="
echo "현재 상태:"
echo "base: 123(DONT), 124(EXCEED), 125(UPLOAD), 126(DUPLICATE)"
echo "dev:  123(DONT), 124(EXCEED), 125(UPLOAD), 126(DUPLICATE)"
echo "=========================================="

# 10. 🔴 핵심: nam-7392 브랜치 생성 (아이콘 삭제)
echo -e "\n[10/15] 🔴 nam-7392 브랜치 생성 (아이콘 삭제)..."
git checkout base
git checkout -b feature/CMPMGMT-7392-아이콘-삭제

# 7392: 125를 DELETE_FAILED로 변경, 127에 DUPLICATE 이동
cat > governance/governance-core/src/main/java/com/okestro/governance/menu/enums/MenuErrorCode.java << 'EOF'
package com.okestro.governance.menu.enums;

import com.okestro.common.code.BaseCode;

public enum MenuErrorCode implements BaseCode {
  MAIN_PAGE_NOT_INCLUDE_MENU_PAGE("GOV-ERR-000100", "메뉴에 메인 페이지가 메뉴 하위 페이지에 포함되지 않았습니다."),
  INVALID_MAPPED_PAGE("GOV-ERR-000101", "연결하려는 페이지가 유효하지 않습니다."),
  INVALID_MENU("GOV-ERR-000105", "메뉴가 유효하지 않습니다."),
  INVALID_PAGE("GOV-ERR-000106", "페이지가 유효하지 않습니다."),
  INVALID_MENU_PARENT_ID("GOV-ERR-000122", "잘못된 메뉴 부모 형식입니다."),
  DONT_MODIFY_CLOUD_PLATFORM("GOV-ERR-000123", "클라우드 플랫폼 메뉴는 수정, 생성, 삭제 작업은 진행할 수 없습니다."),
  EXCEED_MENU_ICON_SIZE("GOV-ERR-000124", "메뉴 아이콘은 2MB를 초과 할 수 없습니다."),
  MENU_ICON_UPLOAD_FAILED("GOV-ERR-000125", "메뉴 아이콘 업로드에 실패 했습니다."),
  MENU_ICON_DELETE_FAILED("GOV-ERR-000126", "메뉴 아이콘 삭제에 실패 했습니다."),
  DUPLICATE_MENU_ICON("GOV-ERR-000127", "이미 존재하는 메뉴 아이콘명 입니다."),
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
EOF

git add .
git commit -m "CMPMGMT-7392(feature): 메뉴 아이콘 파일 삭제"

# 11. 🔴 7392를 base에만 merge (dev에는 안 함!)
echo -e "\n[11/15] 🔴 7392를 base에만 merge (dev는 건너뜀!)..."
git checkout base
git merge feature/CMPMGMT-7392-아이콘-삭제 -m "Merged in feature/CMPMGMT-7392-아이콘-삭제"

echo -e "\n=========================================="
echo "🔴 중요: 7392를 dev에 merge하지 않음!"
echo "base: 123(DONT), 124(EXCEED), 125(UPLOAD), 126(DELETE), 127(DUPLICATE)"
echo "dev:  123(DONT), 124(EXCEED), 125(UPLOAD), 126(DUPLICATE) ← 127 없음!"
echo "=========================================="

# 12. fin 파일 생성 (인벤토리 작업용)
echo -e "\n[12/15] 인벤토리 파일 생성..."
git checkout base
mkdir -p inventory
echo "Inventory initial data" > inventory/fin.txt
git add .
git commit -m "Add inventory file for testing"

# 13. 🔴 yeom-6543 브랜치 생성 (base에서!)
echo -e "\n[13/15] 🔴 yeom-6543 브랜치 생성 (7392 포함된 base에서!)..."
git checkout -b feature/CMPMGMT-6543-be-region-선택---aws

echo -e "\n현재 yeom-6543 브랜치의 MenuErrorCode 상태:"
grep "GOV-ERR-00012[56]" governance/governance-core/src/main/java/com/okestro/governance/menu/enums/MenuErrorCode.java

# 14. 인벤토리 작업 (MenuErrorCode는 건드리지 않음)
echo -e "\n[14/15] 인벤토리 작업..."
echo "Region selection feature implementation" >> inventory/fin.txt
git add .
git commit -m "CMPMGMT-6543(feature): AWS region 선택 기능"

# 15. 🔴 dev merge 시도 → 충돌 발생!
echo -e "\n[15/15] 🔴 dev merge 시도 → 충돌 발생!"
echo -e "\n=========================================="
echo "충돌 발생 지점!"
echo "=========================================="
echo -e "\nyeom-6543 브랜치 상태:"
grep "GOV-ERR-00012[567]" governance/governance-core/src/main/java/com/okestro/governance/menu/enums/MenuErrorCode.java || true

echo -e "\ndev 브랜치 상태:"
git show dev:governance/governance-core/src/main/java/com/okestro/governance/menu/enums/MenuErrorCode.java | grep "GOV-ERR-00012[567]" || true

echo -e "\n이제 dev를 merge합니다..."
set +e  # 충돌 발생 예상이므로 에러 무시
git merge dev -m "Merge dev into 6543"

if [ $? -ne 0 ]; then
  echo -e "\n=========================================="
  echo "✅ 충돌 발생 확인!"
  echo "=========================================="
  echo -e "\n충돌 파일:"
  git status | grep "both modified"

  echo -e "\n충돌 내용:"
  cat governance/governance-core/src/main/java/com/okestro/governance/menu/enums/MenuErrorCode.java | grep -A5 -B5 "<<<<<<<"

  echo -e "\n=========================================="
  echo "설명:"
  echo "- yeom-6543(HEAD): 126번 = DELETE_FAILED (7392 포함)"
  echo "- dev:             126번 = DUPLICATE_MENU_ICON (7392 미포함)"
  echo "- Git: 같은 라인에 다른 내용 → CONFLICT!"
  echo "=========================================="
else
  echo "❌ 충돌이 발생하지 않았습니다. 시나리오 재확인 필요"
fi

echo -e "\n=========================================="
echo "시나리오 재현 완료!"
echo "=========================================="
