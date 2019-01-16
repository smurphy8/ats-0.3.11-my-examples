#include "share/atspre_staload.hats"


dataview option_v (v:view+,bool) = 
  | Some_v (v,true) of (v) 
  | None_v (v,false) of () 


extern
fun {a:t@ype} 
  ptr_alloc_opt () : [l:addr] (option_v (a? @l, l > null) | ptr l)
// TODO implement dataview dataprops stuff from Ch14 