#REGION GENERAL
	Global $oMyError = ObjEvent("AutoIt.Error","MyErrFunc")
	$WebServiceaddr="acnalert.cloudapp.net/ncc"
	$version= FileGetVersion(@ScriptName)
#endregion
#region MAIN
	$fFlag=FALSE
	$LoginFlag=False
#endregion
#region form

#endregion
#region colores
	$red="0xff0000"
	$LightSalmon="0xFFA07A"
	$green="0x00ff00"
	$gray=_WinAPI_GetSysColor($COLOR_INACTIVEBORDER )
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $gray = ' & $gray & @crlf )
#endregion