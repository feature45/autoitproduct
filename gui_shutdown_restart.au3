#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <DateTimeConstants.au3>
#include <Date.au3>
#Region ### START Koda GUI section ### Form=
Global $Main = GUICreate("ShutdownAndRestart", 496, 492, -1, -1)
GUISetFont(16, 400, 0, "Segoe UI")
Global $LabelSettingMode = GUICtrlCreateLabel("Setting Mode", 16, 16, 129, 34)
Global $ComboShutdownRestart = GUICtrlCreateCombo("", 16, 64, 145, 25, BitOR($GUI_SS_DEFAULT_COMBO,$CBS_SIMPLE))
GUICtrlSetData(-1, "Shutdown|Restart", "Shutdown")
Global $CheckboxClosePrg = GUICtrlCreateCheckbox("Close program before turn off", 16, 120, 305, 41)
Global $CheckboxSetTime = GUICtrlCreateCheckbox("Setting time before start", 16, 168, 297, 41)
GUICtrlSetState(-1, $GUI_CHECKED)
Global $LabelTurnOffIn = GUICtrlCreateLabel("Turn off in:", 16, 224, 112, 34)
Global $InputTime = GUICtrlCreateInput("30", 136, 224, 121, 38, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER,$ES_NUMBER))
Global $LabelSeconds = GUICtrlCreateLabel("seconds", 272, 224, 79, 34)
Global $ButtonSetTime = GUICtrlCreateButton("Set Time", 360, 224, 99, 41)
Global $LabelNotification = GUICtrlCreateLabel("Notification:", 24, 288, 118, 34)
Global $Edit = GUICtrlCreateEdit("", 24, 328, 425, 89)
Global $PicDam = GUICtrlCreatePic("C:\Users\Admin\Pictures\damlingo.jpg", 320, 8, 156, 196)
Global $ButtonStart = GUICtrlCreateButton("Start", 24, 432, 219, 49)
Global $ButtonCancel = GUICtrlCreateButton("Cancel", 256, 432, 219, 49)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


#Region ### START Koda GUI section ### Form=
Global $FormTimePicker = GUICreate("Set Time", 342, 150, -1, -1, -1, -1, $Main)
GUISetFont(16, 400, 0, "Segoe UI")
Global $DatePicker = GUICtrlCreateDate("", 32, 24, 274, 38, BitOR($DTS_UPDOWN,$DTS_TIMEFORMAT))
Local $sStyle = "yyyy/MM/dd HH:mm:ss"
    GUICtrlSendMsg( $DatePicker, $DTM_SETFORMATW, 0, $sStyle)

Global $ButtonOK = GUICtrlCreateButton("OK", 96, 80, 139, 49)
#EndRegion ### END Koda GUI section ###




While 1
	$nMsg = GUIGetMsg(1)
	Switch $nMsg[0]
		Case $GUI_EVENT_CLOSE
			if $nMsg[1] == $Main Then
				Exit
			EndIf
			if $nMsg[1] == $FormTimePicker Then
				GUISetState(@SW_HIDE, $FormTimePicker)
			EndIf
		Case $CheckboxSetTime
			if GUICtrlRead($CheckboxSetTime) = $GUI_CHECKED Then
				checktickboxsettime(1)
				GUICtrlSetState($InputTime,256)
			Else
				checktickboxsettime(0)
			EndIf
		Case $ButtonSetTime
			GUISetState(@SW_SHOW, $FormTimePicker)
		Case $ButtonStart
			run(settingshutdown(),'',@SW_HIDE)
		Case $ButtonCancel
			run('shutdown -a','',@SW_HIDE)
		Case $ButtonOK
			local $timepick = GUICtrlRead($DatePicker)
			Local $time = _DateDiff('s', _NowCalc(), $timepick)
			if $time <= 0  Then
				MsgBox(16 + 262144, 'Error', 'Please set an invalid time')
			Else
				GUICtrlSetData($InputTime, $time)
				GUISetState(@SW_HIDE, $FormTimePicker)
			EndIf
	EndSwitch
WEnd

Func checktickboxsettime($check)
	local $mode = $check? '16' : '32'
	GUICtrlSetState($LabelTurnOffIn, $mode)
	GUICtrlSetState($InputTime, $mode)
	GUICtrlSetState($LabelSeconds, $mode)
	GUICtrlSetState($ButtonSetTime, $mode)
EndFunc

func settingshutdown()
	$cmd = 'Shutdown'
	if GUICtrlRead($ComboShutdownRestart) = 'Shutdown' Then
		$cmd &= ' -s'
	Else
		$cmd &= ' -r'
	EndIf

	if GUICtrlRead($CheckboxClosePrg) = $GUI_CHECKEd Then
		$cmd &= ' -f'
	EndIf

	Local $timeset = GUICtrlRead($InputTime)
	if $timeset Then
		$cmd &= ' -t ' & $timeset
	ElseIf not $timeset Then
		GUICtrlSetData($InputTime, '30')
		$cmd &= ' -t' & '30'
	EndIf

	local $commentset = GUICtrlRead($Edit)
	if $commentset Then
		$cmd &= ' -c ' & $commentset
	EndIf

	Return $cmd
EndFunc

