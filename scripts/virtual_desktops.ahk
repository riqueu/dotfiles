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
+#left::VD.MoveWindowToRelativeDesktopNum("A", -1).follow()
; Move window to right and follow it
+#right::VD.MoveWindowToRelativeDesktopNum("A", 1).follow()

; Switch to the nth desktop using Win + #
#1::VD.goToDesktopNum(1)
#2::VD.goToDesktopNum(2)
#3::VD.goToDesktopNum(3)
#4::VD.goToDesktopNum(4)
#5::VD.goToDesktopNum(5)
#6::VD.goToDesktopNum(6)
#7::VD.goToDesktopNum(7)
#8::VD.goToDesktopNum(8)
#9::VD.goToDesktopNum(9)
#0::VD.goToDesktopNum(10) ; Assuming 0 maps to the 10th desktop

; move window to nth desktop and follow it
+#1::VD.MoveWindowToDesktopNum("A", 1).follow()
+#2::VD.MoveWindowToDesktopNum("A", 2).follow()
+#3::VD.MoveWindowToDesktopNum("A", 3).follow()
+#4::VD.MoveWindowToDesktopNum("A", 4).follow()
+#5::VD.MoveWindowToDesktopNum("A", 5).follow()
+#6::VD.MoveWindowToDesktopNum("A", 6).follow()
+#7::VD.MoveWindowToDesktopNum("A", 7).follow()
+#8::VD.MoveWindowToDesktopNum("A", 8).follow()
+#9::VD.MoveWindowToDesktopNum("A", 9).follow()
+#0::VD.MoveWindowToDesktopNum("A", 10).follow()

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