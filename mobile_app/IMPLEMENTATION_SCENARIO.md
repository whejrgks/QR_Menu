# 🟢 GREEN 단계: MenuService 구현 시나리오

## 📋 구현 목표

**목표:** 테스트를 통과시키는 최소한의 MenuService 구현체 작성

**대상 파일:** `lib/services/menu_service_impl.dart` (신규 생성)

---

## 🎯 구현 시나리오

### 시나리오 1: MenuServiceImpl 클래스 생성

**목표:** MenuService 인터페이스를 구현하는 클래스 생성

**구현 내용:**
```dart
import '../models/menu_item.dart';
import 'menu_service.dart';
import '../../test/mock_data/menu_mock_data.dart';

class MenuServiceImpl implements MenuService {
  // MenuService 인터페이스 구현
}
```

**검증:**
- ✅ MenuService 인터페이스 구현
- ✅ 컴파일 에러 없음

---

### 시나리오 2: getAvailableMenus() 메서드 구현

**목표:** 판매 중인 메뉴 목록 반환 (품절 메뉴 제외)

**테스트 요구사항:**
- `menu_service_test.dart`: 
  - `menus`가 비어있지 않아야 함 (`isNotEmpty`)
  - 모든 메뉴가 판매 가능 상태여야 함 (`every((menu) => menu.isAvailable)`)
  
- `out_of_stock_test.dart`:
  - 모든 메뉴가 판매 가능 상태여야 함 (`every((menu) => menu.isAvailable)`)
  - 품절 메뉴가 포함되지 않아야 함 (`any((menu) => !menu.isAvailable) == false`)

**구현 내용:**
```dart
@override
Future<List<MenuItem>> getAvailableMenus() async {
  // 1. Mock 데이터에서 모든 메뉴 가져오기
  final allMenus = MenuMockData.getMenusWithOutOfStock();
  
  // 2. 품절 메뉴 필터링 (isAvailable == true인 메뉴만)
  final availableMenus = allMenus.where((menu) => menu.isAvailable).toList();
  
  // 3. Future로 반환 (비동기 처리)
  return Future.value(availableMenus);
}
```

**검증:**
- ✅ 품절 메뉴(`isAvailable == false`)가 제외됨
- ✅ 판매 중인 메뉴만 반환됨
- ✅ 빈 리스트가 아닌 메뉴 목록 반환
- ✅ 테스트 통과

**예상 결과:**
- `menu_service_test.dart` ✅ 통과
- `out_of_stock_test.dart` ✅ 통과

---

### 시나리오 3: getMenuById(String id) 메서드 구현

**목표:** ID로 특정 메뉴 조회

**테스트 요구사항:**
- `menu_detail_test.dart`:
  - `menu`가 null이 아님 (`isNotNull`)
  - `menu.imageUrl`이 null이 아님 (`isNotNull`)
  - `menu.price`가 0보다 큼 (`greaterThan(0)`)
  - `menu.description`이 비어있지 않음 (`isNotEmpty`)
  - `menu.allergens`가 null이 아님 (`isNotNull`)

**구현 내용:**
```dart
@override
Future<MenuItem?> getMenuById(String id) async {
  // 1. Mock 데이터에서 모든 메뉴 가져오기
  final allMenus = MenuMockData.getAvailableMenus();
  
  // 2. ID로 메뉴 검색
  try {
    final menu = allMenus.firstWhere((menu) => menu.id == id);
    return Future.value(menu);
  } catch (e) {
    // 3. 존재하지 않는 ID인 경우 null 반환
    return Future.value(null);
  }
}
```

**검증:**
- ✅ 존재하는 ID로 메뉴 조회 성공
- ✅ 존재하지 않는 ID는 null 반환
- ✅ 반환된 메뉴의 모든 필드가 유효함
- ✅ 테스트 통과

**예상 결과:**
- `menu_detail_test.dart` ✅ 통과

---

## 📝 구현 단계별 계획

### Step 1: 파일 생성 및 기본 구조
1. `lib/services/menu_service_impl.dart` 파일 생성
2. 필요한 import 문 추가
3. `MenuServiceImpl` 클래스 선언

### Step 2: getAvailableMenus() 구현
1. Mock 데이터 가져오기
2. 품절 메뉴 필터링 로직 구현
3. Future 반환

### Step 3: getMenuById() 구현
1. Mock 데이터에서 ID로 검색
2. 존재하지 않는 경우 null 반환 처리
3. Future 반환

### Step 4: 테스트 수정
1. 테스트 파일에서 주석 처리된 코드 활성화
2. `fail()` 호출 제거
3. 실제 테스트 로직 활성화

### Step 5: 테스트 실행 및 검증
1. `flutter test` 실행
2. 모든 테스트 통과 확인
3. 커버리지 측정

---

## 🔍 테스트 파일 수정 계획

### menu_service_test.dart 수정

**변경 전:**
```dart
test('고객이 QR 코드를 스캔하면 판매 중인 메뉴 목록이 표시되어야 한다', () async {
  // Given: QR 코드 스캔 시나리오
  // TODO: MenuService 구현 필요
  // MenuService menuService = MenuServiceImpl();
  
  // When: 메뉴 화면 로드
  // final menus = await menuService.getAvailableMenus();
  
  // Then: 판매 중인 메뉴 목록 표시 확인
  // expect(menus, isNotEmpty);
  // expect(menus.every((menu) => menu.isAvailable), isTrue);
  
  // RED 단계: 테스트는 실패해야 함 (아직 구현되지 않음)
  fail('MenuService가 아직 구현되지 않았습니다. 이 테스트는 실패해야 합니다.');
});
```

**변경 후:**
```dart
test('고객이 QR 코드를 스캔하면 판매 중인 메뉴 목록이 표시되어야 한다', () async {
  // Given: QR 코드 스캔 시나리오
  MenuService menuService = MenuServiceImpl();
  
  // When: 메뉴 화면 로드
  final menus = await menuService.getAvailableMenus();
  
  // Then: 판매 중인 메뉴 목록 표시 확인
  expect(menus, isNotEmpty);
  expect(menus.every((menu) => menu.isAvailable), isTrue);
});
```

---

### menu_detail_test.dart 수정

**변경 전:**
```dart
test('메뉴 선택 시 이미지, 가격, 설명, 알레르기 정보가 표시되어야 한다', () async {
  // Given: 메뉴 목록 화면
  // TODO: MenuService 구현 필요
  // MenuService menuService = MenuServiceImpl();
  const menuId = 'menu-001';
  
  // When: 특정 메뉴 선택
  // final menu = await menuService.getMenuById(menuId);
  
  // Then: 상세 정보 표시 확인
  // expect(menu, isNotNull);
  // expect(menu!.imageUrl, isNotNull);
  // expect(menu.price, greaterThan(0));
  // expect(menu.description, isNotEmpty);
  // expect(menu.allergens, isNotNull);
  
  // RED 단계: 테스트는 실패해야 함 (아직 구현되지 않음)
  fail('MenuService.getMenuById가 아직 구현되지 않았습니다. 이 테스트는 실패해야 합니다.');
});
```

**변경 후:**
```dart
test('메뉴 선택 시 이미지, 가격, 설명, 알레르기 정보가 표시되어야 한다', () async {
  // Given: 메뉴 목록 화면
  MenuService menuService = MenuServiceImpl();
  const menuId = 'menu-001';
  
  // When: 특정 메뉴 선택
  final menu = await menuService.getMenuById(menuId);
  
  // Then: 상세 정보 표시 확인
  expect(menu, isNotNull);
  expect(menu!.imageUrl, isNotNull);
  expect(menu.price, greaterThan(0));
  expect(menu.description, isNotEmpty);
  expect(menu.allergens, isNotNull);
});
```

---

### out_of_stock_test.dart 수정

**변경 전:**
```dart
test('품절 메뉴는 비활성화되거나 숨김 처리되어야 한다', () async {
  // Given: 품절 상태인 메뉴
  // TODO: MenuService 구현 필요
  // MenuService menuService = MenuServiceImpl();
  
  // When: 메뉴판 조회
  // final menus = await menuService.getAvailableMenus();
  
  // Then: 품절 메뉴 숨김/비활성화 확인
  // expect(menus.every((menu) => menu.isAvailable), isTrue);
  // expect(menus.any((menu) => !menu.isAvailable), isFalse);
  
  // RED 단계: 테스트는 실패해야 함 (아직 구현되지 않음)
  fail('품절 메뉴 필터링 기능이 아직 구현되지 않았습니다. 이 테스트는 실패해야 합니다.');
});
```

**변경 후:**
```dart
test('품절 메뉴는 비활성화되거나 숨김 처리되어야 한다', () async {
  // Given: 품절 상태인 메뉴
  MenuService menuService = MenuServiceImpl();
  
  // When: 메뉴판 조회
  final menus = await menuService.getAvailableMenus();
  
  // Then: 품절 메뉴 숨김/비활성화 확인
  expect(menus.every((menu) => menu.isAvailable), isTrue);
  expect(menus.any((menu) => !menu.isAvailable), isFalse);
});
```

---

## ✅ 구현 완료 검증 기준

### 기능 검증
- [ ] `MenuServiceImpl` 클래스가 `MenuService` 인터페이스를 구현
- [ ] `getAvailableMenus()` 메서드가 품절 메뉴를 제외하고 반환
- [ ] `getMenuById(String id)` 메서드가 올바른 메뉴를 반환
- [ ] 존재하지 않는 ID에 대해 null 반환

### 테스트 검증
- [ ] `menu_service_test.dart` 통과
- [ ] `menu_detail_test.dart` 통과
- [ ] `out_of_stock_test.dart` 통과
- [ ] 모든 테스트가 성공적으로 실행됨

### 코드 품질
- [ ] 최소한의 코드로 테스트 통과 (GREEN 단계 원칙 준수)
- [ ] 코드가 읽기 쉽고 이해하기 쉬움
- [ ] 주석이 적절히 포함됨

---

## 📊 예상 결과

### 테스트 실행 결과
```
00:02 +3 -0: All tests passed!

Passed tests:
  1. menu_service_test.dart - MenuService - 메뉴 조회 테스트
     - 고객이 QR 코드를 스캔하면 판매 중인 메뉴 목록이 표시되어야 한다 ✅
  
  2. menu_detail_test.dart - MenuDetail - 메뉴 상세 정보 테스트
     - 메뉴 선택 시 이미지, 가격, 설명, 알레르기 정보가 표시되어야 한다 ✅
  
  3. out_of_stock_test.dart - OutOfStock - 품절 메뉴 처리 테스트
     - 품절 메뉴는 비활성화되거나 숨김 처리되어야 한다 ✅

Summary: 3 passed, 0 failed
```

### 커버리지 예상
- **MenuService 구현:** +75% 커버리지 증가
- **전체 커버리지:** 75%+ (구현된 코드 기준)

---

## 🎯 최소 단위 구현 원칙

1. **Mock 데이터 사용**: 실제 API 연동은 나중에, 지금은 Mock 데이터로 테스트 통과
2. **최소한의 로직**: 테스트를 통과시키는 최소한의 코드만 작성
3. **복잡도 최소화**: 최적화나 복잡한 로직은 REFACTOR 단계에서 수행
4. **테스트 우선**: 모든 테스트가 통과하는 것이 최우선 목표

---

## 📝 참고사항

- Mock 데이터는 `test/mock_data/menu_mock_data.dart`에 이미 준비되어 있음
- `getMenusWithOutOfStock()` 메서드를 사용하여 품절 메뉴 포함 데이터 테스트 가능
- 향후 실제 API 연동 시에도 인터페이스는 동일하게 유지

---

**작성일:** 2025-12-19  
**상태:** ⏳ 승인 대기  
**다음 단계:** 승인 후 구현 진행

