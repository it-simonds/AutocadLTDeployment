Set objShell = CreateObject("WScript.Shell")
objShell.Run "powershell.exe -ExecutionPolicy Bypass -File C:\Temp\Copy-Installer.ps1", 0, False
