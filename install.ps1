﻿#SendToフォルダパス
$SendToDirectory = Join-Path $env:APPDATA "\Microsoft\Windows\SendTo"

# リンクフルパス
$LinkFullPath = Join-Path $SendToDirectory "Path to URI.lnk"

# PowerShell Path
$PowerShellPath = cmd /c where powershell

# スクリプト Path
$ScriptPath = Join-Path $PSScriptRoot "Conv2UNC.ps1"

# ショートカットコマンドライン
$ChortcutCommandLine = "-NoProfile -NoLogo -File $ScriptPath"

# ショートカットを作る
$WsShell = New-Object -ComObject WScript.Shell
$Shortcut = $WsShell.CreateShortcut($LinkFullPath)
$Shortcut.TargetPath = $PowerShellPath
$Shortcut.Arguments = $ChortcutCommandLine
$Shortcut.IconLocation = $PowerShellPath
$Shortcut.WindowStyle = 7
$Shortcut.Save()
