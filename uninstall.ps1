# Param( [switch]$AllUser )

#SendToフォルダパス
$SendToDirectory = Join-Path $env:APPDATA "\Microsoft\Windows\SendTo"

# 全ユーザー対象の時は Default に入れる(期待動作しなかったのでコメントアウト)
# if( $AllUser ){
#	$UserName = $env:USERNAME
#	$SendToDirectory = $SendToDirectory.Replace($UserName, "Default")
# }

# リンクフルパス
$LinkFullPath = Join-Path $SendToDirectory "Path to URI.lnk"

if( Test-Path $LinkFullPath ){
	Remove-Item $LinkFullPath -Force -Recurse
}
