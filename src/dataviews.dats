#include "share/atspre_staload.hats"



(* --------------------------------------------------
Optional Views
-------------------------------------------------- *)
dataview option_v (v:view+,bool) = 
  | Some_v (v,true) of (v) 
  | None_v (v,false) of () 




// TODO implement ptr_alloc_opt (don't trust unimplemented ATS!)
extern
fun {a:t@ype} 
  ptr_alloc_opt () : [l:addr] (option_v (a? @l, l > null) | ptr l)




(* --------------------------------------------------
Disjunctive Views
-------------------------------------------------- *)


dataview VOR (v0:view+, v1:view+, int) = 
  | VORLeft (v0,v1,0) 
  | VORRight (v0,v1,1)


