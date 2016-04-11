#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=.\images\FGMagent.ico
#AutoIt3Wrapper_Outfile=.\release\FGMagent.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Comment=FGM Agent - Management & Automation
#AutoIt3Wrapper_Res_Description=File God Mode Agent service
#AutoIt3Wrapper_Res_Fileversion=0.1.0.1
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
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;~ #Obfuscator_Parameters=/cs=1 /cn=1 /cf=1 /cv=1 /sf=1 /sv=1
;~ #Obfuscator_Parameters=/cs=1 /cn=1 /cf=1 /cv=1 /sf=1
;~ #AutoIt3Wrapper_Run_After=start c:\dropbox\Sharedqed\RobertoI@MarceloSaied\FGM_Agent\Release\updaterCompilerDEV.cmd
#include <Misc.au3>

If _Singleton(@ScriptName, 1) = 0 Then ; allow only one instance
	_ConsoleWrite(0, "Warning", "An occurence of " & @ScriptName & " is already running")
	Exit
EndIf

#region LoadInit
		_ConsoleWrite('++_LoadInit()'& @crlf)

		Sleep(1000)
		#include <Includes\includes.au3>
		_Licence()
		_ConsoleWrite('Version = '&FileGetVersion(@ScriptName),0,16,"","","","0x2C3539","0x0FFFC19")& @crlf)
		FileWriteLine($logFile,'Get_SAPSYSTEM' & "()"& @crlf)
;~ 		Opt("GUIOnEventMode", 1)
;~ 		AutoItSetOption("WinTitleMatchMode", 4)
;~ 		GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
;~ 		GUIRegisterMsg($WM_SYSCOMMAND, "WM_SYSCOMMAND")
;~ 		GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

;~ 		_ConfigDBInitial()
		_ReduceMemory()
#endregion
While 1
	Sleep(100)
WEnd
_Exit()

