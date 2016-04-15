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
	Func _ReverseDNS($IPAddress)
		ConsoleWrite('++_ReverseDNS() = '& $IPAddress & @crlf)
		$IPAddress = StringStripWS($IPAddress,3)
		$sCommand="nslookup "& $IPAddress
		$ResponseText = _GetDOSOutput($sCommand)
		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $ResponseText = ' & $ResponseText & @crlf )
		If StringInStr($ResponseText,"*** UnKnown")>0 Then
			Return "Unknown"
		endif
		$x1 = StringInStr($ResponseText, "Name:")
		$x2 = StringInStr($ResponseText, "Address",0,-1)
		If $x1 = 0 or $x2 = 0 Then Return "Unknown"
		Dim $arr[3]
		$arr[1]=StringStripWS(StringMid($ResponseText, $x1 + 6, $x2 - $x1 - 6),3)
		$arr[2]=StringStripWS(StringMid($ResponseText, $x2 + 8, 17),3)
		If $x1 > 0 and $x2 > 0 Then Return $arr[2]
		Return "UnknownError"
	EndFunc
	Func _GetFQDN()
		ConsoleWrite('++_GetFQDN() = '& @crlf)
		$objWMIService = ObjGet("winmgmts:{impersonationLevel = impersonate}!\\" & @ComputerName & "\root\cimv2")
		If @error Then Return SetError(2, 0, "")
		$colItems = $objWMIService.ExecQuery("SELECT Name,Domain FROM Win32_ComputerSystem ", "WQL", 0x30)
		If IsObj($colItems) Then
			For $objItem In $colItems
				If $objItem.Domain = "" Then
;~ 					Return  $objItem.Name
					Return SetError(3, 0, "")
				Else
					Return  $objItem.Name & "." & $objItem.Domain
				endif
			Next
		Else
			Return SetError(3, 0, "")
		EndIf
	EndFunc
	Func _GetServerDNSip()
		ConsoleWrite('++_GetServerDNSip() = '& @crlf)
		$fqdn=_GetFQDN()
		_consolewrite("FQDN="&$fqdn)
		$ip=_ReverseDNS($fqdn)
		_consolewrite("ServerDNSip="&$ip)
		Return $ip
	EndFunc
#endregion
#region =================================== listener   ========================================
	Func _startListener()
		ConsoleWrite('++_startListener() = '& @crlf)

	EndFunc
	Func _stopListener()
		ConsoleWrite('++_stopListener() = '& @crlf)

	EndFunc


	func _checkerror($err)
		Switch $err
			Case 1
				_ConsoleWrite("The listening address is incorrect (Possibly another server is already running): " & $listenerIP,3)
			Case 2
				_ConsoleWrite("The listening port is incorrect (Possibly another server is already running): " & $nPort,3)
			Case 10048
				_ConsoleWrite("Address already in use. " ,3)
			Case 10050
				_ConsoleWrite("Network is down. " ,3)
			Case 10013
				_ConsoleWrite("Permission denied. An attempt was made to access a socket in a way forbidden by its access permissions. " ,3)
			Case 10014
				_ConsoleWrite("Bad address. The system detected an invalid pointer address in attempting to use a pointer argument of a call" ,3)
			Case Else
				_ConsoleWrite("Unable to set up a listening server on IP " & $listenerIP & " Port " & _
								$nPort & " ERROR  NUMBER = " & $err,3 )
		EndSwitch
	EndFunc
	Func _stopListener( )
		ConsoleWrite('_stopListener( ) '& @crlf)
		TCPCloseSocket($sMainSocket)
		TCPShutdown( )
		_ConsoleWrite("Listener TCP Socket closed" ,3)
		$ListenerActive=0
	EndFunc   ;==>_CloseReceiveTCP
#endregion
