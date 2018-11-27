#SendToフォルダパス
$SendToDirectory = Join-Path $env:USERPROFILE "\AppData\Roaming\Microsoft\Windows\SendTo"

# リンクフルパス
$LinkFullPath = Join-Path $SendToDirectory "Path to URI.lnk"

# PowerShell Path
$PowerShellPath = cmd /c where powershell

# スクリプト Path
$ScriptPath = Join-Path $PSScriptRoot "Conv2UNC.ps1"

# ショートカットコマンドライン
# $ChortcutCommandLine = $PowerShellPath + " $ScriptPath"

# ショートカットを作る
$WsShell = New-Object -ComObject WScript.Shell
$Shortcut = $WsShell.CreateShortcut($LinkFullPath)
$Shortcut.TargetPath = $PowerShellPath
$Shortcut.Arguments = $ScriptPath
$Shortcut.IconLocation = $PowerShellPath
$Shortcut.Save()
