# 🚀 Flutter 앱 실행 가이드

## 📋 실행 전 준비사항

### 1. Flutter 설치 확인

```bash
C:\src\flutter\bin\flutter.bat --version
```

**예상 출력:**
```
Flutter 3.38.5 • channel stable
```

### 2. 의존성 설치

```bash
cd mobile_app
C:\src\flutter\bin\flutter.bat pub get
```

---

## 🎯 실행 방법

### 방법 1: 테스트 실행 (권장)

#### 모든 테스트 실행

```bash
cd mobile_app
C:\src\flutter\bin\flutter.bat test
```

**예상 결과:**
```
00:02 +5 -0: All tests passed!
Summary: 5 passed, 0 failed
```

#### 특정 테스트 그룹 실행

```bash
# Unit Tests만 실행
C:\src\flutter\bin\flutter.bat test test/unit/

# Widget Tests만 실행
C:\src\flutter\bin\flutter.bat test test/widget/

# 특정 테스트 파일 실행
C:\src\flutter\bin\flutter.bat test test/unit/menu_service_test.dart
```

#### 커버리지 포함 테스트 실행

```bash
C:\src\flutter\bin\flutter.bat test --coverage
```

**커버리지 확인:**
- 커버리지 파일: `coverage/lcov.info`
- 전체 커버리지: 93.9%

---

### 방법 2: 앱 실행 (개발 모드)

#### 사용 가능한 디바이스에서 실행

**현재 사용 가능한 디바이스:**
- Windows (desktop) - Windows 데스크톱 앱 ✅ (설정 완료)
- Chrome (web) - 웹 브라우저 (Chrome)
- Edge (web) - 웹 브라우저 (Edge)

**실행 명령어:**

```bash
cd mobile_app

# 사용 가능한 디바이스 확인
C:\src\flutter\bin\flutter.bat devices

# Windows 데스크톱에서 실행 (권장)
C:\src\flutter\bin\flutter.bat run -d windows

# Chrome 브라우저에서 실행
C:\src\flutter\bin\flutter.bat run -d chrome

# Edge 브라우저에서 실행
C:\src\flutter\bin\flutter.bat run -d edge

# 또는 기본 디바이스에서 실행 (첫 번째 디바이스)
C:\src\flutter\bin\flutter.bat run
```

**예상 출력:**
```
Running "flutter pub get" in mobile_app...
Launching lib/main.dart on Windows...
```

**참고:** Windows 데스크톱 지원이 프로젝트에 추가되었습니다. 이제 Windows 앱으로 실행할 수 있습니다.

---

### 방법 3: 앱 실행 (main.dart 포함)

`main.dart` 파일이 이미 생성되어 있으므로 바로 실행할 수 있습니다.

**실행:**
```bash
cd mobile_app
C:\src\flutter\bin\flutter.bat run
```

---

## 📱 실행 시나리오

### 시나리오 1: 메뉴 목록 화면 확인

1. 앱 실행
2. `MenuListScreen`이 자동으로 표시됨
3. 메뉴 목록이 로드되어 표시됨
4. 각 메뉴 항목에 이름과 가격이 표시됨

### 시나리오 2: 메뉴 상세 화면 확인

1. 메뉴 목록에서 특정 메뉴 선택 (향후 구현)
2. 또는 직접 `MenuDetailScreen`으로 이동
3. 메뉴 이미지, 가격, 설명, 알레르기 정보 확인

---

## 🔧 문제 해결

### 문제 1: 'flutter' 명령을 찾을 수 없음

**해결 방법:**
```bash
# 직접 경로로 실행
C:\src\flutter\bin\flutter.bat [명령어]

# 또는 환경 변수에 추가
$env:PATH += ";C:\src\flutter\bin"
flutter [명령어]
```

### 문제 2: Android SDK를 찾을 수 없음

**해결 방법:**
- Android Studio 설치 필요
- 또는 웹 브라우저에서 실행 (Chrome 필요)

### 문제 3: 의존성 설치 실패

**해결 방법:**
```bash
# 캐시 정리 후 재설치
C:\src\flutter\bin\flutter.bat clean
C:\src\flutter\bin\flutter.bat pub get
```

---

## 📊 현재 구현 상태

### ✅ 구현 완료
- main.dart (앱 진입점)
- MenuService (메뉴 조회 기능)
- MenuListScreen (메뉴 목록 화면)
- MenuDetailScreen (메뉴 상세 화면)

### ⏳ 향후 구현
- 네비게이션 (목록 → 상세 화면 이동)
- QR 코드 스캔 기능

---

## 🎯 빠른 시작

### 1단계: 의존성 설치
```bash
cd C:\DEV\Cursor_pro\QR_Menu\mobile_app
C:\src\flutter\bin\flutter.bat pub get
```

### 2단계: 테스트 실행
```bash
C:\src\flutter\bin\flutter.bat test
```

### 3단계: 앱 실행 (선택사항)
```bash
# Windows 데스크톱에서 실행 (권장)
C:\src\flutter\bin\flutter.bat run -d windows

# 또는 Chrome 브라우저에서 실행
C:\src\flutter\bin\flutter.bat run -d chrome

# 또는 Edge 브라우저에서 실행
C:\src\flutter\bin\flutter.bat run -d edge
```

---

## 📝 참고사항

- **현재 상태:** 메인 앱 파일 및 모든 위젯과 서비스 구현 완료
- **테스트:** 모든 테스트 통과 (5/5)
- **커버리지:** 93.9%
- **실행 환경:** Windows, Flutter 3.38.5

---

**작성일:** 2025-12-19  
**Flutter 버전:** 3.38.5  
**상태:** 🟢 GREEN 단계 완료

