; FROM https://www.autoitscript.com/forum/topic/82096-script-to-wait-for-mouse-click-to-get-mouse-coords-resolved/

#include <Misc.au3>

HotKeySet("{ESC}", "Terminate")

$WindowName = "Ragnarok Clicker"

$dll = DllOpen("user32.dll")

While 1
    Sleep(10) ; This enough to prevent CPU overload <<<<<<<<<<<<<<<<<<<<<<<<
    If _IsPressed("01", $dll) Then
	    $WindowPos = WinGetPos($WindowName)
        $MousePos = MouseGetPos()
        ConsoleWrite("Window X=" & $WindowPos[0] & @CRLF & "Window Y=" & $WindowPos[1] & @CRLF & "Mouse X=" & $MousePos[0] & @CRLF & "Mouse Y=" & $MousePos[1] & @CRLF)
        ConsoleWrite("Relative Mouse X=" & ($MousePos[0]-$WindowPos[0]) & @CRLF & "Relative Mouse Y=" & ($MousePos[1]-$WindowPos[1]) & @CRLF)
        While _IsPressed("01", $dll)
            Sleep(10)
        WEnd
    EndIf
WEnd

Func Terminate()
    DllClose($dll)
    Exit 0
EndFunc