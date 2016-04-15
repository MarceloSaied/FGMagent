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
#region Error Handeler
	Global Const $oErrorHandler = ObjEvent("AutoIt.Error", "ObjErrorHandler")
	Func ObjErrorHandler()
		ConsoleWrite(   "A COM Error has occured!" & @CRLF  & @CRLF & _
                                "err.description is: "    & @TAB & $oErrorHandler.description    & @CRLF & _
                                "err.windescription:"     & @TAB & $oErrorHandler & @CRLF & _
                                "err.number is: "         & @TAB & Hex($oErrorHandler.number, 8)  & @CRLF & _
                                "err.lastdllerror is: "   & @TAB & $oErrorHandler.lastdllerror   & @CRLF & _
                                "err.scriptline is: "     & @TAB & $oErrorHandler.scriptline     & @CRLF & _
                                "err.source is: "         & @TAB & $oErrorHandler.source         & @CRLF & _
                                "err.helpfile is: "       & @TAB & $oErrorHandler.helpfile       & @CRLF & _
                                "err.helpcontext is: "    & @TAB & $oErrorHandler.helpcontext & @CRLF _
                            )
	EndFunc
#endregion
#region Firewall
	Func ___SetFirewall()
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
		_GUICtrlEdit_AppendText($hLogFile,"===============================================================================" & @CRLF)
		_GUICtrlEdit_AppendText($hLogFile,"==============================================================================="& @CRLF)
		_GUICtrlEdit_AppendText($hLogFile,_NowCalcDate()  & @TAB& "Start of activities"& @TAB& "Version: "& $version& @CRLF)
		_GUICtrlEdit_AppendText($hLogFile,"==============================================================================="& @CRLF)
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
		_GUICtrlEdit_AppendText($hLogFile,"..............................................................................." & @CRLF)
		_GUICtrlEdit_AppendText($hLogFile,_NowCalcDate()   & @TAB& "End of activities")
		_GUICtrlEdit_AppendText($hLogFile............................................................................... & @CRLF& @CRLF)
		FileClose($hLogFile)
	EndFunc
#endregion
#region file check
	Func ___IsFolder($sFolder,$SkipobtainAtributesFlag=0 )
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
	Func ___FileInUse($filename)
		$handle = FileOpen($filename, 1)
		$result = False
		if $handle = -1 then $result = True
		FileClose($handle)
		ConsoleWrite('_FileInUse $filename= ' & $filename& " $result= "&$result & @crlf )
		return $result
	EndFunc
	Func ___ByteSuffix($iBytes)
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
	Func _GetDOSOutput($sCommand,$sWorkingdir="")
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
	Func _Hashing($Password,$Hashflag=0)  ;1 to encrypt, 0 to decrypt.
		ConsoleWrite('++_Hashing() = '&$Hashflag& @crlf )
			if $Hashflag=0 then
				Local $bEncrypted = _StringEncrypt(0,$Password,$HashingPassword,1) ;0 to decrypt
			Else
				Local $bEncrypted = _StringEncrypt(1,$Password,$HashingPassword,1)  ;1 to encrypt
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
#region time
	Func _GetUnixTime($sDate = 0);Date Format: 2013/01/01 00:00:00 ~ Year/Mo/Da Hr:Mi:Se
		Local $aSysTimeInfo = _Date_Time_GetTimeZoneInformation()
		Local $utcTime = ""
		If Not $sDate Then $sDate = _NowCalc()
		If Int(StringLeft($sDate, 4)) < 1970 Then Return ""
		If $aSysTimeInfo[0] = 2 Then
			$utcTime = _DateAdd('n', $aSysTimeInfo[1] + $aSysTimeInfo[7], $sDate)
		Else
			$utcTime = _DateAdd('n', $aSysTimeInfo[1], $sDate)
		EndIf
		Return _DateDiff('s', "1970/01/01 00:00:00", $utcTime)
	EndFunc   ;==>_GetUnixTime
#endregion


;~ Func _ServerIP()
;~ 	ConsoleWrite('++_ServerIP() = '& @crlf)
;~ 	TCPStartup()
;~ 	$serverip= TCPNameToIP(@ComputerName)
;~ 	_ConsoleWrite("Server name ="&@ComputerName & @TAB & "server ip="&$serverip)
;~ 	TCPShutdown()
;~ 	Return $serverip
;~ EndFunc






