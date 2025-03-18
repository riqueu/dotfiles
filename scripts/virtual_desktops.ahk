#Requires AutoHotkey v2.0
#SingleInstance force
ListLines 0
SendMode "Input"
SetWorkingDir A_ScriptDir
KeyHistory 0
#WinActivateForce
ProcessSetPriority "H"
SetWinDelay -1
SetControlDelay -1
#Include "C:\Program Files\AutoHotkey\libraries\VD.ah2"

; wrapping / cycle back to first desktop when at the last
;^#left::VD.goToRelativeDesktopNum(-1)
;^#right::VD.goToRelativeDesktopNum(+1)

; move window to left and follow it
+^#left::VD.MoveWindowToRelativeDesktopNum("A", -1).follow()
; Move window to right and follow it
+^#right::VD.MoveWindowToRelativeDesktopNum("A", 1).follow()

; Virtual Desktop switching with mouse side buttons on taskbar hover
$XButton1:: {
    if MouseIsOverTaskbar() {
        VD.goToRelativeDesktopNum(-1)
    } else {
        Send "{XButton1}"
    }
}

$XButton2:: {
    if MouseIsOverTaskbar() {
        VD.goToRelativeDesktopNum(1)
    } else {
        Send "{XButton2}"
    }
}

; Middle-click taskbar for Task View (Win+Tab)
$MButton:: {
    if MouseIsOverTaskbar() {
        Send "{LWin down}{Tab}{LWin up}"  ; Win+Tab to open Task View
    } else {
        Send "{MButton}"
    }
}

MouseIsOverTaskbar() {
    MouseGetPos ,, &MouseWin
    try {
        WinClass := WinGetClass(MouseWin)
        return WinClass = "Shell_TrayWnd" || WinClass = "Shell_SecondaryTrayWnd"
    }
    catch {
        return false
    }
}