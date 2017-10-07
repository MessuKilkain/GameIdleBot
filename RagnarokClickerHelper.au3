
#include-once

#include <AutoItConstants.au3>

Local $ragnarokClickerWindowName = "Ragnarok Clicker"
Local $continueLoop = True
Local $enableLoopCheck = True
Local $timer = TimerInit()
Local $checkLoopTimer = Null
Local $activeLoopTimer = Null
Local $loopTimeCounter = 0
Local $UseLoopCounterInsteadOfRealTime = False

Local $LastRelativeMouseX = 0
Local $LastRelativeMouseY = 0

Local $EnableAutomaticModeToggle = True
Local $AutomaticModeTogglePeriod = 2.5*60*1000

Local $EnableAutomaticPeriodicSkillsActivation = True
Local $SkillSafeMargin = 1*01*01*0400
Local $Skill_Key[9]
$Skill_Key[0] = "&"
$Skill_Key[1] = "é"
$Skill_Key[2] = '"'
$Skill_Key[3] = "'"
$Skill_Key[4] = '('
$Skill_Key[5] = '-'
$Skill_Key[6] = 'è'
$Skill_Key[7] = '_'
$Skill_Key[8] = 'ç'
Local $Skill_TriggerPeriod[9]
$Skill_TriggerPeriod[0] = 1*10*60*1000 + $SkillSafeMargin
$Skill_TriggerPeriod[1] = 1*10*60*1000 + $SkillSafeMargin
$Skill_TriggerPeriod[2] = 1*30*60*1000 + $SkillSafeMargin
$Skill_TriggerPeriod[3] = 1*30*60*1000 + $SkillSafeMargin
$Skill_TriggerPeriod[4] = 1*60*60*1000 + $SkillSafeMargin
$Skill_TriggerPeriod[5] = 8*60*60*1000 + $SkillSafeMargin
$Skill_TriggerPeriod[6] = 1*60*60*1000 + $SkillSafeMargin
$Skill_TriggerPeriod[7] = 1*60*60*1000 + $SkillSafeMargin
$Skill_TriggerPeriod[8] = 1*60*60*1000 + $SkillSafeMargin
Local $Skill_LastTriggerTime[9]
$Skill_LastTriggerTime[0] = Null
$Skill_LastTriggerTime[1] = Null
$Skill_LastTriggerTime[2] = Null
$Skill_LastTriggerTime[3] = Null
$Skill_LastTriggerTime[4] = Null
$Skill_LastTriggerTime[5] = Null
$Skill_LastTriggerTime[6] = Null
$Skill_LastTriggerTime[7] = Null
$Skill_LastTriggerTime[8] = Null

Local $EnableLastAdventurerHiring = True
Local $LastAdventurerHiringPeriod = 1*01*60*1000
Local $EnableOldBlueBoxCheck = True
Local $OldBlueBoxCheckPeriod = 1*01*60*1000
Local $EnableNewEquipementBoxCheck = True
Local $NewEquipementBoxCheckPeriod = 1*10*60*1000

; Default
Local $loopSleep = 50
Local $numberOfClicks = 1

; Too Hardcore
;$loopSleep = 10
;$numberOfClicks = 5

; Anubis fullsize proof
;$loopSleep = 50
;$numberOfClicks = 1

Func StopLoop()
	$continueLoop = false
 EndFunc

Func TimeToLogginHumanReadableString($time)
   $milliseconds = Mod(floor($time),1000)
   $seconds = Mod(floor($time/(1000)),60)
   $minutes = Mod(floor($time/(60*1000)),60)
   $hours = Mod(floor($time/(60*60*1000)),24)
   $days = floor($time/(24*60*60*1000))
   Return StringFormat("%02dd%02dh%02dm%02ds%04d",$days,$hours,$minutes,$seconds,$milliseconds)
EndFunc

Func CustomLog( $logMessage )
   ConsoleWrite( TimeToLogginHumanReadableString(TimerDiff($timer)) & " " & $logMessage & @CRLF )
EndFunc

Func SendKeyIfConditionIsMet( $previousLoopValue, $currentLoopValue, $period, $key, $logMessage )
   If $period > 0 And $previousLoopValue <> $currentLoopValue And ( $previousLoopValue == 0 Or ( Floor( $previousLoopValue / $period ) <> Floor( $currentLoopValue / $period ) ) ) Then
	  CustomLog( $logMessage )
	  Send($key)
   EndIf
EndFunc

Func TriggerIfPossibleSkillWithIndex($skillIndex)
	If $Skill_TriggerPeriod[$skillIndex] > 0 And ( $Skill_LastTriggerTime[$skillIndex] == Null Or TimerDiff($checkLoopTimer) - $Skill_LastTriggerTime[$skillIndex] > $Skill_TriggerPeriod[$skillIndex] ) Then
		CustomLog( "Automatically trigger skill " & $skillIndex )
		Send($Skill_Key[$skillIndex])
		SkillUsedWithIndex($skillIndex)
	EndIf
EndFunc

Func SkillUsedWithIndex($skillIndex)
	If WinActive($ragnarokClickerWindowName) Then
		CustomLog("Skill " & $skillIndex & " triggered.")
		If Null <> $checkLoopTimer Then
			$Skill_LastTriggerTime[$skillIndex] = TimerDiff($checkLoopTimer)
		EndIf
	EndIf
EndFunc

Func CheckLoopInit()
   ; 0 = relative coords to the active window
   ; 1 = (default) absolute screen coordinates
   ; 2 = relative coords to the client area of the active window
   Opt("MouseCoordMode",0)
   $checkLoopTimer = TimerInit()
EndFunc

Func CheckLoopStep()
   $shouldAutomationBeActive = False
   If $enableLoopCheck And WinActive($ragnarokClickerWindowName) Then
;~ 	  CustomLog( "Windows is active" )
	  ;$WindowPos = WinGetPos($ragnarokClickerWindowName)
	  $MousePos = MouseGetPos()
	  $MouseRelativePos = $MousePos
	  ;$MouseRelativePos[0] = $MouseRelativePos[0] - $WindowPos[0]
	  ;$MouseRelativePos[1] = $MouseRelativePos[1] - $WindowPos[1]
	  ; Click X 845 [650 to 1130]
	  ; Click Y 320 [150 to 500]
	  $LastRelativeMouseX = $MouseRelativePos[0]
	  $LastRelativeMouseY = $MouseRelativePos[1]
;~ 	  CustomLog( "MouseRelativePos X=" & $LastRelativeMouseX & " Y=" & $LastRelativeMouseY )
	  ;If $LastRelativeMouseX > 650 And $LastRelativeMouseX < 1130 And $LastRelativeMouseY > 150 And $LastRelativeMouseY < 500 Then
	  If $LastRelativeMouseX > 700 And $LastRelativeMouseX < 1030 And $LastRelativeMouseY > 100 And $LastRelativeMouseY < 500 Then
		 MouseClick("left", $LastRelativeMouseX, $LastRelativeMouseY, $numberOfClicks, 1)
		 $shouldAutomationBeActive = True
	  EndIf
   EndIf

   If Not $shouldAutomationBeActive Then
	  $lastLoopTimeCounter = 0
	  $loopTimeCounter = 0
	  $activeLoopTimer = Null
   Else
	  If $activeLoopTimer == Null Then
		 $activeLoopTimer = TimerInit()
	  EndIf
	  $lastLoopTimeCounter = $loopTimeCounter
	  If $UseLoopCounterInsteadOfRealTime Then
		 $loopTimeCounter += $loopSleep
	  Else
		 $loopTimeCounter = TimerDiff($activeLoopTimer)
	  EndIf

	  If $EnableAutomaticModeToggle Then
		 SendKeyIfConditionIsMet( $lastLoopTimeCounter, $loopTimeCounter, $AutomaticModeTogglePeriod, "a", "Toggle Automatic Mode" )
	  EndIf
	  If $EnableAutomaticPeriodicSkillsActivation Then
		 TriggerIfPossibleSkillWithIndex(5)
		 TriggerIfPossibleSkillWithIndex(7)
		 TriggerIfPossibleSkillWithIndex(4)
		 TriggerIfPossibleSkillWithIndex(0)
		 TriggerIfPossibleSkillWithIndex(1)
		 TriggerIfPossibleSkillWithIndex(2)
		 TriggerIfPossibleSkillWithIndex(8)
		 TriggerIfPossibleSkillWithIndex(3)
		 TriggerIfPossibleSkillWithIndex(6)
	  EndIf

	  If $EnableOldBlueBoxCheck And $OldBlueBoxCheckPeriod > 0 And $lastLoopTimeCounter <> $loopTimeCounter And ( ( Floor( $lastLoopTimeCounter / $OldBlueBoxCheckPeriod ) <> Floor( $loopTimeCounter / $OldBlueBoxCheckPeriod ) ) ) Then
		 CheckOldBlueBoxesLocations()
	  EndIf

	  If $EnableNewEquipementBoxCheck And $NewEquipementBoxCheckPeriod > 0 And $lastLoopTimeCounter <> $loopTimeCounter And ( ( Floor( $lastLoopTimeCounter / $NewEquipementBoxCheckPeriod ) <> Floor( $loopTimeCounter / $NewEquipementBoxCheckPeriod ) ) ) Then
		 CheckNewEquipementBox()
	  EndIf

	  If $EnableLastAdventurerHiring And $LastAdventurerHiringPeriod > 0 And $lastLoopTimeCounter <> $loopTimeCounter And ( ( Floor( $lastLoopTimeCounter / $LastAdventurerHiringPeriod ) <> Floor( $loopTimeCounter / $LastAdventurerHiringPeriod ) ) ) Then
		 HireLastAdventurerAvailable()
	  EndIf

   EndIf
EndFunc

Func RunCheckLoop()

   CheckLoopInit()

   ; Just idle around
   While $continueLoop

	  CheckLoopStep()

	  ;CustomLog( TimerDiff($timer) & " Before Sleep" & @CRLF )
	  Sleep($loopSleep)
   WEnd
EndFunc

Func CheckOldBlueBoxesLocations()
   ; Checking Old Blue Boxes possible locations
   CustomLog( "Checking Old Blue Boxes possible locations" )

   ; Coordinates of OldBlueBoxes (How many different ?)
   ; #1
   ; X : 530
   ; Y : 490
   MouseClick("left", 530, 490, 1, 4 )
   ; #2
   ; X : 760
   ; Y : 380
   MouseClick("left", 760, 380, 1, 4 )
   ; #3
   ; X : 1000
   ; Y : 450
   MouseClick("left", 1000, 450, 1, 4 )
   ; #4
   ; X : 750
   ; Y : 430
   MouseClick("left", 750, 430, 1, 4 )
   ; #5
   ; X : 875
   ; Y : 515
   MouseClick("left", 875, 515, 1, 4 )
   ; #6
   ; X : 1050
   ; Y : 450
   MouseClick("left", 1050, 450, 1, 4 )
   ; #N
   ; X : ???
   ; Y : ???

   ; Restore previous mouse location
   MouseMove( $LastRelativeMouseX, $LastRelativeMouseY, 4 )
EndFunc

Func CheckNewEquipementBox()
   ; Checking New Equipement Box window
   CustomLog( "Checking New Equipement Box window" )

   ; Box New Equipement Window
   ; Central Open button
   ; X : 585
   ; Y : 345
   MouseClick("left", 585, 345, 1, 4 )
   Sleep(500)
   ; Close Button
   ; X : 930
   ; Y : 150
   MouseClick("left", 930, 150, 1, 4 )

   ; Restore previous mouse location
   MouseMove( $LastRelativeMouseX, $LastRelativeMouseY, 4 )
EndFunc

Func HireLastAdventurerAvailable()
   ; Hiring/Upgrading last Adventurer available
   CustomLog( "Hiring/Upgrading last Adventurer available" )

   ; Tab Adventurer
   ; X : 58
   ; Y : 158
   Sleep(50)
   MouseClick("left", 58, 158, 1, 4 )
   Sleep(100)

   ; Refresh Tab Adventurer scroll position to max bottom
   $mouseWheelStep = 1
   $mouseWheelPeriod = 10
   For $indexOfScroll = 0 To 1 Step $mouseWheelStep
	  MouseWheel( $MOUSE_WHEEL_UP, $mouseWheelStep )
	  Sleep($mouseWheelPeriod)
   Next
   For $indexOfScroll = 0 To 30 Step $mouseWheelStep
	  MouseWheel( $MOUSE_WHEEL_DOWN, $mouseWheelStep )
	  Sleep($mouseWheelPeriod)
   Next

   Sleep(100)
   ; Upgrade last adventurer
   ; X : 500
   ; Y : 500
   ; Upgrade before last adventurer
   ; X : 500
   ; Y : 370
   MouseClick("left", 500, 370, 1, 4)

   ; Coordinates to button buy all upgrades when scroll down to max in adventurer tab
   ; X : 460
   ; Y : 560
   MouseClick("left", 460, 560, 1, 4)

   ; Restore previous mouse location
   MouseMove( $LastRelativeMouseX, $LastRelativeMouseY, 4 )
EndFunc
