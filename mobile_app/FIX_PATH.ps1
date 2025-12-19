# Flutter PATH 영구 설정 스크립트

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Flutter PATH 환경 변수 설정" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$flutterBinPath = "C:\src\flutter\bin"

# 현재 사용자 PATH 확인
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")

if ($currentPath -notlike "*$flutterBinPath*") {
    Write-Host "PATH에 Flutter를 추가하는 중..." -ForegroundColor Yellow
    
    # 사용자 PATH에 추가
    $newPath = $currentPath + ";$flutterBinPath"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    
    Write-Host "✅ 환경 변수에 추가되었습니다!" -ForegroundColor Green
    Write-Host ""
    Write-Host "⚠️  중요: 새 PowerShell 창을 열어야 변경사항이 적용됩니다!" -ForegroundColor Red
    Write-Host ""
    Write-Host "다음 단계:" -ForegroundColor Yellow
    Write-Host "1. 이 스크립트를 닫고 새 PowerShell 창을 엽니다" -ForegroundColor White
    Write-Host "2. flutter doctor 명령을 실행합니다" -ForegroundColor White
    Write-Host "3. cd C:\DEV\Cursor_pro\QR_Menu\mobile_app" -ForegroundColor White
    Write-Host "4. flutter pub get" -ForegroundColor White
    Write-Host "5. flutter test" -ForegroundColor White
} else {
    Write-Host "✅ Flutter가 이미 PATH에 있습니다." -ForegroundColor Green
    Write-Host ""
    Write-Host "현재 PATH에 Flutter가 포함되어 있지만," -ForegroundColor Yellow
    Write-Host "현재 세션에서는 새 PowerShell 창을 열어야 적용됩니다." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan


