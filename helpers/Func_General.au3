#region app greneral
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
	Func _Licence()
		ConsoleWrite('++_Licence() = '& @crlf)
		If @Compiled Then
			Local $iDateCalc = _DateDiff('s', "2016/12/8 00:00:00", _NowCalc())
			If $iDateCalc > 0 Then Exit
		EndIf
	EndFunc
	Func _Exit()
;~ 		TCPSend($f_Socket, 'CANCEL')
		_EndLog()
		FileClose($hLogFile)
	EndFunc   ;==>_Exit( )
#endregion
#region Firewall
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
#region log
	Func _initLog()
		ConsoleWrite('++_initLog() = '& @crlf)
		$hLogFile = FileOpen($LogFile, 1+8)
		If $hLogFile = -1 Then
			ConsoleWrite("Error Unable to open file.")
			Exit
		EndIf
		FileWriteLine($hLogFile,"===============================================================================")
		FileWriteLine($hLogFile,"===============================================================================")
		FileWriteLine($hLogFile,_NowCalcDate()  & @TAB& "Version: "& $version)
		FileWriteLine($hLogFile,"===============================================================================")
	EndFunc
	Func _ConsoleWrite($s_text)
		_GUICtrlEdit_AppendText($hLogFile, _LogDate()&" "&$s_text & @CRLF)
		ConsoleWrite($s_text & @CRLF)
	EndFunc   ;==>_ConsoleWrite
	Func _LogDate()
		$tCur = _Date_Time_GetLocalTime()
		$tCur = _Date_Time_SystemTimeToDateTimeStr($tCur)
		$date = "[" & stringreplace($tCur,"/","-") & "] "
		return $date
	EndFunc
	Func _EndLog()
		ConsoleWrite('++_EndLog() = '& @crlf)
		FileWriteLine($hLogFile,"===============================================================================")
		FileWriteLine($hLogFile,"===============================================================================")
		FileWriteLine($hLogFile,_NowCalcDate()  & @TAB& "End of activities"
		FileWriteLine($hLogFile,"===============================================================================")
		FileClose($hLogFile)
	EndFunc
#endregion
#region file check
	Func _IsFolder($sFolder,$SkipobtainAtributesFlag=0 )
		Local $sAttribute = FileGetAttrib($sFolder)
		If @error Then
			If $SkipobtainAtributesFlag=0 Then
;~ 				MsgBox(4096, "Error 1053", "Could not obtain the file attributes."&@crlf&"$sFolder="&$sFolder&@crlf&"$sAttribute="&$sAttribute,0)
				Return 0
			else
				Return 0
			endif
		endif
		Return StringInStr($sAttribute,"D")
	EndFunc
	Func _FileInUse($filename)
		$handle = FileOpen($filename, 1)
		$result = False
		if $handle = -1 then $result = True
		FileClose($handle)
		ConsoleWrite('_FileInUse $filename= ' & $filename& " $result= "&$result & @crlf )
		return $result
	EndFunc
	Func _ByteSuffix($iBytes)
		$iIndex = 0
		Dim $aArray[9] = [' bytes', ' KB', ' MB', ' GB', ' TB', ' PB', ' EB', ' ZB', ' YB']
		While $iBytes > 1023
			$iIndex += 1
			$iBytes /= 1024
		WEnd
		Return Round($iBytes) & $aArray[$iIndex]
	EndFunc   ;==>ByteSuffix
#endregion
#region stdout
	Func _GetDOSOutput($sCommand,$sWorkingdir)
	   Local $iPID, $sOutput = ""
	   $iPID = Run('"' & @ComSpec & '" /c ' & $sCommand, $sWorkingdir, @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	   Local $begin = TimerInit()
	   While TimerDiff($begin) < 180000  ;180 sec
		   $sOutput &= StdoutRead($iPID, False, False)
		   If @error Then
			   ExitLoop
		   EndIf
		   ;Sleep(10)
	   WEnd
	   Return $sOutput
   EndFunc   ;==>_GetDOSOutput
#endregion
#region encryption
	Func _Hashing($Password,$Hashflag=0)
		ConsoleWrite('++_Hashing() = '& @crlf )
			if $Hashflag=0 then
				Local $bEncrypted = _StringEncrypt(1,$Password,$HashingPassword,1)
			Else
				Local $bEncrypted = _StringEncrypt(0,$Password,$HashingPassword,1)
			EndIf
		return $bEncrypted
	EndFunc
#endregion
#region sciTe
	Func _ClearSciteConsole()
		ConsoleWrite('++_ClearSciteConsole() = '& @crlf)
		ControlSend("[CLASS:SciTEWindow]", "", "Scintilla2", "+{F5}")
	EndFunc
#endregion
