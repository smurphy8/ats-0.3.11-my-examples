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



(* getopt, get an optionally assigned value *)
extern 
fun 
  {a:t@ype}
  getopt {l:addr} 
  (pf : a? @ l  | ptr(l)): [i:int] (VOR (a? @ l, a @ l, i) | int(i))



// TODO get example of getopt working ch 14 

(* an example usage of getopt
   remember view@ and addr@ split a viewtype into its proof and its pointer
*) 


fun 
  {a:t@ype}
  foo {l:addr} () : void = let 
    var x : a? @l 

//    val (pfor | i) = getopt<a> ( view@(x) | addr@(x))
    in
    ()
    end   
        

