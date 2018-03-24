Global $x, $y, $z

$x=1

Do
  $x+=$x
   MsgBox(0,"Out", $x)
Until $x>=10

$x=1
While $x<=10
   $x+=$x
   MsgBox(0,"Out", $x)
WEnd


For $x= 1 To 10
   $x+=$x
   MsgBox(0,"Out", $x)
Next