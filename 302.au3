Global $output , $input

$input= InputBox("Select", "Type your value")
$output= MsgBox(4,"Select", "Choose a Value")

if $output=6 Then
MsgBox(0, "Your Choice", "You Chose " & $input)
Else
   Run("\\INGGNM7FPA.WW007.SIEMENS.NET\z003mjry$\My Documents\AutoIt\201.au3")
   EndIf