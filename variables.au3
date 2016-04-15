#REGION GENERAL
;~ 	Global $oMyError = ObjEvent("AutoIt.Error","MyErrFunc")
	$version= FileGetVersion(@ScriptName)
	$workDir="c:\temp"
	$ProgramdataDir="c:\ProgramData"
#endregion
#region log
	$logFileDir=$ProgramdataDir&"\FGM"
	$LogFile=$logFileDir&"\FGMagent.log"
	$hLogFile=""
#endregion
#region encryption
	$Password="apt"
	$HashingPassword="apt"
	$passcode="testeo"
#endregion
#region TCP Variables
	Dim $sMaxConnections = 10
;~ 	Dim $sSocket[$sMaxConnections], $sBuffer[$sMaxConnections], $iAuth[$sMaxConnections]
	Global $sMainSocket =""

	;; TCP Options
	$nPort = 23
	Global $listenerIP=""
	Global $ListenerActive=1
#endregion
