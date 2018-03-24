Global $a, $b, $c

$a=10
$b=5

$c= $a + $b
MsgBox(0, "Sum", "Sum of A and B is " & $c)

$c= $a - $b
MsgBox(0, "Difference", "Difference of A and B is " & $c)

$c= $a * $b
MsgBox(0, "Sum", "Product of A and B is " & $c)

$c= $a / $b
MsgBox(0, "Sum", "Quotient of A and B is " & $c)

$a += $b
MsgBox(0, "Sum", "A added to B is " & $a)

$a -= $b
MsgBox(0, "Sum", "A Subtracted from B is " & $a)

$a *= $b
MsgBox(0, "Sum", "A multiplied to B is " & $a)

$a /= $b
MsgBox(0, "Sum", "A divided by B is " & $a)

MsgBox(0, "Updated Value", "Updated Value of A is " & $a)

$c=1
MsgBox(0, "Updated Value", "Updated Value of C is " & $c)

If $a>$c Then
   MsgBox(0, "Comparison", "A is greater than C")
EndIf
If $a<$b Then
   MsgBox(0,"Comparison", "A is less than B")
EndIf
If $a<>$c Then
MsgBox(0, "Comparsion", "A is not equal to C")
EndIf

$a="Hello"
$c="hello"

If $a=$c Then
   MsgBox(0, "Comparison", "A is same as C")
EndIf

If $a==$c Then
   MsgBox(0, "Comparison", "A is not same as C")
EndIf

$c="Hello"

If $a==$c Then
   MsgBox(0, "Comparison", "A is not same as C")
EndIf
