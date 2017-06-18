#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>

#include "RagnarokClickerHelper.au3"

RagnarokClickerHelperGUI()

Func RagnarokClickerHelperGUI()

;~    RunCheckLoop()
   Local $hGUI = GUICreate("RagnarokClickerHelper", 265, 150, -1, -1)

;~    Local $EnableAutomaticModeToggle = False
;~    Local $AutomaticModeTogglePeriod = 2.5*60*1000

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

   $CheckBox_EnableLoopCheck = GUICtrlCreateCheckbox("Main Loop Check", 50, 50, 80, 20)
   GUICtrlSetState(-1, ($enableLoopCheck?$GUI_CHECKED:$GUI_UNCHECKED))
   $CheckBox_EnableAutomaticModeToggle = GUICtrlCreateCheckbox("Automatic Mode Toggle", 50, 100, 80, 20)
   GUICtrlSetState(-1, ($EnableAutomaticModeToggle?$GUI_CHECKED:$GUI_UNCHECKED))



	GUISetState(@SW_SHOW, $hGUI)

	CustomLog("$enableLoopCheck : "&$enableLoopCheck)
   CheckLoopInit()
	; Run the GUI until the dialog is closed
	While 1
	   $enableLoopCheck = ($GUI_CHECKED == GUICtrlRead($CheckBox_EnableLoopCheck ) ? True : False )
	   $CheckBox_EnableAutomaticModeToggle = ($GUI_CHECKED == GUICtrlRead($CheckBox_EnableAutomaticModeToggle ) ? True : False )
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			 EndSwitch
			 CheckLoopStep()
	  Sleep($loopSleep)
	WEnd
	GUIDelete($hGUI)
	Exit
EndFunc
