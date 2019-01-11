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