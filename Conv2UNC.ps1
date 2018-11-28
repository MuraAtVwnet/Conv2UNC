###########################################################
# 物理 Path を求める
###########################################################
function ConvL2P( $TergetPath ){
	$DriveLetter = Split-Path $TergetPath -Qualifier -ErrorAction SilentlyContinue

	if( $DriveLetter -ne $null ){
		$DriveName = $DriveLetter.Replace(":","")
		$NetworkRoot = (Get-PSDrive $DriveName).DisplayRoot
		if( $NetworkRoot -ne $null ){
			$TergetDirectory = Split-Path  $TergetPath -NoQualifier
			$PhysicalPath = Join-Path $NetworkRoot $TergetDirectory
		}
		else{
			$PhysicalPath = $TergetPath
		}
	}
	else{
		$PhysicalPath = $TergetPath
	}

	return $PhysicalPath
}

###########################################################
# URI にし、クリップボートに転送
###########################################################
function SetURI2Clip($PhysicalPaths){
	$URIs = @()
	foreach( $PhysicalPath in $PhysicalPaths ){
		$URIs += "<file://" + $PhysicalPath + ">"
	}

	# エンコードを S-JIS に変更
	$OutputEncoding = [Console]::OutputEncoding

	# リップボードへ
	$URIs | clip

	# エンコードを US-ASCII に戻す
	$OutputEncoding = New-Object System.Text.ASCIIEncoding
}


###########################################################
# main
###########################################################

if( $args.Count -ne 0 ){
	$PhysicalPaths = @()
	foreach( $arg in $args ){
		$PhysicalPaths += ConvL2P $arg
	}
	SetURI2Clip $PhysicalPaths
}
else{
	echo "ファイル名が指定されていません"
}
