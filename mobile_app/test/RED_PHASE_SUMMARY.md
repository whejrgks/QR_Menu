# 🔴 RED 단계 테스트 항목 정리

## 📋 테스트 개요

| 구분 | 테스트 수 | 상태 |
|------|----------|------|
| **Unit Tests** | 3개 | ✅ 작성 완료 |
| **Widget Tests** | 2개 | ✅ 작성 완료 |
| **합계** | **5개** | ✅ **RED 단계 완료** |

---

## 1️⃣ Unit Tests (단위 테스트)

### TC-001: 메뉴 조회 테스트

**파일:** `test/unit/menu_service_test.dart`

**테스트 그룹:** `MenuService - 메뉴 조회 테스트`

**테스트 케이스:**
```dart
test('고객이 QR 코드를 스캔하면 판매 중인 메뉴 목록이 표시되어야 한다')
```

**Gherkin 시나리오:**
```gherkin
Scenario: 고객이 QR 코드로 메뉴를 조회한다
  Given 고객이 QR 코드를 스캔했을 때
  When 메뉴 화면이 로드되면
  Then 판매 중인 메뉴 목록이 표시되어야 한다
```

**검증 항목:**
- [ ] `MenuService` 인터페이스 구현체 존재
- [ ] `getAvailableMenus()` 메서드 구현
- [ ] 판매 중인 메뉴 목록 반환 (`isNotEmpty`)
- [ ] 모든 메뉴가 판매 가능 상태 (`isAvailable == true`)

**현재 상태:** ❌ 실패 (의도적)
- 실패 메시지: `"MenuService가 아직 구현되지 않았습니다. 이 테스트는 실패해야 합니다."`

---

### TC-002: 메뉴 상세 정보 테스트

**파일:** `test/unit/menu_detail_test.dart`

**테스트 그룹:** `MenuDetail - 메뉴 상세 정보 테스트`

**테스트 케이스:**
```dart
test('메뉴 선택 시 이미지, 가격, 설명, 알레르기 정보가 표시되어야 한다')
```

**Gherkin 시나리오:**
```gherkin
Scenario: 고객이 메뉴 상세 정보를 확인한다
  Given 고객이 메뉴 목록을 보고 있을 때
  When 특정 메뉴를 선택하면
  Then 메뉴 이미지, 가격, 설명, 알레르기 정보가 표시되어야 한다
```

**검증 항목:**
- [ ] `getMenuById(String id)` 메서드 구현
- [ ] 메뉴 객체가 null이 아님 (`isNotNull`)
- [ ] 메뉴 이미지 URL 존재 (`imageUrl != null`)
- [ ] 메뉴 가격이 0보다 큼 (`price > 0`)
- [ ] 메뉴 설명이 비어있지 않음 (`description.isNotEmpty`)
- [ ] 알레르기 정보 존재 (`allergens != null`)

**현재 상태:** ❌ 실패 (의도적)
- 실패 메시지: `"MenuService.getMenuById가 아직 구현되지 않았습니다. 이 테스트는 실패해야 합니다."`

---

### TC-003: 품절 메뉴 처리 테스트

**파일:** `test/unit/out_of_stock_test.dart`

**테스트 그룹:** `OutOfStock - 품절 메뉴 처리 테스트`

**테스트 케이스:**
```dart
test('품절 메뉴는 비활성화되거나 숨김 처리되어야 한다')
```

**Gherkin 시나리오:**
```gherkin
Scenario: 품절 메뉴는 노출되지 않는다
  Given 메뉴가 품절 상태일 때
  When 고객이 메뉴판을 조회하면
  Then 해당 메뉴는 비활성화되거나 숨김 처리되어야 한다
```

**검증 항목:**
- [ ] `getAvailableMenus()`가 품절 메뉴를 제외
- [ ] 반환된 모든 메뉴가 판매 가능 상태 (`every((menu) => menu.isAvailable)`)
- [ ] 품절 메뉴가 목록에 포함되지 않음 (`any((menu) => !menu.isAvailable) == false`)

**현재 상태:** ❌ 실패 (의도적)
- 실패 메시지: `"품절 메뉴 필터링 기능이 아직 구현되지 않았습니다. 이 테스트는 실패해야 합니다."`

---

## 2️⃣ Widget Tests (위젯 테스트)

### TC-004: 메뉴 목록 화면 테스트

**파일:** `test/widget/menu_list_screen_test.dart`

**테스트 그룹:** `MenuListScreen - 메뉴 목록 화면 테스트`

**테스트 케이스:**
```dart
testWidgets('메뉴 화면이 로드되면 판매 중인 메뉴 목록이 표시되어야 한다')
```

**Gherkin 시나리오:**
```gherkin
Scenario: 고객이 QR 코드로 메뉴를 조회한다
  Given 고객이 QR 코드를 스캔했을 때
  When 메뉴 화면이 로드되면
  Then 판매 중인 메뉴 목록이 표시되어야 한다
```

**검증 항목:**
- [ ] `MenuListScreen` 위젯 존재
- [ ] '메뉴 목록' 텍스트 표시 (`find.text('메뉴 목록')`)
- [ ] `ListView` 위젯 존재 (`find.byType(ListView)`)
- [ ] 화면이 정상적으로 로드됨 (`pumpAndSettle()`)

**현재 상태:** ❌ 실패 (의도적)
- 실패 메시지: `"MenuListScreen 위젯이 아직 구현되지 않았습니다. 이 테스트는 실패해야 합니다."`

---

### TC-005: 메뉴 상세 화면 테스트

**파일:** `test/widget/menu_detail_screen_test.dart`

**테스트 그룹:** `MenuDetailScreen - 메뉴 상세 화면 테스트`

**테스트 케이스:**
```dart
testWidgets('메뉴 선택 시 이미지, 가격, 설명, 알레르기 정보가 표시되어야 한다')
```

**Gherkin 시나리오:**
```gherkin
Scenario: 고객이 메뉴 상세 정보를 확인한다
  Given 고객이 메뉴 목록을 보고 있을 때
  When 특정 메뉴를 선택하면
  Then 메뉴 이미지, 가격, 설명, 알레르기 정보가 표시되어야 한다
```

**검증 항목:**
- [ ] `MenuDetailScreen` 위젯 존재
- [ ] `Image` 위젯 표시 (`find.byType(Image)`)
- [ ] 가격 텍스트 표시 (`find.textContaining('원')`)
- [ ] 설명 텍스트 표시 (`find.byType(Text)`)
- [ ] 알레르기 정보 텍스트 표시 (`find.text('알레르기 정보')`)

**현재 상태:** ❌ 실패 (의도적)
- 실패 메시지: `"MenuDetailScreen 위젯이 아직 구현되지 않았습니다. 이 테스트는 실패해야 합니다."`

---

## 📊 테스트 실행 결과 요약

### 예상 실행 결과

```bash
flutter test
```

**예상 출력:**
```
00:02 +0 -5: Some tests failed.

Failed tests:
  1. menu_service_test.dart
     - MenuService - 메뉴 조회 테스트
     - 고객이 QR 코드를 스캔하면 판매 중인 메뉴 목록이 표시되어야 한다
     - Error: MenuService가 아직 구현되지 않았습니다.

  2. menu_detail_test.dart
     - MenuDetail - 메뉴 상세 정보 테스트
     - 메뉴 선택 시 이미지, 가격, 설명, 알레르기 정보가 표시되어야 한다
     - Error: MenuService.getMenuById가 아직 구현되지 않았습니다.

  3. out_of_stock_test.dart
     - OutOfStock - 품절 메뉴 처리 테스트
     - 품절 메뉴는 비활성화되거나 숨김 처리되어야 한다
     - Error: 품절 메뉴 필터링 기능이 아직 구현되지 않았습니다.

  4. menu_list_screen_test.dart
     - MenuListScreen - 메뉴 목록 화면 테스트
     - 메뉴 화면이 로드되면 판매 중인 메뉴 목록이 표시되어야 한다
     - Error: MenuListScreen 위젯이 아직 구현되지 않았습니다.

  5. menu_detail_screen_test.dart
     - MenuDetailScreen - 메뉴 상세 화면 테스트
     - 메뉴 선택 시 이미지, 가격, 설명, 알레르기 정보가 표시되어야 한다
     - Error: MenuDetailScreen 위젯이 아직 구현되지 않았습니다.

Summary: 5 failed, 0 passed
```

---

## ✅ RED 단계 완료 체크리스트

- [x] **실패하는 테스트 작성 완료** (5개)
- [x] **Given-When-Then 구조 명확히 표현**
- [x] **PRD Gherkin 시나리오 반영**
- [x] **테스트 이름이 요구사항을 정확히 표현**
- [x] **Mock 데이터 준비 완료** (`test/mock_data/menu_mock_data.dart`)
- [x] **테스트 환경 설정 완료** (`pubspec.yaml`)

---

## 🎯 다음 단계: GREEN 단계

### 구현 필요 항목

#### 1. MenuService 구현
- [ ] `lib/services/menu_service_impl.dart` 생성
- [ ] `MenuService` 인터페이스 구현
- [ ] `getAvailableMenus()` 메서드 구현 (품절 메뉴 필터링 포함)
- [ ] `getMenuById(String id)` 메서드 구현

#### 2. UI 위젯 구현
- [ ] `lib/screens/menu_list_screen.dart` 생성
- [ ] `MenuListScreen` 위젯 구현
- [ ] `lib/screens/menu_detail_screen.dart` 생성
- [ ] `MenuDetailScreen` 위젯 구현

#### 3. 상태 관리
- [ ] Riverpod 또는 Provider 설정
- [ ] 메뉴 데이터 상태 관리

---

## 📁 테스트 파일 구조

```
mobile_app/
└── test/
    ├── mock_data/
    │   └── menu_mock_data.dart          # Mock 데이터
    ├── unit/
    │   ├── menu_service_test.dart        # TC-001
    │   ├── menu_detail_test.dart        # TC-002
    │   └── out_of_stock_test.dart       # TC-003
    ├── widget/
    │   ├── menu_list_screen_test.dart   # TC-004
    │   └── menu_detail_screen_test.dart # TC-005
    ├── TEST_CASES.md                    # 테스트 케이스 문서
    ├── TEST_RESULTS.md                  # 테스트 결과 보고서
    ├── CODE_VALIDATION.md               # 코드 검증 결과
    └── RED_PHASE_SUMMARY.md             # 이 문서
```

---

## 📝 참고 문서

- **PRD 문서:** `Report/PRD.md`
- **테스트 케이스:** `test/TEST_CASES.md`
- **테스트 결과:** `test/TEST_RESULTS.md`
- **코드 검증:** `test/CODE_VALIDATION.md`

---

**작성일:** 2025-12-19  
**상태:** 🔴 RED 단계 완료  
**다음 단계:** 🟢 GREEN 단계 (테스트 통과시키기)

