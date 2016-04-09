Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)  ; Handle WM_NOTIFY messages  en lists, combos
    Local $nID = _LoWord($iwParam)
;~ 	ConsoleWrite("+WM_NsOTIFY="&$nID& @CRLf)
    Local $tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
;~     Local $hWndFrom = DllStructGetData($tNMHDR, "hWndFrom")
    Local $nNotifyCode = DllStructGetData($tNMHDR, "Code")
;~ 	Local $iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	Switch $nID
		#region settings form lists
			Case $LST_CredManage
	;~ 			ConsoleWrite("+$LST_CredManage"& " WM_NOTIFY" & @CRLf)
				Switch $nNotifyCode
					Case $LVN_ITEMCHANGED
						If _GUICtrlListView_GetSelectedCount($LST_CredManage)=1 Then
							consoleWrite("+$NM_CLICK   +$LST_CredManage ,$LVN_ITEMCHANGED   WM_NOTIFY  "& @CRLf)
							$lineValues=_GUICtrlListView_GetItemTextArray($LST_CredManage)
							GUICtrlSetData($TXT_creddomain,$lineValues[1])
							GUICtrlSetData($TXT_creduser,$lineValues[2])
							GUICtrlSetData($TXT_credpassword,_Hashing($lineValues[3],1))
							$flagCredShow=1
							BTN_credshowpassClick()
						endif
					Case -108 ;$NM_CLICK
						ConsoleWrite("+ -108"& @CRLf)
	;~ 					$bSet = 0
	;~ 					$nCurCol = $nCol
	;~ 					GUICtrlSendMsg($LST_CredManage, $LVM_SETSELECTEDCOLUMN, GUICtrlGetState($LST_CredManage), 0)
	;~ 					DllCall("user32.dll", "int", "InvalidateRect", "hwnd", GUICtrlGetHandle($LST_CredManage), "int", 0, "int", 1)
					Case $NM_DBLCLK
						ConsoleWrite("+$NM_DBLCLK"& @CRLf)
				EndSwitch
			Case $LST_custsrvgrp
	;~ 			ConsoleWrite("+$LST_CredManage"& " WM_NOTIFY" & @CRLf)
				Switch $nNotifyCode
					Case $LVN_ITEMCHANGED ;$NM_CLICK
						$flagCustomlistclick=0
						If _GUICtrlListView_GetSelectedCount($LST_custsrvgrp)=1 Then
							consoleWrite("+$NM_CLICK   +$LST_custsrvgrp   WM_NOTIFY  "& @CRLf)
							$lineValues=_GUICtrlListView_GetItemTextArray($LST_custsrvgrp)
							ControlCommand ($SettingsForm, "", $CMB_custselectgroup, "SelectString", $lineValues[1])
							ControlCommand ($SettingsForm, "", $CMB_custselectserver, "SelectString", $lineValues[2])
							GUICtrlSetState($BTN_custlistdeletesrv,$GUI_ENABLE)
							consoleWrite("+$NM_CLICK   +$LST_custsrvgrp   WM_NOTIFY 1 "& @CRLf)
						Else
							GUICtrlSetState($BTN_custlistdeletesrv,$GUI_DISABLE)
						endif
						$flagCustomlistclick=1
					Case -108 ;$NM_CLICK
						ConsoleWrite("+ -108"& @CRLf)
					Case $NM_DBLCLK
						ConsoleWrite("+$NM_DBLCLK"& @CRLf)
				EndSwitch
			Case $LST_custshare
	;~ 			ConsoleWrite("+$LST_CredManage"& " WM_NOTIFY" & @CRLf)
				Switch $nNotifyCode
					Case $NM_CLICK,$LVN_ITEMCHANGED
						consoleWrite("+$NM_CLICK   +$LST_custshare   WM_NOTIFY  "& @CRLf)
						If _GUICtrlListView_GetSelectedCount($LST_custshare)=1 Then
							$lineValues=_GUICtrlListView_GetItemTextArray($LST_custshare)
							GUICtrlSetData($TXT_custsharename,$lineValues[1])
							GUICtrlSetData($TXT_custsharepath,$lineValues[2])
							GUICtrlSetState($BTN_custdeleteshare,$GUI_ENABLE)
						Else
							GUICtrlSetState($BTN_custdeleteshare,$GUI_DISABLE)
							GUICtrlSetData($TXT_custsharename,"")
							GUICtrlSetData($TXT_custsharepath,"")
						endif
					Case -108 ;$NM_CLICK
						ConsoleWrite("+ -108"& @CRLf)
					Case $NM_DBLCLK
						ConsoleWrite("+$NM_DBLCLK"& @CRLf)
				EndSwitch
			Case $LST_settings_serversAdd
				Switch $nNotifyCode
					Case $LVN_ITEMCHANGED
						If _GUICtrlListView_GetSelectedCount($LST_settings_serversAdd)=1 Then
							consoleWrite("+$NM_CLICK   +$LST_settings_serversAdd   WM_NOTIFY  "& @CRLf)
							$lineValues=_GUICtrlListView_GetItemTextArray($LST_settings_serversAdd)
							GUICtrlSetData($TXT_settings_FQDN,$lineValues[1])
							_GUICtrlIpAddress_Set($IPAddress1, "0.0.0.0")
							If $lineValues[4]="yes" Or $lineValues[5]="No" then
								GUICtrlSetState($BTN_Settings_ServerRemove,$GUI_ENABLE)
							Else
								GUICtrlSetState($BTN_Settings_ServerRemove,$GUI_DISABLE)
							endif
						Else
							GUICtrlSetState($BTN_Settings_ServerRemove,$GUI_DISABLE)
							GUICtrlSetData($TXT_settings_FQDN,"")
						endif
					Case -108 ;$NM_CLICK
						ConsoleWrite("+ -108"& @CRLf)
					Case $NM_DBLCLK
						ConsoleWrite("+$NM_DBLCLK"& @CRLf)
;~ 					Case $LVN_ITEMCHANGING
;~ 						ConsoleWrite("+$LVN_ITEMCHANGING"& @CRLf)
				EndSwitch
		#endregion
		#region task creation form lists
			Case $LST_TaskFolderCreation_TargetLoc
				Switch $nNotifyCode
					Case $LVN_ITEMCHANGED
						consoleWrite("+$NM_CLICK   +$LST_TaskFolderCreation_TargetLoc   WM_NOTIFY  "& @CRLf)
						If _GUICtrlListView_GetSelectedCount($LST_TaskFolderCreation_TargetLoc)=1 Then
							GUICtrlSetState($BTN_TaskFolderCreation_DeleteTargetLoc,$GUI_ENABLE)
						Else
							GUICtrlSetState($BTN_TaskFolderCreation_DeleteTargetLoc,$GUI_DISABLE)
						endif
						_TaskFormCreation_SaveBTNtarget_SourceLST()
					Case -108 ;$NM_CLICK
						ConsoleWrite("+ -108"& @CRLf)
					Case $NM_DBLCLK
						ConsoleWrite("+$NM_DBLCLK"& @CRLf)
				EndSwitch
			Case $LST_TaskFolderCreation_SourceLoc
				Switch $nNotifyCode
					Case $LVN_ITEMCHANGED
						consoleWrite("+$NM_CLICK   +$LST_TaskFolderCreation_TargetLoc   WM_NOTIFY  "& @CRLf)
						If _GUICtrlListView_GetSelectedCount($LST_TaskFolderCreation_SourceLoc)=1 Then
							GUICtrlSetState($BTN_TaskFolderCreation_DeleteSourceLoc,$GUI_ENABLE)
						Else
							GUICtrlSetState($BTN_TaskFolderCreation_DeleteSourceLoc,$GUI_DISABLE)
						endif
						_TaskFormCreation_SaveBTNtarget_SourceLST()
					Case -108 ;$NM_CLICK
						ConsoleWrite("+ -108"& @CRLf)
					Case $NM_DBLCLK
						ConsoleWrite("+$NM_DBLCLK"& @CRLf)
				EndSwitch
			Case $LST_TaskFolderCreation_SourcePaths
				Switch $nNotifyCode
					Case $LVN_ITEMCHANGED
						consoleWrite("+$NM_CLICK   +$LST_TaskFolderCreation_SourcePaths   WM_NOTIFY  "& @CRLf)
						If _GUICtrlListView_GetSelectedCount($LST_TaskFolderCreation_SourcePaths)=1 Then
							GUICtrlSetState($BTN_TaskFolderCreation_DeleteSourcePath,$GUI_ENABLE)
							$lineValues=_GUICtrlListView_GetItemTextArray($LST_TaskFolderCreation_SourcePaths)
							GUICtrlSetData($TXT_TaskFolderCreation_SourcePath,StringStripWS($lineValues[1],3))
;~ 							$sTitle = WinGetTitle("[active]")
							$sTitle = _ctrlread($CMB_jobcreation_selecttask)
							If $sTitle="Compression Task" Or $sTitle="Copy Task"  Then
								GUICtrlSetState($RD_CopyTask_Copy,$GUI_CHECKED)
								GUICtrlSetState($CK_TaskFolderCreation_Recurse,$GUI_UNCHECKED)
								GUICtrlSetState($RD_CopyTask_Mirror,$GUI_UNCHECKED)
								GUICtrlSetState($RD_CopyTask_Move,$GUI_UNCHECKED)

								If StringInStr($lineValues[2],"[R]")>0 Then
									GUICtrlSetState($CK_TaskFolderCreation_Recurse,$GUI_CHECKED)
								endif
								Select
									Case StringInStr($lineValues[2],"[M]")>0
										GUICtrlSetState($RD_CopyTask_Mirror,$GUI_CHECKED)
										GUICtrlSetState($RD_CopyTask_Copy,$GUI_UNCHECKED)
									Case StringInStr($lineValues[2],"[MV]")>0
										GUICtrlSetState($RD_CopyTask_Move,$GUI_CHECKED)
										GUICtrlSetState($RD_CopyTask_Copy,$GUI_UNCHECKED)
									Case Else
										GUICtrlSetState($RD_CopyTask_Copy,$GUI_CHECKED)
								EndSelect
								GUICtrlSetData($TXT_TaskFolderCreation_olderThan,0)
								$l=$lineValues[2]
								If StringInStr($l,"[")>0 Then
									$in=StringInStr($l,"[")
									$en=StringInStr($l,"]")
									$olderday=StringMid($l,$in+1,$en-$in-1)
									If Int($olderday)>0 Then GUICtrlSetData($TXT_TaskFolderCreation_olderThan,$olderday)
									$l=StringMid($l,1,$in-1)
								endif
								GUICtrlSetData($TXT_TaskFolderCreation_SourceZIPFilter,StringStripWS($l,3))
							endif
							_CopyForm_OnMirror_Checks()
						Else
							GUICtrlSetState($BTN_TaskFolderCreation_DeleteSourcePath,$GUI_DISABLE)
						endif
						_TaskFormCreation_SaveBTNtarget_SourceLST()
					Case -108 ;$NM_CLICK
						ConsoleWrite("!+ -108"& @CRLf)
					Case $NM_DBLCLK
						ConsoleWrite("!+$NM_DBLCLK"& @CRLf)
				EndSwitch
			Case $LST_TaskFolderCreation_TargetPaths
				Switch $nNotifyCode
					Case $LVN_ITEMCHANGED
						consoleWrite("+$NM_CLICK   +$LST_TaskFolderCreation_TargetPaths   WM_NOTIFY  "& @CRLf)
						If _GUICtrlListView_GetSelectedCount($LST_TaskFolderCreation_TargetPaths)=1 Then
;~ 							$sTitle = WinGetTitle("[active]")
							$sTitle = _ctrlread($CMB_jobcreation_selecttask)
							GUICtrlSetState($BTN_TaskFolderCreation_DeleteTargetPath,$GUI_ENABLE)
							$lineValues=_GUICtrlListView_GetItemTextArray($LST_TaskFolderCreation_TargetPaths)
							GUICtrlSetData($TXT_TaskFolderCreation_TargetPath,StringStripWS($lineValues[1],3))
							If UBound($lineValues)>2 Then
								GUICtrlSetData($TXT_TaskFolderCreation_TargetPathFilter,StringStripWS($lineValues[2],3))
								Switch $sTitle
									Case "Compression Task"
										GUICtrlSetState($RD_TaskFolderCreation_ZIPsingle, $GUI_UNCHECKED)
										GUICtrlSetState($RD_TaskFolderCreation_ZIPMultiple, $GUI_UNCHECKED)
										GUICtrlSetState($RD_TaskFolderCreation_ZIPstructure, $GUI_UNCHECKED)
										Select
											Case StringInStr($lineValues[2],"[NS]")>0
												GUICtrlSetData($TXT_TaskFolderCreation_TargetZIPfilename,StringStripWS(StringReplace($lineValues[2],"[NS]",""),3))
												GUICtrlSetState($RD_TaskFolderCreation_ZIPsingle,$GUI_CHECKED)
												GUICtrlSetState($TXT_TaskFolderCreation_TargetZIPfilename,$GUI_ENABLE)
											Case $lineValues[2]="Autonaming"
												GUICtrlSetData($TXT_TaskFolderCreation_TargetZIPfilename,StringStripWS($lineValues[2],3))
												GUICtrlSetState($RD_TaskFolderCreation_ZIPmultiple, $GUI_CHECKED)
												GUICtrlSetState($TXT_TaskFolderCreation_TargetZIPfilename,$GUI_DISABLE)
											Case Else
												GUICtrlSetData($TXT_TaskFolderCreation_TargetZIPfilename,StringStripWS($lineValues[2],3))
												GUICtrlSetState($RD_TaskFolderCreation_ZIPstructure, $GUI_CHECKED)
												GUICtrlSetState($TXT_TaskFolderCreation_TargetZIPfilename,$GUI_ENABLE)
										EndSelect
									Case "Decompression Task"
										If $lineValues[2]="Autorename" Then
											GUICtrlSetState($RD_TaskFolderCreation_ZIPAutorename, $GUI_CHECKED)
										Else
											GUICtrlSetState($RD_TaskFolderCreation_ZIPOverwrite, $GUI_CHECKED)
										endif
									Case "Deletion Task"
										If StringInStr($lineValues[2],"[R]")>0 Then
											GUICtrlSetState($CK_TaskFolderCreation_Recurse,$GUI_CHECKED)
										Else
											GUICtrlSetState($CK_TaskFolderCreation_Recurse,$GUI_UNCHECKED)
										endif
										$l=StringReplace($lineValues[2],"[R]","")
										If StringInStr($l,"[")>0 Then
											$in=StringInStr($l,"[")
											$en=StringInStr($l,"]")
											$olderday=StringStripWS(StringMid($l,$in+1,$en-$in-1),3)
											GUICtrlSetData($TXT_TaskFolderCreation_olderThan,$olderday)
											$l=StringStripWS(StringMid($l,1,$in-1),3)
										endif
										GUICtrlSetData($TXT_TaskFolderCreation_TargetPathFilter,$l)
									Case "Copy Task"
										GUICtrlSetState($CK_CopyTask_RStructure, $GUI_UNCHECKED)
										If StringInStr($lineValues[2],"[NS]")>0 Then GUICtrlSetState($CK_CopyTask_RStructure,$GUI_CHECKED)
										GUICtrlSetState($CK_CopyTask_FolderPerSource, $GUI_UNCHECKED)
										If  StringInStr($lineValues[2],"[OF]")>0 Then GUICtrlSetState($CK_CopyTask_FolderPerSource,$GUI_CHECKED)
										$CopyTBehaviour=""
										$ps=StringInStr($lineValues[2],"[")
										If $ps=0 Then $ps=StringLen($lineValues[2])+1
										Switch StringMid($lineValues[2],1,$ps-1)
											Case "Overwrite"
												$CopyTBehaviour="Overwrite"
											Case "Skip"
												$CopyTBehaviour="Skip on conflict"
											Case "Rename"
												$CopyTBehaviour="Rename on conflict"
											Case "Prompt"
												$CopyTBehaviour="Prompt user on conflict"
										EndSwitch
										ControlCommand ($TasKCopyCreation, "", $CMB_CopyTask_Behaviour, "SelectString", $CopyTBehaviour)
								EndSwitch
							endif
						Else
							GUICtrlSetState($BTN_TaskFolderCreation_DeleteTargetPath,$GUI_DISABLE)
						endif
						_TaskFormCreation_SaveBTNtarget_SourceLST()
					Case -108 ;$NM_CLICK
						ConsoleWrite("+ -108"& @CRLf)
					Case $NM_DBLCLK
						ConsoleWrite("+$NM_DBLCLK"& @CRLf)
				EndSwitch
		#endregion
		#region  JOB Form lists
			Case $LST_JobCreation_JobList
				Switch $nNotifyCode
					Case $LVN_ITEMCHANGED
						consoleWrite("+$NM_CLICK   +$LST_JobCreation_JobList   WM_NOTIFY  "& @CRLf)
						$taskID=0
						If _GUICtrlListView_GetSelectedCount($LST_JobCreation_JobList)=1 Then
							$listUpdateFlag=True
;~ 							$listUpdateFlag=false
							$lineValues=_GUICtrlListView_GetItemTextArray($LST_JobCreation_JobList)
							GUICtrlSetData($TXT_JobCreation_jobname,$lineValues[1])
							GUICtrlSetData($TXT_JobCreation_jobdescription,$lineValues[2])
							_CheckJobId()
							_FillTaskJobList()
							_JobCreation_EnableJobs()
							GUICtrlSetState($CMB_jobcreation_selecttask,$GUI_ENABLE)
;~ 							If GUICtrlRead($CK_JobCreation_Showjob)=$GUI_CHECKED Then
								If $lineValues[3]="Yes" Then
									GUICtrlSetdata($BTN_JobCreation_Archivejob,"      Restore Job")
								Else
									GUICtrlSetdata($BTN_JobCreation_Archivejob,"      Archive Job")
								endif
;~ 							endif
							$listUpdateFlag=false
						Else
							If GUICtrlRead($TXT_JobCreation_jobdescription)<>"" Then GUICtrlSetData($TXT_JobCreation_jobdescription,"")
							If GUICtrlRead($TXT_JobCreation_jobname)<>"" Then GUICtrlSetData($TXT_JobCreation_jobname,"")
							_JobCreation_disableJobs()
							GUICtrlSetState($BTN_jobcreation_addtask,$GUI_DISABLE)
							ControlCommand ($SettingsForm, "", $CMB_jobcreation_selecttask, "SelectString"," ")
							$listUpdateFlag=false
						endif
					Case -108 ;$NM_CLICK
						ConsoleWrite("+ -108"& @CRLf)
					Case $NM_DBLCLK
						ConsoleWrite("+$NM_DBLCLK "& @CRLf)
					Case Else
;~ 						ConsoleWrite("!!$LST_JobCreation_JobList nNotifyCode"& $nNotifyCode& @CRLf)
				EndSwitch
			Case $LST_jobcreation_tasklist
				Switch $nNotifyCode
					Case $NM_CLICK
						consoleWrite("+$NM_CLICK   +$LST_jobcreation_tasklist   WM_NOTIFY  "& @CRLf)
						$taskID=0
						If _GUICtrlListView_GetSelectedCount($LST_jobcreation_tasklist)=1 Then
							$lineValues=_GUICtrlListView_GetItemTextArray($LST_jobcreation_tasklist)
							$taskID=$lineValues[3]
							ConsoleWrite('$taskID = ' & $taskID & @crlf )
							ControlCommand ($JobCreationForm, "", $CMB_jobcreation_selecttask, "SelectString", $lineValues[1])
							_JobCreation_enabletasks()
						Else
							_JobCreation_disabletasks()
						endif
					Case -108 ;$NM_CLICK
						ConsoleWrite("+ -108"& @CRLf)
					Case $NM_DBLCLK
						ConsoleWrite("+$NM_DBLCLK   +$LST_jobcreation_tasklist   WM_NOTIFY  "& @CRLf)
					Case $LVN_ITEMCHANGED
						If $listUpdateFlag=False Then
						ConsoleWrite("+$LVN_ITEMCHANGED   +$LST_jobcreation_tasklist   WM_NOTIFY "& @CRLf)
							$tInfo = DllStructCreate($tagNMLISTVIEW, $ilParam)
							$item=DllStructGetData($tInfo, "Item")
							$checked=DllStructGetData($tInfo, "NewState")
							$taskNumber=_GUICtrlListView_GetItemText($LST_jobcreation_tasklist,$item,2)
							If $taskNumber<>"" then
								If $checked=4096 Then _UpdateTaskActive($taskNumber,0)
								if $checked=8192 Then _UpdateTaskActive($taskNumber,1)
							endif
						endif
					Case Else
;~ 						ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $NM_CLICK = ' & $NM_CLICK & @crlf )
				EndSwitch
		#endregion
		#region
		#endregion
	EndSwitch
EndFunc


