# Git 충돌 재현 시나리오

2025-10-24 okestro-cmp-java에서 발생한 MenuErrorCode 충돌을 정확히 재현하는 스크립트입니다.

## 사전 준비

1. GitHub에 `gitConflictTest` 레포 생성 완료
2. Git Bash 설치 (Windows) 또는 터미널 (Mac/Linux)

## 실행 방법

### 1. 레포 클론
```bash
cd ~/Desktop
git clone https://github.com/YOUR_USERNAME/gitConflictTest.git
cd gitConflictTest
```

### 2. 스크립트 복사
이 디렉토리의 `setup-conflict-scenario.sh` 파일을 `gitConflictTest` 디렉토리에 복사

### 3. 스크립트 실행 (Git Bash)
```bash
# Windows Git Bash
bash setup-conflict-scenario.sh

# Mac/Linux
chmod +x setup-conflict-scenario.sh
./setup-conflict-scenario.sh
```

## 시나리오 단계별 설명

### Phase 1: 초기 설정 (1-9단계)
1. **초기 상태**: MenuErrorCode 122번까지만 존재
2. **nam-7391** (아이콘 업로드): 123, 124, 125 추가
3. **chan-7156** (메뉴 목록): 123 추가 (충돌!)
4. **base/dev 브랜치** 생성
5. chan-7156을 dev에 merge
6. chan-7156을 base에 merge
7. nam-7391과 base 충돌 해결 (123을 DONT_MODIFY로, 124-126 추가)
8. nam-7391을 base에 merge
9. nam-7391을 dev에 merge

**결과:**
- base: 123(DONT), 124(EXCEED), 125(UPLOAD), 126(DUPLICATE)
- dev: 123(DONT), 124(EXCEED), 125(UPLOAD), 126(DUPLICATE)
- ✅ 동기화 상태

### Phase 2: 문제 발생 (10-11단계)
10. **nam-7392** (아이콘 삭제): base에서 브랜치 생성
    - 125: UPLOAD → 유지
    - 126: DUPLICATE → DELETE로 변경
    - 127: DUPLICATE 새로 추가
11. **🔴 7392를 base에만 merge** (dev는 건너뜀!)

**결과:**
- base: 123(DONT), 124(EXCEED), 125(UPLOAD), 126(DELETE), 127(DUPLICATE)
- dev: 123(DONT), 124(EXCEED), 125(UPLOAD), 126(DUPLICATE) ← 127 없음!
- ❌ **동기화 깨짐!**

### Phase 3: 충돌 발생 (12-15단계)
12. inventory/fin.txt 파일 생성 (base)
13. **🔴 yeom-6543**: 7392가 반영된 base에서 브랜치 생성
    - 이 시점에 126=DELETE, 127=DUPLICATE 포함
14. 인벤토리 작업 (MenuErrorCode는 건드리지 않음)
15. **🔴 dev merge 시도 → 충돌 발생!**

```
<<<<<<< HEAD (yeom-6543에서 온 것 - base 기반)
MENU_ICON_DELETE_FAILED("GOV-ERR-000126", ...),
DUPLICATE_MENU_ICON("GOV-ERR-000127", ...),
=======
DUPLICATE_MENU_ICON("GOV-ERR-000126", ...),
>>>>>>> dev
```

## 충돌이 발생하는 이유 (Git 3-way Merge)

Git은 세 가지를 비교합니다:

1. **Common Ancestor (Merge Base)**
   - 7391 + 7156 통합 상태
   - 126: DUPLICATE_MENU_ICON

2. **yeom-6543 (HEAD)**
   - base에서 생성 → 7392 포함
   - 126: MENU_ICON_DELETE_FAILED
   - 127: DUPLICATE_MENU_ICON

3. **dev**
   - 7392 미포함
   - 126: DUPLICATE_MENU_ICON
   - 127번 없음

Git: "126번 라인이 서로 다르네? → CONFLICT!"

## 핵심 포인트

### ❌ 잘못된 이해
"yeom-6543이 MenuErrorCode를 수정하지 않았으니 충돌이 안 난다"

### ✅ 올바른 이해
"yeom-6543이 직접 수정하지 않았어도, base에서 브랜치를 딴 시점에 7392를 포함하고 있었음. dev는 7392가 없어서 126번 라인이 다름 → 충돌 발생"

## 충돌 확인 명령어

```bash
# 충돌 상태 확인
git status

# yeom-6543 브랜치 상태
git show HEAD:governance/.../MenuErrorCode.java | grep "GOV-ERR-00012[67]"

# dev 브랜치 상태
git show dev:governance/.../MenuErrorCode.java | grep "GOV-ERR-00012[67]"

# Merge Base 확인
git merge-base HEAD dev
git show $(git merge-base HEAD dev):governance/.../MenuErrorCode.java | grep "GOV-ERR-00012[67]"
```

## 충돌 해결 방법

```bash
# 수동 해결
# MenuErrorCode.java 파일 편집 후
git add governance/governance-core/src/main/java/com/okestro/governance/menu/enums/MenuErrorCode.java
git commit -m "Resolve conflict: sync error codes"
```

## 예방 방법

1. **정기적인 동기화**: base와 dev를 주기적으로 동기화
2. **PR 순서 관리**: base에 merge 시 dev에도 함께 merge
3. **에러 코드 관리**: enum 번호를 중앙에서 관리

## 브랜치 상태 시각화

```bash
# 전체 히스토리 그래프
git log --all --graph --oneline --decorate

# MenuErrorCode 변경 히스토리만
git log --all --graph --oneline -- governance/.../MenuErrorCode.java
```

## 참고자료

- [Confluence 문서: 2025-10-24 okestro-cmp-java Branch Conflict 보고서](링크)
- Git 3-way Merge: https://git-scm.com/docs/git-merge#_three_way_merge
