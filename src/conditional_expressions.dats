#include
"share/atspre_staload.hats"


// Conditional Expressions
// if then else are all required except in cases 
// where you use a void type
val rslt = let val x = 0
           in ( if (x >= 0) 
                then 
                  x 
                else 
                  ~x) 
           end
           


// void tuple           

val rslt' = let val x = 0
            in ( if (x >= 0)
                 then 
                   print("void condition"))
            end  