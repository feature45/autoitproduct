#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
#Region ### START Koda GUI section ### Form=
Global $Form_main = GUICreate("Đăng nhập", 405, 362, -1, -1)
GUISetFont(16, 400, 0, "Segoe UI")
Global $Input_username = GUICtrlCreateInput("", 168, 32, 161, 38)
Global $Input_password = GUICtrlCreateInput("", 168, 104, 161, 38, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
Global $Label_username = GUICtrlCreateLabel("Tài khoản", 48, 32, 88, 34)
Global $Label_password = GUICtrlCreateLabel("Mật khẩu", 48, 104, 86, 34)
Global $Button_login = GUICtrlCreateButton("Đăng nhập", 128, 280, 155, 57)
GUIctrlSetState(-1, 256)
GUICtrlSetCursor(-1, 0)
Global $Checkbox_renemberPassword = GUICtrlCreateCheckbox("Nhớ mật khẩu", 48, 168, 297, 33)
GUICtrlSetCursor(-1, 0)
Global $Checkbox_setInfoOfLog = GUICtrlCreateCheckbox("Tự động điền mật khẩu đã lưu", 48, 224, 350, 33)
GUICtrlSetCursor(-1, 0)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
;ghi nhớ đăng nhập

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Button_login
			;khai báo các thành phần của GUI
			local $checkbox = GUIctrlread($Checkbox_renemberPassword)
			local $username = GUICtrlRead($Input_username)
			local $password = GUICtrlRead($Input_password)

			;tạo 1 tài khoản và mk
			if $username = 'feature45' and $password = '123456' Then
				MsgBox(0 + 262144, "Thông báo", "Đăng nhập thành công")
			Else
				MsgBox(0 + 262144, "Thông báo", "Đăng nhập thất bại")
				ContinueLoop
			EndIf

			;khi checkbox lưu mật khẩu được tick:
			if $checkbox = $GUI_Checked Then

				;ghi tk mk vào file tk mk
				local $renemberUsername = FileOpen("ghinhotaikhoan.txt",2)
				FileWrite($renemberusername, $username)
				local $renemberPassword = FileOpen("ghinhomatkhau.txt", 2)
				FileWrite($renemberpassword, $password)

				MsgBox(0 + 262144, "Thông báo", "Đã lưu mật khẩu")
			EndIf

		Case $Checkbox_setInfoOfLog
		;set thông tin đăng nhập vào inputbox
			if GUICtrlRead($Checkbox_setInfoOfLog) = $GUI_Checked Then
				;xóa những gì input hiện có
				GUICtrlSetState($Input_username, '')
				GUICtrlSetState($Input_password, '')

				;in ra tk mk đã lưu trước đó
				local $readUsername = FileOpen("ghinhotaikhoan.txt", 0)
				GUICtrlSetData($Input_username, FileRead($readUsername))
				local $readPassword = FileOpen("ghinhomatkhau.txt", 0)
				GUICtrlSetData($Input_password, FileRead($readPassword))
			EndIf

		;ẩn nút set thông tin đi
;~ 			GUICtrlSetState($Checkbox_setInfoOfLog, 128)
	EndSwitch
WEnd