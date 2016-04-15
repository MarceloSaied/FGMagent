#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=.\images\marvin_robot.ico
#AutoIt3Wrapper_Outfile=.\release\FGMagent.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Change2CUI=y
#AutoIt3Wrapper_Res_Comment=FGM Agent - Management & Automation
#AutoIt3Wrapper_Res_Description=File God Mode Agent service
#AutoIt3Wrapper_Res_Fileversion=0.1.0.9
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_ProductVersion=0.1
#AutoIt3Wrapper_Res_LegalCopyright=Marcelo N. Saied & Roberto P Iralour . All rights reserved
#AutoIt3Wrapper_Res_Field=Productname|File God Mode Agent service
#AutoIt3Wrapper_Res_Field=ProductVersion|Version 1.0.0.0
#AutoIt3Wrapper_Res_Field=Manufacturer |Marcelo N. Saied & Roberto P Iralour . All rights reserved
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time
#AutoIt3Wrapper_Tidy_Stop_OnError=n
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/mergeonly
#AutoIt3Wrapper_Run_After=start c:\dropbox\Shared\RobertoI@MarceloSaied\FGMagent\automation\deployDEV.cmd  %fileversion%
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;~ #Obfuscator_Parameters=/cs=1 /cn=1 /cf=1 /cv=1 /sf=1 /sv=1
;~ #Obfuscator_Parameters=/cs=1 /cn=1 /cf=1 /cv=1 /sf=1
;~
#region LoadInit
	#include <Includes\includes.au3>
	#include <Misc.au3>
	If _Singleton(@ScriptName, 1) = 0 Then ; allow only one instance
		_ConsoleWrite("Warning - An occurence of " & @ScriptName & " is already running")
		Exit
	EndIf
	_Licence()
	_initLog()
	_ReduceMemory()
	#cs
		; """""    testings  for token +++++++
	$var=_getToken()
	While 1
			ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : _IsValidToken($var) = ' & _IsValidToken($var) & @crlf )
			ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $var = ' & $var & @crlf )

		Sleep(1000)
	WEnd
	#ce
#endregion
#region main
	_startListener()
	$ServiceIdleTimerInit=TimerInit()
	While $ListenerActive
		If _TCPacceptConnection() Then

		endif
		If TimerDiff($ServiceIdleTimerInit)>$ServiceIdletimeout And $ConnectedSocket = -1 Then
			_ConsoleWrite("Service Closing due timeout ("&$ServiceIdletimeout&")",1)
			ExitLoop
		EndIf
;~ 	WaitResponse('START_UL','START_UL',50,60000)
		Sleep(10)
	WEnd
#endregion
If @Compiled Then  _stopListener()
_Exit()




