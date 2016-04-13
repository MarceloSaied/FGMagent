#region  ================================== INIT ======================================

#endregion
#region  ================================== Helpers ======================================
	Func _getToken()
		ConsoleWrite('++_getToken() = '& @crlf)
;~ 		$StartTicks = _TimeToTicks(@HOUR, @MIN, @SEC)
		$StartTicks = _GetUnixTime()
		$EndTicks = $StartTicks + 15
		Local $var1=_Hashing($passcode&$EndTicks,1)
		Return $var1
	EndFunc
	Func _IsValidToken($token)
		ConsoleWrite('++_ParseToken() = '&$token& @crlf)
		Local $var1=_Hashing($token,0)
		Local $var2=StringReplace($var1,$passcode,"")
		ConsoleWrite('-- Debug(' & @ScriptLineNumber & ') : $var2 = ' & $var2 & @crlf )
;~ 		$NowTicks = _TimeToTicks(@HOUR, @MIN, @SEC)
		$NowTicks = _GetUnixTime()
		ConsoleWrite('-- Debug(' & @ScriptLineNumber & ') : $NowTicks = ' & $NowTicks & @crlf )
		If $var2>$NowTicks Then
			Return True
		Else
			Return false
		endif
	EndFunc

#endregion
#region =================================== listener   ========================================


#endregion
