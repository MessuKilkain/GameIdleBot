#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>

#include "RagnarokClickerHelper.au3"

RagnarokClickerHelperGUI()

Func RagnarokClickerHelperGUI()

;~	RunCheckLoop()
	Local $hGUI = GUICreate("RagnarokClickerHelper", 220, 170, -1, -1)

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


	GUISetState(@SW_SHOW, $hGUI)

	CustomLog("$enableLoopCheck : "&$enableLoopCheck)
	CheckLoopInit()
	; Run the GUI until the dialog is closed
	While 1
		$enableLoopCheck = ($GUI_CHECKED == GUICtrlRead($CheckBox_EnableLoopCheck ) ? True : False )
		$EnableAutomaticModeToggle = ($GUI_CHECKED == GUICtrlRead($CheckBox_EnableAutomaticModeToggle ) ? True : False )
		$EnableAutomaticPeriodicSkillsActivation = ($GUI_CHECKED == GUICtrlRead($CheckBox_EnableAutomaticPeriodicSkillsActivation ) ? True : False )
		$EnableLastAdventurerHiring = ($GUI_CHECKED == GUICtrlRead($CheckBox_EnableLastAdventurerHiring ) ? True : False )
		$EnableOldBlueBoxCheck = ($GUI_CHECKED == GUICtrlRead($CheckBox_EnableOldBlueBoxCheck ) ? True : False )
		$EnableNewEquipementBoxCheck = ($GUI_CHECKED == GUICtrlRead($CheckBox_EnableNewEquipementBoxCheck ) ? True : False )
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			 EndSwitch
			 CheckLoopStep()
		Sleep($loopSleep)
	WEnd
	GUIDelete($hGUI)
	Exit
EndFunc	;==>RagnarokClickerHelperGUI

Func _IsChecked($idControlID)
	Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc	;==>_IsChecked

