# 📊 테스트 커버리지 리포트

## 📋 커버리지 개요

| 구분 | 현재 상태 | 목표 |
|------|----------|------|
| **전체 커버리지** | 0% | 80%+ |
| **Unit Test 커버리지** | 0% | 90%+ |
| **Widget Test 커버리지** | 0% | 70%+ |
| **테스트 단계** | 🔴 RED | 🟢 GREEN |

---

## 📁 파일별 커버리지 분석

### 1. Models (모델)

#### `lib/models/menu_item.dart`

**파일 상태:** ✅ 구현 완료

**코드 라인 수:** 21줄

**테스트 커버리지:** 0% (직접 테스트 없음, 간접 사용)

**테스트에서 사용 여부:**
- ✅ `menu_service_test.dart` - 간접 사용 (주석 처리됨)
- ✅ `menu_detail_test.dart` - 간접 사용 (주석 처리됨)
- ✅ `out_of_stock_test.dart` - 간접 사용 (주석 처리됨)
- ✅ `menu_mock_data.dart` - 직접 사용

**커버리지 상세:**
```
MenuItem 클래스:
  - 생성자: ❌ 테스트 없음
  - 필드 (id, name, description, price, imageUrl, allergens, isAvailable): ❌ 테스트 없음
```

**다음 단계:**
- [ ] MenuItem 생성자 테스트 작성
- [ ] MenuItem 필드 검증 테스트 작성

---

### 2. Services (서비스)

#### `lib/services/menu_service.dart`

**파일 상태:** ✅ 인터페이스 정의 완료, 구현체 없음

**코드 라인 수:** 7줄

**테스트 커버리지:** 0% (인터페이스만 존재)

**테스트 커버리지 상세:**

| 메서드 | 테스트 파일 | 상태 | 커버리지 |
|--------|------------|------|----------|
| `getAvailableMenus()` | `menu_service_test.dart` | ❌ 실패 (의도적) | 0% |
| `getMenuById(String id)` | `menu_detail_test.dart` | ❌ 실패 (의도적) | 0% |

**테스트에서 사용 여부:**
- ✅ `menu_service_test.dart` - `getAvailableMenus()` 테스트 (주석 처리됨)
- ✅ `menu_detail_test.dart` - `getMenuById()` 테스트 (주석 처리됨)
- ✅ `out_of_stock_test.dart` - `getAvailableMenus()` 테스트 (주석 처리됨)

**구현 필요:**
- [ ] `MenuServiceImpl` 클래스 생성
- [ ] `getAvailableMenus()` 구현
- [ ] `getMenuById(String id)` 구현

---

### 3. Screens (화면)

#### `lib/screens/menu_list_screen.dart`

**파일 상태:** ❌ 미구현

**테스트 커버리지:** 0%

**테스트 파일:**
- ✅ `menu_list_screen_test.dart` - 위젯 테스트 작성됨 (실패 상태)

**구현 필요:**
- [ ] `MenuListScreen` 위젯 생성
- [ ] 메뉴 목록 표시 기능
- [ ] ListView 구현

---

#### `lib/screens/menu_detail_screen.dart`

**파일 상태:** ❌ 미구현

**테스트 커버리지:** 0%

**테스트 파일:**
- ✅ `menu_detail_screen_test.dart` - 위젯 테스트 작성됨 (실패 상태)

**구현 필요:**
- [ ] `MenuDetailScreen` 위젯 생성
- [ ] 메뉴 이미지 표시
- [ ] 가격, 설명, 알레르기 정보 표시

---

## 📊 테스트 커버리지 상세 분석

### 현재 구현된 코드

```
lib/
├── models/
│   └── menu_item.dart          ✅ 구현 완료 (21줄)
└── services/
    └── menu_service.dart        ✅ 인터페이스만 존재 (7줄)
```

**총 코드 라인:** 28줄

### 테스트 커버리지

| 파일 | 라인 수 | 테스트 커버리지 | 상태 |
|------|---------|---------------|------|
| `menu_item.dart` | 21 | 0% | ❌ 테스트 없음 |
| `menu_service.dart` | 7 | 0% | ❌ 구현체 없음 |
| **합계** | **28** | **0%** | **🔴 RED 단계** |

---

## 🎯 테스트 커버리지 목표

### GREEN 단계 목표 커버리지

| 구분 | 목표 커버리지 | 현재 | 차이 |
|------|--------------|------|------|
| **전체** | 80%+ | 0% | -80% |
| **Services** | 90%+ | 0% | -90% |
| **Models** | 85%+ | 0% | -85% |
| **Screens** | 70%+ | 0% | -70% |

---

## 📈 커버리지 향상 계획

### Phase 1: GREEN 단계 (현재 목표)

**목표:** 테스트를 통과시키는 최소한의 코드 작성

1. **MenuService 구현**
   - `MenuServiceImpl` 클래스 생성
   - `getAvailableMenus()` 구현 → 커버리지 +50%
   - `getMenuById(String id)` 구현 → 커버리지 +25%

2. **UI 위젯 구현**
   - `MenuListScreen` 구현 → 커버리지 +10%
   - `MenuDetailScreen` 구현 → 커버리지 +10%

**예상 커버리지:** 95%+ (구현된 코드 기준)

---

### Phase 2: REFACTOR 단계

**목표:** 코드 품질 개선 및 추가 테스트

1. **Model 테스트 추가**
   - MenuItem 생성자 테스트
   - MenuItem 필드 검증 테스트

2. **Edge Case 테스트**
   - 빈 메뉴 목록 처리
   - 존재하지 않는 메뉴 ID 처리
   - null 값 처리

**목표 커버리지:** 95%+

---

## 🔍 커버리지 측정 방법

### Flutter 테스트 커버리지 실행

```bash
# 커버리지 포함 테스트 실행
flutter test --coverage

# 커버리지 리포트 생성 (HTML)
genhtml coverage/lcov.info -o coverage/html

# 커버리지 리포트 확인
open coverage/html/index.html
```

### pubspec.yaml에 커버리지 도구 추가

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  coverage: ^1.6.0  # 커버리지 도구
```

---

## 📋 커버리지 체크리스트

### RED 단계 (현재)

- [x] 테스트 코드 작성 완료 (5개)
- [x] 테스트가 의도적으로 실패하는 상태
- [ ] 구현 코드 커버리지: 0%

### GREEN 단계 (다음)

- [ ] MenuService 구현 → 예상 커버리지 75%
- [ ] UI 위젯 구현 → 예상 커버리지 95%
- [ ] 모든 테스트 통과 → 커버리지 95%+

### REFACTOR 단계

- [ ] 추가 테스트 작성
- [ ] Edge case 테스트
- [ ] 최종 커버리지 95%+ 달성

---

## 📊 커버리지 시각화

### 현재 상태 (RED 단계)

```
구현 코드: 28줄
테스트 커버리지: 0%

[████████████████████] 0% 커버됨
[                    ] 100% 미커버
```

### GREEN 단계 목표

```
구현 코드: ~200줄 (예상)
테스트 커버리지: 95%+

[████████████████████] 95%+ 커버됨
[                    ] 5% 미커버
```

---

## 🎯 커버리지 우선순위

### 높은 우선순위 (핵심 기능)

1. **MenuService.getAvailableMenus()** - 메뉴 조회 핵심 기능
2. **MenuService.getMenuById()** - 메뉴 상세 조회
3. **품절 메뉴 필터링** - 비즈니스 로직

### 중간 우선순위 (UI)

4. **MenuListScreen** - 메뉴 목록 화면
5. **MenuDetailScreen** - 메뉴 상세 화면

### 낮은 우선순위 (추가 기능)

6. **MenuItem 모델 검증** - 데이터 검증
7. **Edge Case 처리** - 예외 상황

---

## 📝 참고 사항

### RED 단계 특성

- **현재 커버리지 0%는 정상입니다**
- RED 단계는 테스트를 먼저 작성하는 단계
- 구현 코드가 없으므로 커버리지가 0%인 것이 의도된 상태

### GREEN 단계 이후

- 구현 코드 작성 후 커버리지 측정 시작
- 목표 커버리지 80%+ 달성
- 핵심 기능은 90%+ 커버리지 목표

---

**작성일:** 2025-12-19  
**테스트 단계:** 🔴 RED 단계  
**현재 커버리지:** 0% (의도적)  
**목표 커버리지:** 95%+ (GREEN 단계 완료 후)

