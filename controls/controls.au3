Func WM_COMMAND($hWnd, $iMsg, $iwParam, $ilParam)  ; Handle WM_COMMAND messages en botones y checkboxes
  ;---------------------
    Local $nNotifyCode = _HiWord($iwParam)
    Local $nID = _LoWord($iwParam)
	ConsoleWrite("!+$nID" & $nID & @CRLF)
	;ConsoleWrite("--$iMsg" & $iMsg & @CRLF)
		Switch $nID
			Case $B_Close
				$fFlag = True
				Return $GUI_RUNDEFMSG
			;--------   bototnes
			case $B_Clear
				loadForm()
			case $B_Save
				Savedata()
			case $B_NCCgo
				if GUICtrlRead($C_NCCnumber)<>"" then
					search()
				endif
			; --------  cambio de combo
			Case $C_NCCnumber
				Switch $nNotifyCode
					Case $CBN_EDITCHANGE
						_GUICtrlComboBox_AutoComplete($C_NCCnumber)
					Case $CBN_EDITUPDATE,$CBN_SELCHANGE ; when user types in new data
						ZerosizeFields()
				EndSwitch
				GUICtrlSetBkColor($B_NCCgo,$LightSalmon)
		EndSwitch
	;$C_NCCnumber
	if StringStripWS(GUICtrlRead($C_NCCnumber),3)<>"" then
		GUICtrlSetState($B_NCCgo,$GUI_ENABLE)
	else
		GUICtrlSetState($B_NCCgo,$GUI_DISABLE)
	endif
	; $B_Save
	if StringStripWS(GUICtrlRead($C_NCCnumber),3)<>"" And StringStripWS(GUICtrlRead($T_Task),3)<>"" then
		GUICtrlSetState($B_Save,$GUI_ENABLE)
	else
		GUICtrlSetState($B_Save,$GUI_DISABLE)
	endif
EndFunc
;#####################################################
;####################################################
#region
		Func WM_SYSCOMMAND($hWnd, $iMsg, $iwParam, $ilParam)  ; Handle WM_SYSCOMMAND messages
			#forceref $hWnd, $iMsg, $ilParam
			Local $nNotifyCode = BitShift($iwParam, 16)
		    Local $nID = BitAND($iwParam, 0x0000FFFF)
			Local $hCtrl = $ilParam

			Switch $iwParam
			Case $SC_CLOSE
					ConsoleWrite("!Exit pressed" & @LF)
					$fFlag = True
					Return $GUI_RUNDEFMSG
		;~ 		Case 0x0000F095 ;$MenuItem_About)
		;~ 			AboutEvent()
		;~ 		Case $SC_RESTORE
		;~ 			ConsoleWrite("!Restore window" & @LF)
		;~ 			Return 0
		;~ 		Case $SC_MINIMIZE
		;~ 			ConsoleWrite("!Minimize Window" & @LF)
		;~ 			Return 0
		;~ 		Case $SC_MOUSEMENU + 3
		;~ 			ConsoleWrite("!System menu pressed" & @LF)
		;~ 		Case $SC_MOVE
		;~ 			ConsoleWrite("!System menu Move Option pressed" & @LF)
		;~ 			Return 0
		;~ 		Case $SC_SIZE
		;~ 			ConsoleWrite("!System menu Size Option pressed" & @LF)
		;~ 			Return 0
		;~ 		Case $SC_MOUSEMENU + 2 ; This and the following case statements are only valid when the GUI is resizable
		;~ 			ConsoleWrite("!Right side of GUI clicked" & @LF)
		;~ 			Return 0
		;~ 		Case $SC_MOUSEMENU + 1
		;~ 			ConsoleWrite("!Left side of GUI clicked" & @LF)
		;~ 			Return 0
		;~ 		Case $SC_MOUSEMENU + 8
		;~ 			ConsoleWrite("!Lower Right corner of GUI clicked" & @LF)
		;~ 			Return 0
		;~ 		Case $SC_MOUSEMENU + 7
		;~ 			ConsoleWrite("!Lower Left corner of GUI clicked" & @LF)
		;~ 			Return 0
		;~ 		Case $SC_MOUSEMENU + 6
		;~ 			ConsoleWrite("!Bottom side of GUI clicked" & @LF)
		;~ 			Return 0
		;~ 		Case Else
		;~ 			MsgBox(0, "WM_SYSCOMMAND", "GUIHWnd" & @TAB & ":" & $hWnd & @LF & _
		;~ 					"MsgID" & @TAB & ":" & $msg & @LF & _
		;~ 					"iwParam" & @TAB & ":" & $iwParam & @LF & _
		;~ 					"ilParam" & @TAB & ":" & $ilParam & @LF & @LF & _
		;~ 					"WM_SYSCOMMAND - Infos:" & @LF & _
		;~ 					"-----------------------------" & @LF & _
		;~ 					"Code" & @TAB & ":" & $nNotifyCode & @LF & _
		;~ 					"CtrlID" & @TAB & ":" & $nID & @LF & _
		;~ 					"CtrlHWnd" & @TAB & ":" & $hCtrl)
				EndSwitch
			EndFunc
#endregion
;####################################################
;####################################################
Func _HiWord($x)
    Return BitShift($x, 16)
EndFunc
Func _LoWord($x)
    Return BitAND($x, 0xFFFF)
EndFunc