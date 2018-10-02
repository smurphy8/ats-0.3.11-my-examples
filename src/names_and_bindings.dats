#include
"share/atspre_staload.hats"

// Vals can be expressions
val x = 1 + 2

// Note that it is unspecified in ATS as to which of the first two bindings (connected by the keyword and) is finalized ahead of the other 
// at run-time. However, it is guaranteed that the third binding is finalized after the first two are done. To see this issue from a 
// different angle, we can try to typecheck the following code: 


val PI = 3.14159 and radius = 10.0
val area = PI * radius * radius

