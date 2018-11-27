function Conv2UNC( $TergetPath ){
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
}

# echo $args.Count
# echo $args
# pause

if( $args.Count -eq 1 ){
	Conv2UNC $args[0]
}
else{
	echo "ファイル名が正しくありません: $args"
}
