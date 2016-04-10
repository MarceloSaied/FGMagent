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
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Run_Before=cmd /c c:\dropbox\Shared\RobertoI@MarceloSaied\FGM_Agent\Release\updaterCompilerDEV.cmd
#AutoIt3Wrapper_Run_After=start c:\dropbox\Shared\RobertoI@MarceloSaied\FGM_Agent\Release\deployDEV.cmd  %fileversion%
#AutoIt3Wrapper_Tidy_Stop_OnError=n
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/mergeonly
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;~ #Obfuscator_Parameters=/cs=1 /cn=1 /cf=1 /cv=1 /sf=1 /sv=1
;~ #Obfuscator_Parameters=/cs=1 /cn=1 /cf=1 /cv=1 /sf=1
#include <Misc.au3>
If _Singleton(@ScriptName, 1) = 0 Then ; allow only one instance
	MsgBox(0, "Warning", "An occurence of " & @ScriptName & " is already running")
	Exit
EndIf

;~ #region LoadInit
;~ 		ConsoleWrite('++_LoadInit() = '& @crlf)
;~ 		#include <forms\_progressGUI.au3>
;~ 		Global $splashH = _ProgressGUI("FGM   File God Mode" & @CRLF & "          " & _
;~ 		FileGetVersion(@ScriptName),0,16,"","","","0x2C3539","0x0FFFC19")
;~ 		Sleep(1000)
;~ 		#include <Includes\includes.au3>
;~ 		#include <controls\updateDEV.au3>
;~ 		_Licence()

;~ 		Opt("GUIOnEventMode", 1)
;~ 		AutoItSetOption("WinTitleMatchMode", 4)
;~ 		GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
;~ 		GUIRegisterMsg($WM_SYSCOMMAND, "WM_SYSCOMMAND")
;~ 		GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

;~ 		_ConfigDBInitial()
;~ 		Sleep(2000)
;~ 		#include <forms/FormMain.au3>
;~ 		_checkVersion()
;~ 		_ReduceMemory()
;~ 		GUIDelete($splashH[0])
;~ 		_MainFormBTNdisable(1)
;~ #endregion
While 1
	Sleep(100)
WEnd
Exit

