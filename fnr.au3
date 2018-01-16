#include <File.au3>
#include <Array.au3>
#include <Date.au3>
#include <ListViewEditInput.au3>
#include <GuiListView.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <ListViewConstants.au3>
#include <WindowsConstants.au3>

$time = _Now()
$timestr=String($time)

If StringLeft($timestr,1)== "1" Then
	$dd=StringLeft($timestr,2)
Else
	$dd=StringLeft($timestr,1)
EndIf
;ConsoleWrite($dd & @CRLF)
$mm=StringMid($timestr,3,2)
;ConsoleWrite($mm& @CRLF)
$yy=StringMid($timestr,6,4)
;ConsoleWrite($yy& @CRLF)
If StringMid($timestr,11,1)== "1" Then
	$hh=StringMid($timestr,11,2)
Else
	$hh=StringMid($timestr,11,1)
EndIf
;$hh=StringMid($timestr,11,2)
;ConsoleWrite($hh& @CRLF)
$min=StringMid($timestr,14,2)
;ConsoleWrite($min& @CRLF)
$ss=StringMid($timestr,17,2)
;ConsoleWrite($ss& @CRLF)
Global $date=$dd&$mm&$yy& "_" & $hh&$min&$ss&StringRight($timestr,2)
;ConsoleWrite($time & @CRLF)
;MsgBox(0,"test",$date)


If $CmdLine[0] > 0 Then
	Global $FileList = _FileListToArrayRec($CmdLine[1], "*.*",1,1,1,2)
	$sLog = @ScriptDir& "\" & $date & ".log"
	For $i=1 to $FileList[0]
	For $j=2 to $CmdLine[0] Step 1
		If Mod($j,2)=0 Then
		;$sFile=$CmdLine[1]
			$find=$CmdLine[$j]
			$replace=$CmdLine[$j+1]
			;if @error Then ContinueLoop
		;Else
		;	$replace=$CmdLine[$j]
		;	if @error Then ContinueLoop
		EndIf

	$sFile=$FileList[$i]
	_ReplaceInFile($sLog, $sFile, $find, $replace)
	Next
	Next
	Exit
EndIf


#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Find and Replace", 621, 627, 192, 124)
$Input1 = GUICtrlCreateInput("Source Folder", 120, 32, 417, 21)
$List1 = GUICtrlCreateList("", 120, 64, 417, 214)
GUICtrlSetResizing(-1, $GUI_DOCKAUTO)
$Button1 = GUICtrlCreateButton("Browse", 48, 32, 65, 25)
$ListView1 = GUICtrlCreateListView("Find|Replace With", 120, 304, 417, 241)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 205)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 208)
GUICtrlCreateListViewItem('|',$ListView1)
$Button2 = GUICtrlCreateButton("Replace", 128, 568, 409, 41)
$Button3 = GUICtrlCreateButton("Add Row",540,304,80,25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###






$TabDummy=GUICtrlCreateDummy()
GUICtrlSetOnEvent(-1,"_tabPressed")
Global $arAccelerators[1][2]=[["{TAB}", $TabDummy]]


__ListViewEditInput_StartUp($Form1)
;Listview hinzufügen (Nur Spalte 1 und 2 darf bearbeitet werden) (doubleclick)
;add listview, only edit col 1 and 2, doubleclick
__ListViewEditInput_AddListview($Form1,$ListView1,"0,1,2")
;2. Listview hginzufügen (Nur Zeile 4 darf bearbeitet werden) (singleClick)
;add second listview, row 4 edited,singleclick
__ListViewEditInput_AddListview($Form1,$ListView1,"All","E")
;ESC zum abbrechen und ENTER zum abschicken initialisieren
;esc to cancel and enter to send
__ListViewEditInput_InitializeKeys($Form1,$arAccelerators)
;registriere Funktion, die aufgerufen wird, wenn ein Feld bearbeitet wurde
;register function, after editing a field
__ListViewEditInput_RegisterFunction($ListView1,"_edited","Changed")
;registriere Funktion, die aufgerufen wird, wenn ein Feld nicht bearbeitet wurde
;register Function, when field not edited
__ListViewEditInput_RegisterFunction($ListView1,"_canceled","Canceled")
;listview ist nicht mehr bearbeitbar
;listview can not be edited anymore
;__ListViewEditInput_DeleteListview($hListView2)


While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $Button1
			_SelectFolder()
		Case $Button2
			_fnr()
		Case $Button3
			_AddRow()
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd


;GUI
#cs
GUICreate("Find And Replace", 1000, 600)
$sourceFolder = GUICtrlCreateInput("Source Folder", 10, 10, 280, 20)
$add = GUICtrlCreateButton("Add", 10, 35, 75, 20)
$mylist = GUICtrlCreateList("", 10, 60, 280, 300)
$Button2=GUICtrlCreateButton("Replace",10,350)
$ListView1=GUICtrlCreateListView("Find|Replace",10,600,850,550,-1)
GUISetState(@SW_SHOW)


While 1
    $msg = GUIGetMsg()
    Switch $msg
		Case $Button1
			_SelectFolder()
		Case $Button2
			_fnr()
        Case $GUI_EVENT_CLOSE
            ExitLoop
    EndSwitch
WEnd

#ce

Func _SelectFolder()
	Global $open=FileSelectFolder("Select Folder","")
	GUICtrlSetData($Input1,$open)
	;$sFolder = ControlGetText("Automation", "", "Edit1")
	Global $FileList = _FileListToArrayRec($open, "*.*",1,1,1,2)

		If @error = 1 Then
			MsgBox(0, "", "No Folders Found.")
			Exit
		EndIf
		If @error = 4 Then
			MsgBox(0, "", "No Files Found.")
			Exit
		EndIf

		For $i = 1 To $FileList[0]
			GUICtrlSetData($List1, $FileList[$i])
		Next
EndFunc

#cs
Func _fnr()
$find=InputBox("Find","Find")
$replace=InputBox("Replace With", "Replace With")
$time=_Now()
MsgBox(0,"hello",$time)
Local $logfile= $open & "\" & $time & ".log"
MsgBox(0,"hello",$FileList[0])
	For $i=1 To $FileList[0]
		;MsgBox(0,"hello",$FileList[$i])
	$a=_ReplaceStringInFile($FileList[$i],$find,$replace)
	FileWriteLine($logfile, $find & " was replaced with " & $replace & " in file " & $FileList[$i])
	Next
MsgBox(0,"Test",$a)
EndFunc
#ce

#cs
Func _fnr()
	Global $sLog
    ;$find = InputBox("Find", "Find")
    ;$replace = InputBox("Replace With", "Replace With")
    $time = _Now()
	;$timestr=String($time)
    ;MsgBox(0, "hello", $timestr)
	$count = _GUICtrlListView_GetItemCount($ListView1)
    ;Global $logfile = $open & "\" & $time & ".log"
	Global $sLog = "itworks.log"
    MsgBox(0, "hello", $count)
	For $i=0 to $count
		$find=_GUICtrlListView_GetItemText($ListView1, $i - 1,1)
		$replace=_GUICtrlListView_GetItemText($ListView1, $i - 1,2)
		MsgBox(0,"test", $find & " " & $replace)

			#cs
			For $j = 1 To $FileList[0]
				;MsgBox(0,"hello",$FileList[$i])
				;_ReplaceStringInFile($FileList[$i],$find,$replace)
				_ReplaceInFile($sLog, $FileList[$j], $find, $replace)
			Next
			#ce
	Next

    ;MsgBox(0, "Test", $a)
EndFunc   ;==>_fnr

#ce

Func _fnr()
    $time = _Now()
    ;MsgBox(0, "hello", $timestr)
    $count = _GUICtrlListView_GetItemCount($ListView1)
    ;Local $logfile = $open & "\" & $time & ".log"
    Global $sLog = $date & ".log"
    ;MsgBox(0, "hello", $count)
    For $i = 0 To $count
        $find = _GUICtrlListView_GetItemText($ListView1, $i)                ;<======
        $replace = _GUICtrlListView_GetItemText($ListView1, $i, 1)          ;<======
        If StringStripWS($find, $STR_STRIPALL) = "" Then ContinueLoop       ;$find mustn't be empty
        If StringStripWS($replace, $STR_STRIPALL) = "" Then ContinueLoop    ;$replace mustn't be empty
        MsgBox(0, "test", $find & " " & $replace)
        ;For $j = 1 To $FileList[0]         ;don't use more than one Filelist can be added to $List1
        For $j = 0 To _GUICtrlListBox_GetCount($List1) - 1
            $sFile = _GUICtrlListBox_GetText($List1, $j)
            MsgBox(0, "hello", $sFile,2)
            _ReplaceInFile($sLog, $sFile, $find, $replace)
        Next
    Next

    ;MsgBox(0, "Test", $a)
EndFunc   ;==>_fnr

#cs
Func _ReplaceInFile($sLog, $sFile, $sSearch, $sReplace)
    Local $hFile = FileOpen($sFile)
    Local $aLines = FileReadToArray($sFile)
    FileClose($hFile)
    For $i = 0 To UBound($aLines) - 1
        If StringReplace($aLines[$i], $sSearch, $sReplace) Then _
                _FileWriteLog($sLog, $sFile & @TAB & $aLines[$i] & ': ' & $sSearch & ' ==> ' & $sReplace & @CRLF)
    Next
    _FileWriteFromArray($sFile, $aLines)
EndFunc   ;==>_ReplaceInFile
#ce
;#cs
Func _ReplaceInFile($sLog, $sFile, $sSearch, $sReplace)
    Local $hFile = FileOpen($sFile)
    Local $aLines = FileReadToArray($sFile)
    ;_ArrayDisplay($aLines)
    FileClose($hFile)
    For $i = 0 To UBound($aLines) - 1
        $aLines[$i]=StringReplace($aLines[$i], $sSearch, $sReplace)
        If @extended Then _FileWriteLog($sLog, $sSearch & " was replaced with " & $sReplace & " in " & $sFile & " at line number " & @TAB & $i  & @CRLF & @CRLF)
    Next
    _FileWriteFromArray($sFile, $aLines)
EndFunc   ;==>_ReplaceInFile
;#ce
Func _tabPressed()
	$arLastEdited=__ListViewEditInput_GetEditedCell()
	$count=_GUICtrlListView_GetColumnCount($arLastEdited[0])
	__ListViewEditInput_saveLVChange()
	if $arLastEdited[2]<$count then
		__ListViewEditInput__EditItem($arLastEdited[0],$arLastEdited[1],$arLastEdited[2]+1)
	endif
EndFunc

Func _AddRow()
	GUICtrlCreateListViewItem("|",$ListView1)
EndFunc