###########################################################
# 物理 Path を求める
###########################################################
function ConvL2P( $TergetPath ){

	if( $TergetPath -ne $null ){
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
	}
	else{
		$PhysicalPath = $null
	}

	return $PhysicalPath
}

###########################################################
# ショートカットのリンク先を得る
###########################################################
function GetLink( $LinkFullPath ){
	if( Test-Path $LinkFullPath ){
		$WsShell = New-Object -ComObject WScript.Shell
		$Shortcut = $WsShell.CreateShortcut($LinkFullPath)
		$Link = $Shortcut.TargetPath
	}
	else{
		$Link = $null
	}

	return $Link
}


###########################################################
# URI にし、クリップボートに転送
###########################################################
function SetURI2Clip($PhysicalPaths){
	$URIs = @()
	foreach( $PhysicalPath in $PhysicalPaths ){
		if( $PhysicalPath -ne $null ){
			$URIs += "<file://" + $PhysicalPath + ">"
		}
	}

	if( $URIs.Count -ne 0 ){
		# エンコードを S-JIS に変更
		$OutputEncoding = [Console]::OutputEncoding

		# リップボードへ
		$URIs | clip

		# エンコードを US-ASCII に戻す
		$OutputEncoding = New-Object System.Text.ASCIIEncoding
	}
}


###########################################################
# main
###########################################################

if( $args.Count -ne 0 ){
	$PhysicalPaths = @()
	foreach( $arg in $args ){
		# シートカットだったら Link にする
		if( $arg -like "*.lnk" ){
			$arg = GetLink $arg
		}

		# 物理 Path 取得
		$PhysicalPaths += ConvL2P $arg
	}

	# クリップボード に送る
	SetURI2Clip $PhysicalPaths
}
