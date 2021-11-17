#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <file.au3>
#Region ### START Koda GUI section ### Form=
Global $Form1 = GUICreate("Notepad", 615, 437, 192, 124, BitOR($GUI_SS_DEFAULT_GUI,$WS_MAXIMIZEBOX,$WS_SIZEBOX,$WS_THICKFRAME,$WS_TABSTOP))
Global $MenuItem3 = GUICtrlCreateMenu("&File")
Global $MenuItem6 = GUICtrlCreateMenuItem("&New" & @TAB & "Ctrl+N", $MenuItem3)
Global $MenuItem5 = GUICtrlCreateMenuItem("&Open" & @TAB & "Ctrl+O", $MenuItem3)
Global $MenuItem4 = GUICtrlCreateMenuItem("&Save" & @TAB & "Ctrl+S", $MenuItem3)
Global $MenuItem1 = GUICtrlCreateMenuItem("", $MenuItem3)
Global $MenuItem7 = GUICtrlCreateMenuItem("&Exit", $MenuItem3)
Global $MenuItem2 = GUICtrlCreateMenu("&Help")
Global $MenuItem8 = GUICtrlCreateMenuItem("&About Notepad" & @TAB & "Ctrl+A", $MenuItem2)
Global $Edit1 = GUICtrlCreateEdit("", 0, 0, 615, 417)
GUICtrlSetResizing(-1, $GUI_DOCKAUTO)
Global $Form1_1_AccelTable[2][2] = [["!+{SYS REQ}", $MenuItem6],["^t", $MenuItem7]]
GUISetAccelerators($Form1_1_AccelTable)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $MenuItem6	;new
			luufile()
		Case $MenuItem5	;open
			Local $formopen = FileOpenDialog("Open",@ScriptDir,"All (*.*)|Text files (*.txt)" ,1+2+4+8,"",$Form1)   ;bat cai form len
			if $formopen Then ;neu form duoc bat
				local $fileopen = FileOpen($formopen,128) ;khai bao bien bat. che do read va write UTF18
				local $nd = FileRead($fileopen) ;gan' gia tri cua file cho bien' $nd
				GUICtrlSetData($Edit1,$nd) ; in ra khung $edit1 noi dung $nd

;~ 				Doi ten tieu de
				doitentieude($formopen)
			EndIf
		Case $MenuItem4 ;save
			local $luu =luufile(0)
			local $formopen=doitentieude($formopen)
		Case $MenuItem7	;exit
			Exit
		Case $MenuItem8
			MsgBox(0,'About','Phan mem notepad')
	EndSwitch
WEnd

Func luufile($xoaform = 1)
local $noidungnhap = GUICtrlRead($Edit1)
	if $noidungnhap Then
		local $formsave = FileSaveDialog("Save", @ScriptDir,'All (*.*)|Text files (*.txt)' ,2+16, "", $Form1)
		FileWrite($formsave, $noidungnhap)
		FileClose($formsave)
		MsgBox(0,'Thong bao','Da luu')
		if $xoaform = 1 then
		GUICtrlSetData($Edit1,"")
		EndIf
	endIf
EndFunc

Func doitentieude($formopen)
	local $drive,$dir,$filename,$ext
	_PathSplit($formopen,$drive,$dir,$filename,$ext)
	WinSetTitle($form1,'',$filename&$ext & ' - Notepad')
EndFunc
