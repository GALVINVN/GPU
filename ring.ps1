$processName = "rigel"
$scriptPath = "C:\Users\Public\Downloads\run.ps1"

while ($true) {

    if (-not (Get-Process -Name $processName -ErrorAction SilentlyContinue)) {
        Start-Process powershell.exe `
            -ArgumentList "-ExecutionPolicy Bypass -File `"$scriptPath`""
    }

    Start-Sleep -Seconds 3
}
