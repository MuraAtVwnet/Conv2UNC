# SendTo
# ドライブレター取出し
# Get-Psdrive でドライブレターを　UNC に変換

Param( $TergetPath )

# $TergetPath = "I:\04_セキュリティ横断\48_マルウェア技術ドキュメント\CM77\CLI_CR_770.pdf"
$DriveLetter = Split-Path $TergetPath -Qualifier -ErrorAction SilentlyContinue

if( $DriveLetter -ne $null ){
	$DriveName = $DriveLetter.Replace(":","")
	$NetworkRoot = (Get-PSDrive $DriveName).DisplayRoot
	$TergetDirectory = Split-Path  $TergetPath -NoQualifier
	$NetworkPath = Join-Path $NetworkRoot $TergetDirectory
}
else{
	$NetworkPath = $TergetPath
}

$URI = "<file://" + $NetworkPath + ">"

# エンコードを S-JIS に変更
$OutputEncoding = [Console]::OutputEncoding

# リップボードへ
$URI | clip

# エンコードを US-ASCII に戻す
$OutputEncoding = New-Object System.Text.ASCIIEncoding



