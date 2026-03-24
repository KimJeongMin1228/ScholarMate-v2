# ============================================
# ScholarMate 장학금 동기화 + 전처리 스크립트
# PowerShell / VSCode 터미널용
# ============================================

# 1. 가상환경 활성화
$venvPath = ".\venv\Scripts\Activate.ps1"
if (Test-Path $venvPath) {
    Write-Host "🔹 가상환경 활성화 중..."
    & $venvPath
} else {
    Write-Error "❌ 가상환경을 찾을 수 없습니다: $venvPath"
    exit
}

# 2. Raw → Scholarship 동기화
Write-Host "🔹 sync_scholarships 실행 중..."
python manage.py sync_scholarships
if ($LASTEXITCODE -ne 0) {
    Write-Error "❌ sync_scholarships 실행 실패"
    exit
}

# 3. 장학금 지역 전처리
Write-Host "🔹 process_scholarship_regions 실행 중..."
python manage.py process_scholarship_regions
if ($LASTEXITCODE -ne 0) {
    Write-Error "❌ process_scholarship_regions 실행 실패"
    exit
}

Write-Host "✅ 모든 작업 완료! Scholarship DB가 업데이트되었습니다."
