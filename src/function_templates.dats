(*
Function Templates

A function template is a code template that 
implements a function.

http://ats-lang.github.io/DOCUMENT/INT2PROGINATS/HTML/INT2PROGINATS-BOOK-onechunk.html#function_templates
*)

#include "share/atspre_staload.hats"
staload UN  = "prelude/SATS/unsafe.sats"
staload _  = "prelude/DATS/unsafe.dats"



(*

In the following code two functions are defined to swap values

typedef charint = (char, int)
typedef intchar = (int, char)
fun swap_char_int (xy: charint): intchar = (xy.1, xy.0)
fun swap_int_char (xy: intchar): charint = (xy.1, xy.0)

If types are ignored, the bodies of swap_char_int and swap_int_char are identical. In order to avoid this kind of code duplication, we can first implement a function template swap as follows and then implement swap_char_int and swap_int_char based on swap: 
*)


fun {a,b:t@ype} swap (xy: (a,b)):(b,a) = ( xy.1, xy.0)

(* Function templates are not first class values!  
   This is an important distinction!
   
*)

fun swap_int_char(xy:(int,char)) = swap<int,char>(xy)

(* Perhaps we want to give parameters sequentially instead of simultaneously *)

fun {a:t@ype}{b:t@ype} swap2(xy:(a,b)):(b,a) = ( xy.1, xy.0)

(* Note that >< is a special symbol (of the name GTLT) and no space is allowed between > and <. *)
fun swap_int_char2(xy:(int,char)) = swap2<int><char>(xy)



(* 
As another example, a higher-order function template for composing (closure) functions is given as follows: 


Hence, envless functions and closure-functions can be distinguished at the level of types.

If the syntax :<cloref1> is replaced with the colon symbol : alone, the code can still pass typechecking but its compilation may eventually lead to a warning or even an error indicating that loop cannot be compiled into a toplevel function in C. The reason for this warning/error is due to the body of loop containing a variable n that is neither at toplevel nor a part of the arguments of loop itself. It is straightforward to make loop an envless function by including n as an argument in addition to the original ones: 
*)

typedef cfun (t1:t@ype, t2:t@ype) = t1 -<cloref1> t2

fun {a,b,c:t@ype}
 compose (f:cfun(a,b), g:cfun(b,c)) :<cloref1> cfun(a,c)  = lam x => g(f(x))