
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>

Local $continueLoop = true
Local $timer = TimerInit()
Local $activeLoopTimer = Null
Local $loopTimeCounter = 0
Local $UseLoopCounterInsteadOfRealTime = False

Local $AutomaticModeTogglePeriod = 2.5*60*1000
Local $Skill_1_TriggerPeriod = 1*10*60*1000
Local $Skill_2_TriggerPeriod = 1*10*60*1000
Local $Skill_3_TriggerPeriod = 1*30*60*1000
Local $Skill_4_TriggerPeriod = 1*30*60*1000
Local $Skill_5_TriggerPeriod = 1*60*60*1000
Local $Skill_6_TriggerPeriod = 8*60*60*1000
Local $Skill_7_TriggerPeriod = 1*60*60*1000
Local $Skill_8_TriggerPeriod = 1*60*60*1000
Local $Skill_9_TriggerPeriod = 1*60*60*1000

Local $LastAdventurerHiringPeriod = 1*01*60*1000
Local $OldBlueBoxCheckPeriod = 1*01*60*1000

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

;~ HotKeySet("h", "StopLoop")
HotKeySet("!v", "StopLoop") ; !v means ALT + "v"

RunCheckLoop()

Func SendKeyIfConditionIsMet( $previousLoopValue, $currentLoopValue, $period, $key, $logMessage )
   If $period > 0 And $previousLoopValue <> $currentLoopValue And ( $previousLoopValue == 0 Or ( Floor( $previousLoopValue / $period ) <> Floor( $currentLoopValue / $period ) ) ) Then
	  CustomLog( $logMessage )
	  Send($key)
   EndIf
EndFunc

Func RunCheckLoop()

   $ragnarokClickerWindowName = "Ragnarok Clicker"

   $pos = WinGetPos($ragnarokClickerWindowName)
   $x = 300
   $y = 30

   ; 0 = relative coords to the active window
   ; 1 = (default) absolute screen coordinates
   ; 2 = relative coords to the client area of the active window
   Opt("MouseCoordMode",0)

   ;WinWaitActive($ragnarokClickerWindowName)

   ; Just idle around
   While $continueLoop
	  $shouldAutomationBeActive = False
	  If WinActive($ragnarokClickerWindowName) Then
;~ 		 CustomLog( "Windows is active" )
		 ;$WindowPos = WinGetPos($ragnarokClickerWindowName)
		 $MousePos = MouseGetPos()
		 $MouseRelativePos = $MousePos
		 ;$MouseRelativePos[0] = $MouseRelativePos[0] - $WindowPos[0]
		 ;$MouseRelativePos[1] = $MouseRelativePos[1] - $WindowPos[1]
		 ; Click X 845 [650 to 1130]
		 ; Click Y 320 [150 to 500]
		 $mouseX = $MouseRelativePos[0]
		 $mouseY = $MouseRelativePos[1]
;~ 		 CustomLog( "MouseRelativePos X=" & $mouseX & " Y=" & $mouseY )
		 ;If $mouseX > 650 And $mouseX < 1130 And $mouseY > 150 And $mouseY < 500 Then
		 If $mouseX > 700 And $mouseX < 1030 And $mouseY > 100 And $mouseY < 500 Then
			MouseClick("left", $mouseX, $mouseY, $numberOfClicks, 1)
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
			$loopTimeCounter = TimerDiff($timer)
		 EndIf

		 SendKeyIfConditionIsMet( $lastLoopTimeCounter, $loopTimeCounter, $AutomaticModeTogglePeriod, "a", "Toggle Automatic Mode" )
		 SendKeyIfConditionIsMet( $lastLoopTimeCounter, $loopTimeCounter, $Skill_6_TriggerPeriod, '-', "Use skill 6" )
		 SendKeyIfConditionIsMet( $lastLoopTimeCounter, $loopTimeCounter, $Skill_8_TriggerPeriod, '_', "Use skill 8" )
		 SendKeyIfConditionIsMet( $lastLoopTimeCounter, $loopTimeCounter, $Skill_5_TriggerPeriod, '(', "Use skill 5" )
		 SendKeyIfConditionIsMet( $lastLoopTimeCounter, $loopTimeCounter, $Skill_9_TriggerPeriod, 'ç', "Use skill 9" )
		 SendKeyIfConditionIsMet( $lastLoopTimeCounter, $loopTimeCounter, $Skill_1_TriggerPeriod, "&", "Use skill 1" )
		 SendKeyIfConditionIsMet( $lastLoopTimeCounter, $loopTimeCounter, $Skill_2_TriggerPeriod, "é", "Use skill 2" )
		 SendKeyIfConditionIsMet( $lastLoopTimeCounter, $loopTimeCounter, $Skill_3_TriggerPeriod, '"', "Use skill 3" )
		 SendKeyIfConditionIsMet( $lastLoopTimeCounter, $loopTimeCounter, $Skill_4_TriggerPeriod, "'", "Use skill 4" )
		 SendKeyIfConditionIsMet( $lastLoopTimeCounter, $loopTimeCounter, $Skill_7_TriggerPeriod, 'è', "Use skill 7" )

		 If $OldBlueBoxCheckPeriod > 0 And $lastLoopTimeCounter <> $loopTimeCounter And ( ( Floor( $lastLoopTimeCounter / $OldBlueBoxCheckPeriod ) <> Floor( $loopTimeCounter / $OldBlueBoxCheckPeriod ) ) ) Then
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
			MouseMove( $mouseX, $mouseY, 4 )

		 EndIf

		 If $LastAdventurerHiringPeriod > 0 And $lastLoopTimeCounter <> $loopTimeCounter And ( ( Floor( $lastLoopTimeCounter / $LastAdventurerHiringPeriod ) <> Floor( $loopTimeCounter / $LastAdventurerHiringPeriod ) ) ) Then
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
			MouseMove( $mouseX, $mouseY, 4 )
		 EndIf

	  EndIf

	  ;CustomLog( TimerDiff($timer) & " Before Sleep" & @CRLF )
	  Sleep($loopSleep)
   WEnd
EndFunc
