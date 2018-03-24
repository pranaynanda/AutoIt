Global $output , $input

$input= InputBox("Select", "Type your value")
$output= MsgBox(4,"Select", "Choose a Value")

if $output=6 Then
MsgBox(0, "Your Choice", "You Chose " & $input) Else
   Run("calc.exe")
   EndIf