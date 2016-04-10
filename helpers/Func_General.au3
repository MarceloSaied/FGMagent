	Func _ReduceMemory($i_PID = -1)
		If $i_PID = -1 or ProcessExists($i_PID) = 0 Then
			Local $ai_GetCurrentProcess = DllCall('kernel32.dll', 'ptr', 'GetCurrentProcess')
			Local $ai_Return = DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'ptr', $ai_GetCurrentProcess[0])
			Return $ai_Return[0]
		EndIf

		Local $ai_Handle = DllCall("kernel32.dll", 'ptr', 'OpenProcess', 'int', 0x1f0fff, 'int', False, 'int', $i_PID)
		Local $ai_Return = DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'ptr', $ai_Handle[0])
		DllCall('kernel32.dll', 'int', 'CloseHandle', 'ptr', $ai_Handle[0])
		Return $ai_Return[0]
	EndFunc
#region *********** Firewall
	Func SetFirewall()
		$f_sav = @ScriptDir & '\Pocket-SF.sav'
		$_GetIP = @IPAddress1
		Local $s_reg = 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', $f_fopen, $f_Socket, $f_tray
	;~ 	Local $p_MD5 = PluginOpen('MD5.dll')

		$s_locip = @IPAddress1

		If Not FileExists($f_sav) Then
			ShellExecute("cmd.exe", 'netsh firewall add allowedprogram ' & @ScriptFullPath _
				& " " & 'ACNalertFT ENABLE ALL', "", "", @SW_HIDE) ;Add firewall exception

			For $i = 1 To 3
				FileWrite($f_sav, @CRLF)
			Next
		EndIf
	EndFunc
#endregion

	Func _ConsoleWrite($s_text, $n_Call = 2)
		If $n_Call = 1 Then
			_GUICtrlEdit_AppendText($e_csle, $s_text & @CRLF)
			ConsoleWrite($s_text & @CRLF)
			_CANCEL( )
		Else
			_GUICtrlEdit_AppendText($e_csle, $s_text & @CRLF)
			ConsoleWrite($s_text & @CRLF)
		EndIf
	EndFunc   ;==>_ConsoleWrite

	Func _OnFTExit( )
		Local $f_tray, $f_Socket, $p_MD5
		_TrayIconDelete($f_tray)
		PluginClose($p_MD5)
		TCPSend($f_Socket, 'CANCEL')
	EndFunc   ;==>_OnFTExit