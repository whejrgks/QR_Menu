# 아키텍처 문서

## 개요

본 프로젝트는 Flutter 기반 QR 디지털 메뉴판 시스템으로, TDD(Test-Driven Development) 방식으로 개발되었습니다.

## 아키텍처 패턴

### 상태 관리
- **Riverpod**: 상태 관리 라이브러리로 사용
- **Provider 패턴**: 의존성 주입 및 상태 관리에 사용
- **FutureProvider**: 비동기 데이터 로딩에 사용

### 디렉토리 구조

```
lib/
├── constants/          # 앱 전역 상수
│   └── app_constants.dart
├── data/               # Mock 데이터
│   └── menu_mock_data.dart
├── errors/             # 에러 타입 정의
│   └── menu_errors.dart
├── models/             # 데이터 모델
│   └── menu_item.dart
├── providers/          # Riverpod Provider
│   └── menu_provider.dart
├── screens/            # 화면 위젯
│   ├── admin_login_screen.dart
│   ├── admin_menu_manage_screen.dart
│   ├── menu_detail_screen.dart
│   └── menu_list_screen.dart
├── services/           # 비즈니스 로직
│   ├── menu_service.dart (인터페이스)
│   └── menu_service_impl.dart (구현체)
├── utils/              # 유틸리티 함수
│   ├── format_utils.dart
│   ├── image_utils.dart
│   └── responsive_utils.dart
├── widgets/            # 재사용 가능한 위젯
│   ├── error_widget.dart
│   ├── loading_widget.dart
│   └── skeleton_widget.dart
└── main.dart          # 앱 진입점
```

## 데이터 흐름

### 메뉴 목록 조회 흐름

```
MenuListScreen (UI)
    ↓
menuListProvider (Provider)
    ↓
MenuService (인터페이스)
    ↓
MenuServiceImpl (구현체)
    ↓
MenuMockData (Mock 데이터)
```

### 상태 관리 흐름

1. **UI 레이어**: `ConsumerWidget`을 사용하여 Provider를 구독
2. **Provider 레이어**: 비동기 데이터 로딩 및 캐싱 관리
3. **Service 레이어**: 비즈니스 로직 처리
4. **Data 레이어**: 데이터 소스 (현재는 Mock 데이터)

## 주요 컴포넌트

### MenuService
- **역할**: 메뉴 데이터 조회 인터페이스
- **구현**: `MenuServiceImpl` (Mock 데이터 사용)
- **확장성**: 향후 API나 Database 연동으로 교체 가능

### Provider
- **menuServiceProvider**: MenuService 인스턴스 제공
- **menuListProvider**: 판매 가능한 메뉴 목록 제공
- **menuDetailProvider**: 메뉴 상세 정보 제공 (family provider)
- **adminMenuListProvider**: 관리자용 전체 메뉴 목록 제공

### 화면 위젯
- **MenuListScreen**: 메뉴 목록 화면 (반응형 지원)
- **MenuDetailScreen**: 메뉴 상세 화면
- **AdminMenuManageScreen**: 관리자 메뉴 관리 화면
- **AdminLoginScreen**: 관리자 로그인 화면

## 성능 최적화

### 이미지 최적화
- `cached_network_image` 패키지 사용
- 메모리 캐시 최적화 (`memCacheWidth`, `memCacheHeight`)
- 디스크 캐시를 통한 네트워크 요청 감소

### 리스트 성능
- `ListView.builder` 사용 (lazy loading)
- `addAutomaticKeepAlives: false` (메모리 절약)
- `addRepaintBoundaries: true` (불필요한 리빌드 방지)
- `cacheExtent` 설정으로 스크롤 성능 향상

### 비동기 처리
- Provider에 `keepAlive` 설정으로 데이터 캐싱
- 불필요한 재로딩 방지

## 반응형 디자인

### 브레이크포인트
- **모바일**: < 600px (ListView 사용)
- **태블릿**: 600px ~ 1200px (GridView 2열)
- **데스크톱**: >= 1200px (GridView 3열)

### ResponsiveUtils
- 화면 크기 감지 유틸리티
- 화면 크기에 따른 레이아웃 조정

## 에러 처리

### 에러 타입
- `NetworkError`: 네트워크 연결 오류
- `DataLoadingError`: 데이터 로딩 오류
- `MenuNotFoundError`: 메뉴를 찾을 수 없음
- `UnknownError`: 알 수 없는 오류

### 에러 UI
- `ErrorDisplayWidget`: 재사용 가능한 에러 표시 위젯
- 재시도 기능 제공
- 사용자 친화적인 에러 메시지

## 테스트 전략

### Unit Tests
- Service 레이어 테스트
- 비즈니스 로직 테스트

### Widget Tests
- 화면 위젯 테스트
- 사용자 인터랙션 테스트

### 테스트 커버리지
- 목표: 95%+
- 현재: 93.9%

## 향후 개선 사항

1. **API 연동**: Mock 데이터를 실제 API로 교체
2. **로컬 캐싱**: Hive 또는 SharedPreferences를 사용한 로컬 캐싱
3. **오프라인 지원**: 오프라인 모드 지원
4. **상태 관리 개선**: StateNotifier를 사용한 복잡한 상태 관리
5. **애니메이션**: 화면 전환 및 인터랙션 애니메이션 추가

