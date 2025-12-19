# Windows Symlink 오류 해결 가이드

## 문제
```
Error: Building with plugins requires symlink support.
Please enable Developer Mode in your system settings.
```

## 해결 방법

### 방법 1: Developer Mode 활성화 (권장)

1. **설정 앱 열기**
   - Windows 키 + I
   - 또는 시작 메뉴에서 "설정" 검색

2. **개인 정보 보호 및 보안** → **개발자용** 이동

3. **개발자 모드** 토글을 **켜기**로 변경

4. **경고 확인**
   - "개발자 모드 사용" 확인 대화상자가 나타나면 "예" 클릭

5. **새 터미널 열기** ⚠️ 중요
   - 설정 변경 후 반드시 새 PowerShell 또는 CMD 창을 열어야 함

6. **앱 다시 실행**
   ```powershell
   cd C:\DEV\Cursor_pro\QR_Menu\mobile_app
   c:\src\flutter\bin\flutter.bat run -d windows
   ```

### 방법 2: PowerShell에서 직접 설정 열기

```powershell
# 개발자 설정 페이지 열기
start ms-settings:developers
```

그 다음 위의 방법 1의 3-6단계를 따르세요.

### 방법 3: 관리자 권한으로 Symlink 활성화 (대안)

Developer Mode를 활성화할 수 없는 경우:

1. **관리자 권한 PowerShell 열기**
   - Windows 키 + X
   - "Windows PowerShell(관리자)" 선택

2. **로컬 정책 편집기 실행**
   ```powershell
   gpedit.msc
   ```

3. **정책 경로 이동**
   - 컴퓨터 구성 → Windows 설정 → 보안 설정 → 로컬 정책 → 사용자 권한 할당
   - "심볼릭 링크 만들기" 찾기

4. **사용자 추가**
   - "심볼릭 링크 만들기" 더블 클릭
   - "사용자 또는 그룹 추가" 클릭
   - 현재 사용자 계정 추가
   - 확인 클릭

5. **컴퓨터 재시작**

---

## 확인 방법

Developer Mode가 활성화되었는지 확인:

```powershell
# 레지스트리 확인
Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name AllowDevelopmentWithoutDevLicense
```

**예상 출력:**
```
AllowDevelopmentWithoutDevLicense : 1
```

값이 1이면 Developer Mode가 활성화된 것입니다.

---

## 참고사항

- **Developer Mode 활성화는 안전합니다**
  - 개발 목적으로만 사용됩니다
  - 시스템 보안에 영향을 주지 않습니다
  - 필요 없을 때 언제든지 끌 수 있습니다

- **대안: Chrome에서 실행**
  - Developer Mode를 활성화하지 않고도 웹 버전으로 실행 가능
  ```powershell
   c:\src\flutter\bin\flutter.bat run -d chrome
   ```

---

## 문제가 계속되는 경우

1. **Flutter 캐시 정리**
   ```powershell
   c:\src\flutter\bin\flutter.bat clean
   c:\src\flutter\bin\flutter.bat pub get
   ```

2. **Visual Studio 설치 확인**
   - Windows 개발을 위해 Visual Studio가 필요할 수 있습니다
   - `flutter doctor` 명령으로 확인

3. **웹 버전으로 실행**
   - Chrome이나 Edge에서 실행하면 symlink 문제를 피할 수 있습니다

