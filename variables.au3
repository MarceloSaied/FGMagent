#REGION GENERAL
	Global $oMyError = ObjEvent("AutoIt.Error","MyErrFunc")
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
#endregion
