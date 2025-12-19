# Flutter 설치 스크립트 (PowerShell)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Flutter 설치 가이드" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 1. Flutter 다운로드 경로 확인
$flutterInstallPath = "C:\src\flutter"
$flutterZipPath = "$env:USERPROFILE\Downloads\flutter_windows.zip"

Write-Host "1. Flutter SDK 다운로드" -ForegroundColor Yellow
Write-Host "   다음 URL에서 Flutter SDK를 다운로드하세요:" -ForegroundColor White
Write-Host "   https://docs.flutter.dev/get-started/install/windows" -ForegroundColor Green
Write-Host "   또는 직접 다운로드:" -ForegroundColor White
Write-Host "   https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.x.x-stable.zip" -ForegroundColor Green
Write-Host ""
Write-Host "   다운로드 후 계속하려면 아무 키나 누르세요..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# 2. Flutter 압축 해제
Write-Host ""
Write-Host "2. Flutter SDK 압축 해제" -ForegroundColor Yellow

if (Test-Path $flutterZipPath) {
    Write-Host "   압축 파일을 찾았습니다: $flutterZipPath" -ForegroundColor Green
    
    # C:\src 디렉토리 생성
    if (-not (Test-Path "C:\src")) {
        New-Item -ItemType Directory -Path "C:\src" -Force | Out-Null
        Write-Host "   C:\src 디렉토리를 생성했습니다." -ForegroundColor Green
    }
    
    # 압축 해제
    Write-Host "   압축을 해제하는 중..." -ForegroundColor Yellow
    Expand-Archive -Path $flutterZipPath -DestinationPath "C:\src" -Force
    Write-Host "   압축 해제 완료!" -ForegroundColor Green
} else {
    Write-Host "   압축 파일을 찾을 수 없습니다: $flutterZipPath" -ForegroundColor Red
    Write-Host "   수동으로 압축을 해제하여 C:\src\flutter 에 배치하세요." -ForegroundColor Yellow
}

# 3. 환경 변수 설정
Write-Host ""
Write-Host "3. 환경 변수 설정" -ForegroundColor Yellow

if (Test-Path $flutterInstallPath) {
    $flutterBinPath = "$flutterInstallPath\bin"
    
    # 현재 사용자 PATH 확인
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    
    if ($currentPath -notlike "*$flutterBinPath*") {
        Write-Host "   PATH에 Flutter를 추가하는 중..." -ForegroundColor Yellow
        
        # 사용자 PATH에 추가
        $newPath = $currentPath + ";$flutterBinPath"
        [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
        
        Write-Host "   환경 변수에 추가되었습니다!" -ForegroundColor Green
        Write-Host "   ⚠️  중요: 새 PowerShell 창을 열어야 변경사항이 적용됩니다!" -ForegroundColor Red
    } else {
        Write-Host "   Flutter가 이미 PATH에 있습니다." -ForegroundColor Green
    }
} else {
    Write-Host "   Flutter 설치 경로를 찾을 수 없습니다: $flutterInstallPath" -ForegroundColor Red
    Write-Host "   수동으로 환경 변수를 설정하세요." -ForegroundColor Yellow
}

# 4. 설치 확인
Write-Host ""
Write-Host "4. 설치 확인" -ForegroundColor Yellow
Write-Host "   새 PowerShell 창을 열고 다음 명령어를 실행하세요:" -ForegroundColor White
Write-Host "   flutter doctor" -ForegroundColor Green
Write-Host ""

# 5. 추가 도구 설치 안내
Write-Host "5. 추가 도구 설치 (선택사항)" -ForegroundColor Yellow
Write-Host "   Android 개발을 위해 Android Studio 설치:" -ForegroundColor White
Write-Host "   https://developer.android.com/studio" -ForegroundColor Green
Write-Host ""
Write-Host "   VS Code Flutter 확장 프로그램:" -ForegroundColor White
Write-Host "   - VS Code에서 'Flutter' 확장 프로그램 설치" -ForegroundColor Green
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "설치 가이드 완료!" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "다음 단계:" -ForegroundColor Yellow
Write-Host "1. 새 PowerShell 창 열기" -ForegroundColor White
Write-Host "2. flutter doctor 실행" -ForegroundColor White
Write-Host "3. flutter pub get (프로젝트 디렉토리에서)" -ForegroundColor White
Write-Host "4. flutter test 실행" -ForegroundColor White


