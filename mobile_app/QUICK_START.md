# Flutter 빠른 시작 가이드

## 현재 상태 확인

Flutter가 설치되어 있지 않은 경우, 다음 중 하나의 방법을 선택하세요.

---

## 방법 1: 자동 설치 스크립트 (권장)

```powershell
cd C:\DEV\Cursor_pro\QR_Menu\mobile_app
.\INSTALL_FLUTTER.ps1
```

스크립트가 다음을 안내합니다:
1. Flutter SDK 다운로드 링크 제공
2. 압축 해제 자동화
3. 환경 변수 설정

---

## 방법 2: 수동 설치

### 단계별 가이드

1. **Flutter 다운로드**
   - https://docs.flutter.dev/get-started/install/windows
   - 또는: https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.x.x-stable.zip

2. **압축 해제**
   - `C:\src\flutter` 위치에 압축 해제

3. **환경 변수 설정**
   - Windows 검색 → "환경 변수"
   - Path에 `C:\src\flutter\bin` 추가

4. **새 터미널 열기** ⚠️ 중요
   - 환경 변수 적용을 위해 새 PowerShell 창 열기

5. **설치 확인**
   ```powershell
   flutter doctor
   ```

---

## 방법 3: Chocolatey 사용 (관리자 권한 필요)

```powershell
# 관리자 권한 PowerShell에서
choco install flutter
```

---

## 설치 후 테스트 실행

```powershell
# 프로젝트 디렉토리로 이동
cd C:\DEV\Cursor_pro\QR_Menu\mobile_app

# 의존성 설치
flutter pub get

# 테스트 실행
flutter test
```

**예상 결과:**
- 5개 테스트 모두 실패 (의도적, RED 단계)
- 각 테스트에 명확한 실패 메시지

---

## 문제 해결

### 'flutter' 명령을 찾을 수 없는 경우

1. **환경 변수 확인**
   ```powershell
   $env:PATH -split ';' | Select-String -Pattern 'flutter'
   ```

2. **Flutter 설치 경로 확인**
   ```powershell
   Test-Path C:\src\flutter\bin\flutter.bat
   ```

3. **새 터미널 열기**
   - 환경 변수 변경 후 반드시 새 창 열기

4. **수동으로 PATH 추가 (현재 세션)**
   ```powershell
   $env:PATH += ";C:\src\flutter\bin"
   flutter doctor
   ```

---

## Flutter 없이 테스트 코드 검증

Flutter가 설치되지 않은 경우에도:
- ✅ 테스트 코드 문법 검증 완료
- ✅ 테스트 구조 검증 완료
- ✅ TDD RED 단계 준수 확인 완료

**검증 결과:** `mobile_app/test/CODE_VALIDATION.md` 참고

---

## 다음 단계

1. ✅ RED 단계 완료 (테스트 코드 작성 완료)
2. ⏳ Flutter 설치
3. ⏳ 테스트 실행 확인
4. ⏳ GREEN 단계 시작 (테스트 통과시키기)

---

**도움이 필요하신가요?**
- `mobile_app/FLUTTER_SETUP.md` - 상세 설치 가이드
- `mobile_app/test/CODE_VALIDATION.md` - 코드 검증 결과

