#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <DateTimeConstants.au3>
#include <date.au3>
#Region ### START Koda GUI section ### Form=
Global $Form_Main = GUICreate("Tự động tắt máy", 516, 504, -1, -1)
GUISetFont(20, 400, 0, "Segoe UI")
Global $Label_ShutdownOrRestart = GUICtrlCreateLabel("Tùy chọn", 16, 8, 111, 41)
Global $Combo_ShutdownOrRestart = GUICtrlCreateCombo("", 16, 64, 145, 25, BitOR($GUI_SS_DEFAULT_COMBO,$CBS_SIMPLE))
GUICtrlSetData(-1, "Tắt máy|Khởi động lại", "Tắt máy")
GUICtrlSetCursor (-1, 0)
Global $Checkbox_CloseAppBeforeStart = GUICtrlCreateCheckbox("Đóng ứng dụng trước khi tắt máy", 16, 168, 417, 41)
GUICtrlSetCursor (-1, 0)
Global $Checkbox_SettingTime = GUICtrlCreateCheckbox("Tùy chỉnh thời gian", 16, 208, 361, 49)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetCursor (-1, 0)
Global $Label_ShutdownIn = GUICtrlCreateLabel("Tắt máy trong", 16, 264, 170, 41)
Global $Input_Time = GUICtrlCreateInput("30", 192, 264, 121, 45, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER,$ES_NUMBER))
GUICtrlSetCursor (-1, 5)
Global $Label_Seconds = GUICtrlCreateLabel("giây", 328, 264, 54, 41)
Global $Button_SettingTime = GUICtrlCreateButton("Hẹn giờ", 384, 256, 115, 49)
GUICtrlSetCursor(-1 ,0)
Global $Button_Start = GUICtrlCreateButton("Bắt đầu", 32, 440, 200, 49)
GUICtrlSetCursor (-1, 0)
Global $Button_Stop = GUICtrlCreateButton("Hủy", 280, 440, 200, 49)
GUICtrlSetCursor (-1, 0)
Global $Label_Comment = GUICtrlCreateLabel("Chú thích", 16, 320, 116, 41)
Global $Edit_Comment = GUICtrlCreateEdit("", 152, 320, 329, 113)
GUICtrlSetData(-1, "")
Global $Pic1 = GUICtrlCreatePic("C:\Users\Admin\Pictures\jack.jpg", 176, 8, 316, 148)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###



#Region ### START Koda GUI section ### Form=
Global $Form_SettingTime = GUICreate("Tùy chỉnh giờ", 276, 193, -1, -1)
Global $Date_Setting = GUICtrlCreateDate("", 24, 16, 218, 53, BitOR($DTS_UPDOWN,$DTS_TIMEFORMAT))
GUICtrlSetCursor (-1, 0)
Local $sStyle = "yyyy/MM/dd HH:mm:ss"
GUICtrlSendMsg($Date_Setting, $DTM_SETFORMATW, 0, $sStyle)

Global $Button_OK = GUICtrlCreateButton("OK", 64, 96, 147, 82, $BS_ICON)
GUIctrlSetCursor(-1, 0)
GUICtrlSetImage(-1, "C:\Users\Admin\Pictures\superidol3.ico", -1)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg(1)
	Switch $nMsg[0]
		Case $GUI_EVENT_CLOSE
			if $nMsg[1] == $Form_Main Then
				Exit
			ElseIf $nMsg[1] == $Form_SettingTime Then
				GUISetState(@SW_HIDE, $Form_SettingTime)
			EndIf
		Case $Checkbox_SettingTime
			Local $check = GUICtrlRead($Checkbox_SettingTime)
			if $check = $GUI_checked Then
				_ifCheckBoxTicked(True)
			Else
				_ifCheckBoxTicked(False)
			EndIf
		Case $Button_SettingTime
			GUISetState(@SW_SHOW, $Form_SettingTime)
		Case $Button_Start
			run('shutdown' & _combineTheCommand(), '', @SW_HIDE)
		Case $Button_Stop
			run('shutdown -a', '', @SW_HIDE)
		Case $Button_OK
			local $timeSetting = GUICtrlRead($Date_Setting)
			local $timeOnClock = _NowCalc()
			local $timeDifferent = _DateDiff('s',$timeOnClock, $timeSetting )
			if $timeDifferent < 0 Then
				MsgBox(16 + 262144, 'Lỗi', 'Vui lòng nhập lại thời gian')
			Else
				GUICtrlSetData($Input_Time, $timeDifferent)
				GUISetState(@SW_HIDE, $Form_SettingTime)
			EndIf

	EndSwitch
WEnd

Func _ifCheckBoxTicked($check)
	local $View_Tickbox_time = GUICtrlRead($Checkbox_SettingTime)
	local $option = 64
	if $check = True Then
		$option = 64
	Else
		$option = 128
	EndIf
		GUICtrlSetState($Label_ShutdownIn, $option)
		GUICtrlSetState($Input_Time, $option)
		GUICtrlSetState($Label_Seconds, $option)
		GUICtrlSetState($Button_SettingTime, $option)
EndFunc

func _combineTheCommand()
	local $cmd
	if GUICtrlRead($Combo_ShutdownOrRestart) = 'Tắt máy' Then
		$cmd &= ' -s'
	Else
		$cmd &= ' -r'
	EndIf

	if GUICtrlRead($Checkbox_CloseAppBeforeStart) = $GUI_checked Then
		$cmd &= ' -f'
	EndIf

	local $time = GUICtrlRead($Input_Time)
	If not $time Then
		GUICtrlSetData($Input_Time, '30')
		$time = 30
	EndIf
	$cmd &= ' -t' & ' ' & $time

	if GUICtrlRead($Edit_Comment) Then
		$cmd &= ' -c' & ' '& GUICtrlRead($Edit_Comment)
	EndIf
	Return $cmd
EndFunc