Add-Type -AssemblyName System.Drawing

# 300x300 크기의 이미지 생성
$bitmap = New-Object System.Drawing.Bitmap(300, 300)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)

# 배경색 설정 (파란색)
$brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(45, 127, 184))
$graphics.FillRectangle($brush, 0, 0, 300, 300)

# 텍스트 추가
$font = New-Object System.Drawing.Font('Arial', 40, [System.Drawing.FontStyle]::Bold)
$textBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
$stringFormat = New-Object System.Drawing.StringFormat
$stringFormat.Alignment = [System.Drawing.StringAlignment]::Center
$stringFormat.LineAlignment = [System.Drawing.StringAlignment]::Center

$graphics.DrawString('이주원', $font, $textBrush, 150, 150, $stringFormat)

# 정리
$graphics.Dispose()

# 저장 경로
$outputDir = "c:\Users\user1\virtuebb.github.io\assets\images"
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
}

$outputPath = Join-Path $outputDir "myprofile.jpg"
$bitmap.Save($outputPath)
$bitmap.Dispose()

Write-Host "Profile image created successfully!"
