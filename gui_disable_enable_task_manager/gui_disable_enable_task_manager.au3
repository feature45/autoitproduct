#RequireAdmin
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
Global $Form1 = GUICreate("Disable / Enable Task Manager", 577, 437, -1, -1)
GUISetFont(20, 400, 0, "Segoe UI")
Global $Enable = GUICtrlCreateButton("Enable", 160, 40, 267, 105)
Global $Disable = GUICtrlCreateButton("Disable", 160, 232, 267, 105)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Global $key_name = "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

Global $value_name = "DisableTaskMgr"

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $Enable 		;bật task manager
			RegDelete($key_name, $value_name)
			MsgBox(64 + 262144, "Thành công","Khôi phục thành công")



		Case $Disable 		;vô hiệu task manager

			RegWrite($key_name, $value_name, "REG_DWORD", 1)
			if @error Then
				MsgBox(64 + 262144, "Lỗi", "Chạy với quyền admin đi bạn")
			Else
				MsgBox(64 + 262144, "Thành công", "Vô hiệu hóa thành công")
			EndIf


	EndSwitch
WEnd
