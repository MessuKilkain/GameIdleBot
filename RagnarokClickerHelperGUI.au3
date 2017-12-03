#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>

#include "RagnarokClickerHelper.au3"

RagnarokClickerHelperGUI()

Func _GetExpectedGlobalCheckValue($globalCheckValue,$booleanVariableToTest)
	$expectedValueForBoolean = ($booleanVariableToTest?$GUI_CHECKED:$GUI_UNCHECKED)
	If $globalCheckValue <> 0 And $globalCheckValue <> $expectedValueForBoolean Then
		return $GUI_INDETERMINATE
	EndIf
	return $expectedValueForBoolean
EndFunc	;==>_GetExpectedGlobalCheckValue

Func RagnarokClickerHelperGUI()

;~	RunCheckLoop()
	Local $hGUI = GUICreate("RagnarokClickerHelper", 300, 500, -1, -1)

;~    Local $SkillSafeMargin = 1*01*01*0400
;~    Local $Skill_1_TriggerPeriod = 1*10*60*1000 + $SkillSafeMargin
;~    Local $Skill_2_TriggerPeriod = 1*10*60*1000 + $SkillSafeMargin
;~    Local $Skill_3_TriggerPeriod = 1*30*60*1000 + $SkillSafeMargin
;~    Local $Skill_4_TriggerPeriod = 1*30*60*1000 + $SkillSafeMargin
;~    Local $Skill_5_TriggerPeriod = 1*60*60*1000 + $SkillSafeMargin
;~    Local $Skill_6_TriggerPeriod = 8*60*60*1000 + $SkillSafeMargin
;~    Local $Skill_7_TriggerPeriod = 1*60*60*1000 + $SkillSafeMargin
;~    Local $Skill_8_TriggerPeriod = 1*60*60*1000 + $SkillSafeMargin
;~    Local $Skill_9_TriggerPeriod = 1*60*60*1000 + $SkillSafeMargin

;~    Local $EnableLastAdventurerHiring = False
;~    Local $LastAdventurerHiringPeriod = 1*01*60*1000
;~    Local $EnableOldBlueBoxCheck = True
;~    Local $OldBlueBoxCheckPeriod = 1*01*60*1000
;~    Local $EnableNewEquipementBoxCheck = True
;~    Local $NewEquipementBoxCheckPeriod = 1*10*60*1000

	
	$UIValues_Padding_Left = 20
	$UIValues_Line_Height = 20
	$UIValues_CheckBox_Width = 180
	$UIValues_CurrentTopValue = 20
	;~ Line - Global CheckBox
	$globalCheckOldState = 0
	$CheckBox_GlobalCheck = GUICtrlCreateCheckbox("Global", $UIValues_Padding_Left, $UIValues_CurrentTopValue, $UIValues_CheckBox_Width, $UIValues_Line_Height, $BS_AUTO3STATE )
	GUICtrlSetState(-1, $GUI_UNCHECKED)
	$UIValues_CurrentTopValue = $UIValues_CurrentTopValue + $UIValues_Line_Height
	;~ Line - Main Loop Check
	$CheckBox_EnableLoopCheck = GUICtrlCreateCheckbox("Main Loop Check", $UIValues_Padding_Left, $UIValues_CurrentTopValue, $UIValues_CheckBox_Width, $UIValues_Line_Height)
	GUICtrlSetState(-1, ($enableLoopCheck?$GUI_CHECKED:$GUI_UNCHECKED))
	$UIValues_CurrentTopValue = $UIValues_CurrentTopValue + $UIValues_Line_Height
	;~ Line - Automatic Mode Toggle
	$CheckBox_EnableAutomaticModeToggle = GUICtrlCreateCheckbox("Automatic Mode Toggle", $UIValues_Padding_Left, $UIValues_CurrentTopValue, $UIValues_CheckBox_Width, $UIValues_Line_Height)
	GUICtrlSetState(-1, ($EnableAutomaticModeToggle?$GUI_CHECKED:$GUI_UNCHECKED))
	$UIValues_CurrentTopValue = $UIValues_CurrentTopValue + $UIValues_Line_Height
	;~ Line - Automatic Skills Activation
	$CheckBox_EnableAutomaticPeriodicSkillsActivation = GUICtrlCreateCheckbox("Automatic Skills Activation", $UIValues_Padding_Left, $UIValues_CurrentTopValue, $UIValues_CheckBox_Width, $UIValues_Line_Height)
	GUICtrlSetState(-1, ($EnableAutomaticPeriodicSkillsActivation?$GUI_CHECKED:$GUI_UNCHECKED))
	$UIValues_CurrentTopValue = $UIValues_CurrentTopValue + $UIValues_Line_Height
	;~ Line - Automatic Skills Activation - Skills countdown
	Local $skillCountDownText[$numberOfSkills]
	Local $Label_Skill[$numberOfSkills]
	For $skillIndex = 0 To $numberOfSkills - 1 Step 1
		$skillCountDownText[$skillIndex] = StringFormat("Skill %d in %s", $skillIndex+1, "%s")
		$Label_Skill[$skillIndex] = GUICtrlCreateLabel("", 2 * $UIValues_Padding_Left, $UIValues_CurrentTopValue, $UIValues_CheckBox_Width, $UIValues_Line_Height)
		$UIValues_CurrentTopValue = $UIValues_CurrentTopValue + $UIValues_Line_Height
	Next
	;~ Line - Last Adventurer Hiring/Upgrade
	$CheckBox_EnableLastAdventurerHiring = GUICtrlCreateCheckbox("Last Adventurer Hiring/Upgrade", $UIValues_Padding_Left, $UIValues_CurrentTopValue, $UIValues_CheckBox_Width, $UIValues_Line_Height)
	GUICtrlSetState(-1, ($EnableLastAdventurerHiring?$GUI_CHECKED:$GUI_UNCHECKED))
	$UIValues_CurrentTopValue = $UIValues_CurrentTopValue + $UIValues_Line_Height
	;~ Line - Old Blue Box Check
	$CheckBox_EnableOldBlueBoxCheck = GUICtrlCreateCheckbox("Old Blue Box Check", $UIValues_Padding_Left, $UIValues_CurrentTopValue, $UIValues_CheckBox_Width, $UIValues_Line_Height)
	GUICtrlSetState(-1, ($EnableOldBlueBoxCheck?$GUI_CHECKED:$GUI_UNCHECKED))
	$UIValues_CurrentTopValue = $UIValues_CurrentTopValue + $UIValues_Line_Height
	;~ Line - New equipement Check
	$CheckBox_EnableNewEquipementBoxCheck = GUICtrlCreateCheckbox("New equipement Check", $UIValues_Padding_Left, $UIValues_CurrentTopValue, $UIValues_CheckBox_Width, $UIValues_Line_Height)
	GUICtrlSetState(-1, ($EnableNewEquipementBoxCheck?$GUI_CHECKED:$GUI_UNCHECKED))
	$UIValues_CurrentTopValue = $UIValues_CurrentTopValue + $UIValues_Line_Height
	;~ Line - Debug Label
	; $Label_Debug = GUICtrlCreateLabel ("", $UIValues_Padding_Left, $UIValues_CurrentTopValue, $UIValues_CheckBox_Width, $UIValues_Line_Height)
	; $UIValues_CurrentTopValue = $UIValues_CurrentTopValue + $UIValues_Line_Height
	;~ Line - LoadConfig_Button
	Local $LoadConfig_Button = GUICtrlCreateButton ("Load config", $UIValues_Padding_Left, $UIValues_CurrentTopValue, $UIValues_CheckBox_Width, $UIValues_Line_Height)
	$UIValues_CurrentTopValue = $UIValues_CurrentTopValue + $UIValues_Line_Height

	GUISetState(@SW_SHOW, $hGUI)

	CustomLog("$enableLoopCheck : "&$enableLoopCheck)
	CheckLoopInit()
	; Run the GUI until the dialog is closed
	While 1
		; Labels update
		For $skillIndex = 0 To $numberOfSkills - 1 Step 1
			GUICtrlSetData($Label_Skill[$skillIndex], StringFormat($skillCountDownText[$skillIndex], SkillTimeToHumanReadableString(TimeBeforeActivationOfSkillWithIndex($skillIndex))))
		Next
		; 0 means no value is yet attributed
		; Other valid values are $GUI_CHECKED (1), $GUI_INDETERMINATE (2) and $GUI_UNCHECKED (4)
		$globalCheck = 0
		
		$enableLoopCheck = (_IsChecked($CheckBox_EnableLoopCheck ) ? True : False )
		$globalCheck = _GetExpectedGlobalCheckValue($globalCheck,$enableLoopCheck)
		
		$EnableAutomaticModeToggle = (_IsChecked($CheckBox_EnableAutomaticModeToggle ) ? True : False )
		$globalCheck = _GetExpectedGlobalCheckValue($globalCheck,$EnableAutomaticModeToggle)
		
		$EnableAutomaticPeriodicSkillsActivation = (_IsChecked($CheckBox_EnableAutomaticPeriodicSkillsActivation ) ? True : False )
		$globalCheck = _GetExpectedGlobalCheckValue($globalCheck,$EnableAutomaticPeriodicSkillsActivation)
		
		$EnableLastAdventurerHiring = (_IsChecked($CheckBox_EnableLastAdventurerHiring ) ? True : False )
		$globalCheck = _GetExpectedGlobalCheckValue($globalCheck,$EnableLastAdventurerHiring)
		
		$EnableOldBlueBoxCheck = (_IsChecked($CheckBox_EnableOldBlueBoxCheck ) ? True : False )
		$globalCheck = _GetExpectedGlobalCheckValue($globalCheck,$EnableOldBlueBoxCheck)
		
		$EnableNewEquipementBoxCheck = (_IsChecked($CheckBox_EnableNewEquipementBoxCheck ) ? True : False )
		$globalCheck = _GetExpectedGlobalCheckValue($globalCheck,$EnableNewEquipementBoxCheck)
		
		$globalCheckNewState = GUICtrlRead($CheckBox_GlobalCheck )
		; GUICtrlSetData($Label_Debug,"Old : " & String($globalCheckOldState) & " ; New " & String($globalCheckNewState) & " ; global : " & String($globalCheck) + " ")
		If $globalCheckOldState <> $globalCheckNewState Then
			If $globalCheckOldState == $GUI_INDETERMINATE Then
				; We specify what should be the next state after $GUI_INDETERMINATE state in rolling states order
				$globalCheckNewState = $GUI_CHECKED
			ElseIf $globalCheckNewState == $GUI_INDETERMINATE Then
				; We skip the $GUI_INDETERMINATE state of rolling states
				If $globalCheckOldState == $GUI_UNCHECKED Then
					$globalCheckNewState = $GUI_CHECKED
				Else
					$globalCheckNewState = $GUI_UNCHECKED
				EndIf
			EndIf
			$globalCheck = $globalCheckNewState
		EndIf
		If $globalCheck <> 0 And $globalCheck <> $GUI_INDETERMINATE Then
			GUICtrlSetState($CheckBox_EnableLoopCheck, $globalCheck)
			GUICtrlSetState($CheckBox_EnableAutomaticModeToggle, $globalCheck)
			GUICtrlSetState($CheckBox_EnableAutomaticPeriodicSkillsActivation, $globalCheck)
			GUICtrlSetState($CheckBox_EnableLastAdventurerHiring, $globalCheck)
			GUICtrlSetState($CheckBox_EnableOldBlueBoxCheck, $globalCheck)
			GUICtrlSetState($CheckBox_EnableNewEquipementBoxCheck, $globalCheck)
		EndIf
		GUICtrlSetState($CheckBox_GlobalCheck, $globalCheck)
		$globalCheckOldState = $globalCheck
		
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $LoadConfig_Button
				LoadRagnarokClickerHelperConfig("RagnarokClickerHelper.config.txt")
		EndSwitch
		; GUICtrlSetData($Label_Debug,"$Skill_TriggerPeriod[0] " & $Skill_TriggerPeriod[0])
		CheckLoopStep()
		
		Sleep($loopSleep)
	WEnd
	GUIDelete($hGUI)
	Exit
EndFunc	;==>RagnarokClickerHelperGUI

Func _IsChecked($idControlID)
	Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc	;==>_IsChecked

Func LoadRagnarokClickerHelperConfig($pathToFile)
	$i = 0
	$file = FileOpen($pathToFile,0)
	; ConsoleWrite("Start parsing")
	While 1
		$i = $i + 1
		Local $line = FileReadLine($file)
		If @error = -1 Then ExitLoop
		$row_array = StringSplit($line,':')
		$key = $row_array[1]
		$value = $row_array[2]
		; ConsoleWrite($key & " : " & $value & @CRLF)
		Switch $key
			Case '$Skill_TriggerPeriod[0]'
				$Skill_TriggerPeriod[0] = Int($value)
			Case '$Skill_TriggerPeriod[1]'
				$Skill_TriggerPeriod[1] = Int($value)
			Case '$Skill_TriggerPeriod[2]'
				$Skill_TriggerPeriod[2] = Int($value)
			Case '$Skill_TriggerPeriod[3]'
				$Skill_TriggerPeriod[3] = Int($value)
			Case '$Skill_TriggerPeriod[4]'
				$Skill_TriggerPeriod[4] = Int($value)
			Case '$Skill_TriggerPeriod[5]'
				$Skill_TriggerPeriod[5] = Int($value)
			Case '$Skill_TriggerPeriod[6]'
				$Skill_TriggerPeriod[6] = Int($value)
			Case '$Skill_TriggerPeriod[7]'
				$Skill_TriggerPeriod[7] = Int($value)
			Case '$Skill_TriggerPeriod[8]'
				$Skill_TriggerPeriod[8] = Int($value)
			Case '$AutomaticModeTogglePeriod'
				$AutomaticModeTogglePeriod = Int($value)
		EndSwitch
	WEnd
EndFunc
