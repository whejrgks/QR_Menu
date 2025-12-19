# 테스트 케이스 문서

PRD의 Gherkin 시나리오를 기반으로 작성된 테스트 케이스입니다.

## 1. 고객용 모바일 메뉴판 테스트

### TC-001: 고객이 QR 코드로 메뉴를 조회한다

**Gherkin 시나리오:**
```gherkin
Scenario: 고객이 QR 코드로 메뉴를 조회한다
  Given 고객이 QR 코드를 스캔했을 때
  When 메뉴 화면이 로드되면
  Then 판매 중인 메뉴 목록이 표시되어야 한다
```

**테스트 파일:** `test/unit/menu_service_test.dart`, `test/widget/menu_list_screen_test.dart`

**검증 사항:**
- [ ] 메뉴 서비스가 판매 중인 메뉴 목록을 반환하는가?
- [ ] 메뉴 목록 화면이 정상적으로 표시되는가?
- [ ] 판매 중인 메뉴만 표시되는가? (품절 메뉴 제외)

---

### TC-002: 고객이 메뉴 상세 정보를 확인한다

**Gherkin 시나리오:**
```gherkin
Scenario: 고객이 메뉴 상세 정보를 확인한다
  Given 고객이 메뉴 목록을 보고 있을 때
  When 특정 메뉴를 선택하면
  Then 메뉴 이미지, 가격, 설명, 알레르기 정보가 표시되어야 한다
```

**테스트 파일:** `test/unit/menu_detail_test.dart`, `test/widget/menu_detail_screen_test.dart`

**검증 사항:**
- [ ] 메뉴 서비스가 특정 메뉴 ID로 메뉴 정보를 반환하는가?
- [ ] 메뉴 상세 화면에 이미지가 표시되는가?
- [ ] 메뉴 가격이 표시되는가?
- [ ] 메뉴 설명이 표시되는가?
- [ ] 알레르기 정보가 표시되는가?

---

### TC-003: 품절 메뉴는 노출되지 않는다

**Gherkin 시나리오:**
```gherkin
Scenario: 품절 메뉴는 노출되지 않는다
  Given 메뉴가 품절 상태일 때
  When 고객이 메뉴판을 조회하면
  Then 해당 메뉴는 비활성화되거나 숨김 처리되어야 한다
```

**테스트 파일:** `test/unit/out_of_stock_test.dart`

**검증 사항:**
- [ ] 품절 메뉴가 목록에서 제외되는가?
- [ ] 품절 메뉴가 화면에 표시되지 않는가?
- [ ] 판매 중인 메뉴만 표시되는가?

---

## 2. 관리자 기능 테스트 (향후 구현)

### TC-004: 관리자가 메뉴를 등록 또는 수정한다

**Gherkin 시나리오:**
```gherkin
Scenario: 관리자가 메뉴를 등록 또는 수정한다
  Given 관리자가 관리자 페이지에 접근했을 때
  When 메뉴 정보를 저장하면
  Then 변경 사항은 즉시 모바일 메뉴판에 반영되어야 한다
```

**상태:** 아직 테스트 작성 전

---

### TC-005: 관리자가 메뉴를 품절 처리한다

**Gherkin 시나리오:**
```gherkin
Scenario: 관리자가 메뉴를 품절 처리한다
  Given 관리자가 메뉴 관리 화면에 있을 때
  When 품절 상태로 변경하면
  Then 고객 메뉴판에 즉시 반영되어야 한다
```

**상태:** 아직 테스트 작성 전

---

## 테스트 실행 방법

```bash
# 모든 테스트 실행
flutter test

# 특정 테스트 그룹 실행
flutter test test/unit/
flutter test test/widget/

# 특정 테스트 파일 실행
flutter test test/unit/menu_service_test.dart
```

## RED 단계 체크리스트

- [x] 각 기능 요구사항에 대한 테스트 케이스 작성 완료
- [x] 모든 테스트가 실패하는 것을 확인 (의도적)
- [x] 테스트 코드가 명확하고 읽기 쉬움
- [x] 테스트 이름이 요구사항을 명확히 표현
- [x] Mock 데이터 및 테스트 환경 준비 완료

