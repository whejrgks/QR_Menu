# QR Menu Mobile App

Flutter 기반 QR 디지털 메뉴판 모바일 앱

## 테스트 환경 설정

### 의존성 설치
```bash
flutter pub get
```

### 테스트 실행
```bash
# 모든 테스트 실행
flutter test

# 특정 테스트 파일 실행
flutter test test/unit/menu_service_test.dart

# 위젯 테스트 실행
flutter test test/widget/
```

## RED 단계 테스트 구조

### Unit Tests
- `test/unit/menu_service_test.dart` - 메뉴 조회 테스트
- `test/unit/menu_detail_test.dart` - 메뉴 상세 정보 테스트
- `test/unit/out_of_stock_test.dart` - 품절 메뉴 처리 테스트

### Widget Tests
- `test/widget/menu_list_screen_test.dart` - 메뉴 목록 화면 테스트
- `test/widget/menu_detail_screen_test.dart` - 메뉴 상세 화면 테스트

### Mock Data
- `test/mock_data/menu_mock_data.dart` - 테스트용 Mock 데이터

## 현재 상태

🔴 **RED 단계**: 모든 테스트가 실패하는 상태 (의도적)
- 테스트 코드는 작성되었으나 실제 구현은 아직 없음
- 다음 단계(GREEN)에서 테스트를 통과시키는 최소한의 코드 작성 예정

