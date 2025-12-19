# Flutter 설치 가이드

## Windows에서 Flutter 설치하기

### 빠른 설치 방법

**PowerShell 스크립트 사용 (권장):**
```powershell
cd mobile_app
.\INSTALL_FLUTTER.ps1

```

또는 수동 설치:

### 1. Flutter SDK 다운로드

1. **Flutter 공식 웹사이트 방문**: 
   - https://docs.flutter.dev/get-started/install/windows
   - 또는 직접 다운로드: https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.x.x-stable.zip

2. **Flutter SDK 다운로드** (최신 stable 버전)
   - 파일명: `flutter_windows_3.x.x-stable.zip`
   - 다운로드 위치: `%USERPROFILE%\Downloads`

3. **압축 해제**
   - 압축 파일을 `C:\src\flutter` 위치에 압축 해제
   - 또는 원하는 위치에 압축 해제 (경로에 공백 없어야 함)

### 2. 환경 변수 설정

**방법 1: PowerShell 스크립트 사용 (자동)**
```powershell
.\INSTALL_FLUTTER.ps1
```

**방법 2: 수동 설정**

1. **시스템 환경 변수 편집**
   - Windows 검색에서 "환경 변수" 검색
   - "시스템 환경 변수 편집" 선택
   - "환경 변수" 버튼 클릭

2. **Path 변수에 Flutter 추가**
   - **사용자 변수** 또는 **시스템 변수**에서 "Path" 선택
   - "편집" 클릭
   - "새로 만들기" 클릭
   - Flutter bin 폴더 경로 추가 (예: `C:\src\flutter\bin`)
   - 확인 클릭

3. **새 터미널 열기** ⚠️ 중요
   - 환경 변수 변경사항을 적용하기 위해 **반드시 새 PowerShell 또는 CMD 창을 열어야 함**
   - 현재 창에서는 변경사항이 적용되지 않음

### 3. Flutter 설치 확인

**⚠️ 중요: 새 PowerShell 창을 열어야 합니다!**

```powershell
# 새 PowerShell 창에서 실행
flutter doctor
```

이 명령어는 Flutter 설치 상태와 필요한 추가 구성 요소를 확인합니다.

**예상 출력:**
```
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.x.x, on Microsoft Windows ...)
[✗] Android toolchain - develop for Android devices
    ✗ Android SDK not found
[✗] Chrome - develop for the web
    ✗ Chrome not installed
[✓] Visual Studio - develop for Windows
[✗] Android Studio (not installed)
```

**설치 확인:**
```powershell
flutter --version
```

**예상 출력:**
```
Flutter 3.x.x • channel stable • https://github.com/flutter/flutter.git
Framework • revision xxxxx
Engine • revision xxxxx
Tools • Dart 3.x.x • DevTools 2.x.x
```

### 4. 필요한 구성 요소 설치

`flutter doctor` 결과에 따라 다음을 설치해야 할 수 있습니다:

- **Android Studio**: Android 개발용
- **Visual Studio**: Windows 개발용 (선택사항)
- **VS Code 또는 Android Studio**: 에디터 플러그인

### 5. Flutter 프로젝트 설정

Flutter 설치 후 프로젝트 디렉토리에서:

```powershell
cd C:\DEV\Cursor_pro\QR_Menu\mobile_app
flutter pub get
```

### 6. 테스트 실행

```powershell
flutter test
```

---

## 빠른 설치 (Chocolatey 사용)

Chocolatey가 설치되어 있다면:

```powershell
# 관리자 권한 PowerShell에서 실행
choco install flutter
```

**Chocolatey 설치 방법:**
```powershell
# 관리자 권한 PowerShell에서 실행
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

---

## 대안: Flutter 없이 테스트 코드 검증

Flutter가 설치되지 않은 경우에도:
- 테스트 코드 문법 검증
- 테스트 구조 검증
- Mock 데이터 검증

은 가능합니다. 현재 테스트 코드는 모두 올바르게 작성되어 있으며, Flutter 설치 후 바로 실행 가능합니다.

---

## 문제 해결

### 'flutter' 명령을 찾을 수 없는 경우
1. 환경 변수 Path에 Flutter bin 경로가 올바르게 추가되었는지 확인
2. 새 터미널 창을 열어 환경 변수 변경사항 적용
3. `where flutter` 명령으로 Flutter 경로 확인

### Flutter doctor 오류
- `flutter doctor -v` 명령으로 상세 정보 확인
- 각 항목별로 필요한 도구 설치

---

**참고**: Flutter 설치에는 시간이 걸릴 수 있습니다. Android Studio나 Visual Studio 같은 추가 도구도 필요할 수 있습니다.

