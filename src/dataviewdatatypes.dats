(*

Chapter 15. Dataviewtypes as Linear Datatypes

A dataviewtype can be thought of as a linear version of datatype. To a large extent, it is a combination of a datatype and a dataview. This programming feature is primarily introduced into ATS for the purpose of providing in the setting of manual memory management the kind of convenience brought by pattern matching. In a situation where GC must be reduced or even completely eliminated, dataviewtypes can often be chosen as a replacement for datatypes. I now present in this chapter some commonly encountered dataviewtypes and their uses. 


*)
#include "share/atspre_staload.hats"

(* Option datatype 
quick note, the '+' is just for improving errors
(I think)
*)
datavtype option_vt (a:t@ype+ , bool) = 
  | Some_vt (a,true) of a 
  | None_vt (a,false) of () 


(* A type has to be constructed out of the datavtype
with the existential bool defined in the type.

This makes the signature foo():[b:bool] option_vt(a,b)
into this
foo():Option_vt(a) 
So yeah totally worth it.

But since generally we don't care about the true false thing
and are only interested in it as a way to connect the static to
the dynamic it does make sense to internalize them.

*)
vtypedef Option_vt (a:t@ype) = [b:bool] option_vt(a,b)

fun {a:t@ype}
find_rightmost
  {n:nat} .<n>.
(
  xs: list (a, n), P: (a) -<cloref1> bool
) : Option_vt(a)  = case+ xs of 
  | list_cons(x,xs) => None_vt () (* end of [find_rightmost] *)
  | list_nil() => None_vt ()
  