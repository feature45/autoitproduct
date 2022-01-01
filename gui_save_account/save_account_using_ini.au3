#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#Region ### START Koda GUI section ### Form=
Global $Form1 = GUICreate("Form1", 616, 331, 192, 124)
Global $Input1 = GUICtrlCreateInput("", 224, 40, 249, 44)
GUICtrlSetFont(-1, 23, 400, 0, "MS Sans Serif")
Global $Input2 = GUICtrlCreateInput("", 224, 104, 249, 44)
GUICtrlSetFont(-1, 23, 400, 0, "MS Sans Serif")
Global $Label1 = GUICtrlCreateLabel("Tài khoản", 80, 40, 119, 41)
GUICtrlSetFont(-1, 20, 400, 0, "Segoe UI")
Global $Label2 = GUICtrlCreateLabel("Mật khẩu", 80, 104, 115, 41)
GUICtrlSetFont(-1, 20, 400, 0, "Segoe UI")
Global $Luu = GUICtrlCreateCheckbox("Lưu mật khẩu", 100, 184, 600, 25)
GUICtrlSetFont(-1, 24, 400, 0, "Segoe UI")
Global $Button1 = GUICtrlCreateButton("Đăng nhập", 192, 232, 179, 57)
GUICtrlSetFont(-1, 24, 400, 0, "Segoe UI")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


get_account()

While 1

	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Luu
		Case $Button1
			local $username = GUICtrlRead($Input1)
			Local $password = GUICtrlRead($Input2)
			local $check_box = GUICtrlRead($luu)
			if $username = 'admin' and $password = '123456' then
				MsgBox(0,0,'Đăng nhập thành công')

				if $check_box = $GUI_CHECKED Then
					save_account($username, $password, $check_box)
					MsgBox(0,0,'Đã lưu mật khẩu')
				Else
					FileDelete('save_account.ini')
				EndIf
			EndIf


	EndSwitch
WEnd

Func save_account($username, $password, $check_box)
	IniWrite('save_account.ini', 'save_account', 'username', $username)
	IniWrite('save_account.ini', 'save_account', 'password', $password)
	IniWrite('save_account.ini', 'setting', 'check_box', $check_box)


EndFunc

Func get_account()
	local $kiem_tra_check_box = IniRead('save_account.ini', 'setting', 'check_box', 0)

	if $kiem_tra_check_box = 1 Then

		$username = IniRead('save_account.ini', 'save_account', 'username', '')
		$password = IniRead('save_account.ini', 'save_account', 'password', '')

		GUICtrlSetData($Input1, $username)
		GUICtrlSetData($Input2, $password)
		GUICtrlSetState($luu, 1 )
	Else
		GUICtrlSetState($luu, 0 )
	EndIf


EndFunc










