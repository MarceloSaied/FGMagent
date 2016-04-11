#REGION GENERAL
	Global $oMyError = ObjEvent("AutoIt.Error","MyErrFunc")
	$version= FileGetVersion(@ScriptName)
	$workDir="c:\temp"
	$ProgramdataDir="c:\ProgramData"
#endregion
#region log
	$logFileName=$ProgramdataDir&"\FGM"
#endregion
#region encryption
	$Password="apt"
	$HashingPassword="apt"
#endregion
