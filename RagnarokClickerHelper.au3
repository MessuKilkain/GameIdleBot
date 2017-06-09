
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>

Local $continueLoop = true
Local $timer = TimerInit()
Local $loopTimeCounter = 0

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

Func CustomLog( $logMessage )
   ConsoleWrite( StringFormat("%08.2f",TimerDiff($timer)) & " " & $logMessage & @CRLF )
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
	  $lastLoopTimeCounter = $loopTimeCounter
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
			$loopTimeCounter += $loopSleep
		 Else
			$loopTimeCounter = 0
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

		 If $LastAdventurerHiringPeriod > 0 And $lastLoopTimeCounter <> $loopTimeCounter And ( ( Floor( $lastLoopTimeCounter / $LastAdventurerHiringPeriod ) <> Floor( $loopTimeCounter / $LastAdventurerHiringPeriod ) ) ) Then
			; Hiring last Adventurer available
			CustomLog( "Hiring last Adventurer available" )

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

			; Upgrade last adventurer
			; X : 500
			; Y : 500
			; Upgrade before last adventurer
			; X : 500
			; Y : 370
			MouseClick("left", 500, 370, 1, 4)

			MouseMove( $mouseX, $mouseY, 4 )
		 EndIf
	  Else
		 $loopTimeCounter = 0
	  EndIf

	  ;CustomLog( TimerDiff($timer) & " Before Sleep" & @CRLF )
	  Sleep($loopSleep)
   WEnd
EndFunc
