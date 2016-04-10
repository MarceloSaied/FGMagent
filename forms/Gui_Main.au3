
$wide=700
$high=450
$top=0
$sideMid=330
#Region ### START Koda GUI section ### Form=C:\Dropbox\proyects\Autoit\NCCperformance\NCCperformance.kxf
	$MainfORM = GUICreate("NCC Performance Tracker " & $version, 694, 449, -1, -1)

; ---------- fixed data
$top=$top+5
	$Label1 = GUICtrlCreateLabel(@UserName, $wide-130, $top, 130, 17)
;~ 	GUICtrlSetBkColor(-1,$red)
	$Label2 = GUICtrlCreateLabel(@ComputerName, $wide-130, $top+40, 130, 17)
;~ 	GUICtrlSetBkColor(-1,$green)
	$Label3 = GUICtrlCreateLabel(_NowDate(), $wide-130,$top+20, 130, 17)
;~ 	GUICtrlSetBkColor(-1,$red)
	$L_Alert=GUICtrlCreateLabel("", 330,$top, 200, 17)
;------------
	$Label11 = GUICtrlCreateLabel("NCC Number", 15, $top, 66, 17)
	$C_NCCnumber = GUICtrlCreateCombo("", 95, $top, 100, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
	GUICtrlSetState($C_NCCnumber,$GUI_DISABLE)
	$B_NCCgo = GUICtrlCreateButton("Search", 210, $top, 43, 25)
	GUICtrlSetState($B_NCCgo,$GUI_DISABLE)
;----------  sla
$top=$top+30
	$Label7 = GUICtrlCreateLabel("Submit Date", 15, 35, 62, 17)
	$D_SubmitDate = GUICtrlCreateInput(_NowDate(), 95, $top, 100, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_READONLY))

$top=$top+30
	$Label8 = GUICtrlCreateLabel("SLA Break", 15, $top, 55, 17)
	$D_SLA = GUICtrlCreateInput(_DateTimeFormat(_DateAdd('d', 2, _NowCalcDate()), 2), 95, $top, 100, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_READONLY))
;--------------  Dates
$top=$top+30
	$Label9 = GUICtrlCreateLabel("Assign Date", 15, $top, 61, 17)
	$D_AssingDate = GUICtrlCreateDate("", 95, $top, 100, 21,$DTS_SHORTDATEFORMAT)
$top=$top+30
	$Label10 = GUICtrlCreateLabel("Process Date", 15, $top, 68, 17)
	$D_ProcessDate = GUICtrlCreateDate("", 95, $top, 100, 21,$DTS_SHORTDATEFORMAT)
;-------- times
$top=$top+30
	$Label19 = GUICtrlCreateLabel("Start Time", 15, $top, 52, 17)
	$T_StartTime = GUICtrlCreateDate("", 95, $top, 80, 21, $DTS_TIMEFORMAT)
	GUICtrlSendMsg($T_StartTime, 0x1032, 0, "hh:mm tt")  ;$DTM_SETFORMAT
	GUICtrlSetData($T_StartTime,_Time("00:00"))
;~     GUICtrlSetFont(-1, 12, 400, 1)
$top=$top+30
	$Label20 = GUICtrlCreateLabel("End Time", 15, $top, 49, 17)
	$T_EndTime = GUICtrlCreateDate("", 95, $top, 80, 21, $DTS_TIMEFORMAT)
	GUICtrlSendMsg($T_EndTime, 0x1032, 0, "hh:mm tt")  ;$DTM_SETFORMAT
	GUICtrlSetData($T_EndTime,_Time("00:00"))

;---------------
; segunda columna
$top=15
$top=$top+30
	$Label21 = GUICtrlCreateLabel("Task", $sideMid, $top, 28, 17)
	$T_Task = GUICtrlCreateCombo("", 380, $top, 45, 25, BitOR($CBS_DROPDOWNLIST,$WS_VSCROLL))
$top=$top+30
	$Label12 = GUICtrlCreateLabel("Status", $sideMid, $top, 34, 17)
	$C_Status = GUICtrlCreateCombo("", 380, $top, 184, 25, BitOR($CBS_DROPDOWNLIST,$WS_VSCROLL))
$top=$top+30
	$label13 = GUICtrlCreateLabel("Status Reason", $sideMid, $top, 74, 17)
$top=$top+20
	$E_StatusReason = GUICtrlCreateEdit("", $sideMid, $top, 230, 89)

; button
$top=$top+20
	$Label14 = GUICtrlCreateLabel("Comments", 16, 320, 53, 17)
	$E_Comments = GUICtrlCreateEdit("", 16, 344, 401, 89)


;  ---------  botones
	$B_Clear = GUICtrlCreateButton("Clear form", $wide-100, $high-350, 73, 33)
	$B_Save = GUICtrlCreateButton("Save", $wide-100, $high-300, 73, 33)
	GUICtrlSetState($B_Save,$GUI_DISABLE)
	$B_Close = GUICtrlCreateButton("Close", $wide-100, $high-100, 73, 33)

#EndRegion ### END Koda GUI section ###
GUISetState(@SW_SHOW)

loadform()








