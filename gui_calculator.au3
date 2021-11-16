#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
Global $Form_main = GUICreate("Máy tính ảo", 384, 375, -1, -1)
GUISetFont(16, 400, 0, "Segoe UI")
Global $Input_Num1 = GUICtrlCreateInput("", 24, 56, 145, 38, BitOR($GUI_SS_DEFAULT_INPUT, $ES_RIGHT,$ES_NUMBER))
Global $Input_Num2 = GUICtrlCreateInput("", 208, 56, 145, 38, BitOR($GUI_SS_DEFAULT_INPUT,$ES_RIGHT, $ES_NUMBER))
Global $Input_Result = GUICtrlCreateInput("", 128, 120, 225, 38, BitOR($GUI_SS_DEFAULT_INPUT,$ES_READONLY,$ES_RIGHT,$ES_NUMBER))
Global $Label_Num1 = GUICtrlCreateLabel("Số hạng 1", 24, 8, 85, 34)
Global $Label_Num2 = GUICtrlCreateLabel("Số hạng 2", 208, 8, 85, 34)
Global $Label_Result = GUICtrlCreateLabel("Kết quả:", 32, 120, 80, 34)
Global $Radio_Cong = GUICtrlCreateRadio("Phép cộng", 24, 176, 145, 41)
GUICtrlSetCursor (-1, 0)
Global $Radio_Tru = GUICtrlCreateRadio("Phép trừ", 24, 224, 113, 41)
GUICtrlSetCursor (-1, 0)
Global $Radio_nhan = GUICtrlCreateRadio("Phép nhân", 24, 272, 137, 41)
GUICtrlSetCursor (-1, 0)
Global $Radio_chia = GUICtrlCreateRadio("Phép chia", 24, 320, 145, 41)
GUICtrlSetCursor (-1, 0)
Global $Button_Calc = GUICtrlCreateButton("Tính", 168, 184, 187, 169, $BS_ICON)
GUICtrlSetImage(-1, "C:\Users\Admin\Pictures\icon\superidol1.ico", -1)
GUICtrlSetCursor (-1, 0)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Button_Calc
			GUICtrlSetData($Input_Result, pheptinh())
	EndSwitch
WEnd

func pheptinh()
	local $ketqua
	local $soHang1 = GUICtrlRead($Input_Num1)
	local $soHang2 = GUICtrlRead($Input_Num2)

	Select
		case GUICtrlRead($Radio_Cong) = $gui_checked
			$ketqua = $soHang1 + $soHang2
		case GUICtrlRead($Radio_Tru) = $gui_checked
			$ketqua = $soHang1 - $soHang2
		case GUICtrlRead($Radio_nhan) = $gui_checked
			$ketqua = $soHang1 * $soHang2
		case GUICtrlRead($Radio_chia) = $gui_checked
			if $soHang2 = 0 Then
				MsgBox(16 + 262144, 'Lỗi', 'Không thể chia cho 0')
			Else
				$ketqua = $soHang1 / $soHang2
			EndIf
	EndSelect

	Return $ketqua
EndFunc