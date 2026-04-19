param(
    [string]$ExePath = "$PSScriptRoot/../build/vscode-desktop-debug/myapp.exe",
    [int]$Seconds = 5
)

$resolvedExe = [System.IO.Path]::GetFullPath($ExePath)
if (-not (Test-Path $resolvedExe)) {
    Write-Error "Executable not found: $resolvedExe"
    exit 2
}

$env:PATH = "E:/Qt/Qt/6.8.3/mingw_64/bin;E:/Qt/Qt/Tools/mingw1310_64/bin;" + $env:PATH
$env:QT_QPA_PLATFORM = "offscreen"

$p = Start-Process -FilePath $resolvedExe -PassThru -WindowStyle Hidden
Start-Sleep -Seconds $Seconds

if (-not $p.HasExited) {
    $p.Kill()
    Write-Host "smoke-ok"
    exit 0
}

Write-Host ("smoke-exit-" + $p.ExitCode)
exit 1