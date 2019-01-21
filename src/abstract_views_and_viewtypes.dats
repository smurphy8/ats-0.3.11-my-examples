(*

I have so far given a presentation of views that solely focuses on at-views and the views built on top of at-views. 
This is largely due to at-views being the form of most widely used views in practice and also being the first form 
of views supported in ATS. However, other forms of views can be readily introduced into ATS abstractly. Even in a 
case where a view can be defined based on at-views (or other forms of views), one may still want to introduce it as 
an abstract view (accompanied with certain proof functions for performing view-changes). Often what the programmer 
really needs is to figure out conceptually whether abstractly defined views and proof functions for manipulating them 
actually make sense. This is a bit like arguing whether a function is computable: There is rarely a need, if at all, 
to actually encode the function as a Turing-machine to prove its being computable. IMHO, learning proper use of 
abstract views and abstract viewtypes is a necessary step for one to take in order to employ linear types effectively 
in practice to deal with resource-related programming issues. 

*)

#include 
"share/atspre_staload.hats"




(* An example of a simple linear object
Let us now take a look at a concrete example of simple linear object. 
The following code presents an interface for a timer (that is, stopwatch): 
 *) 

absvtype timer_vtype 
vtypedef timer = timer_vtype


extern fun timer_new (): timer
extern fun timer_free(x: timer): void
extern fun timer_start (x: !timer): void
extern fun timer_finish (x: !timer): void
extern fun timer_pause (x: !timer): void
extern fun timer_resume (x: !timer): void
extern fun timer_get_ntick (x: !timer): uint
extern fun timer_reset (x: !timer): void

(*
The state of a timer is given the record type timer_struct defined as follows: 
*)


typedef
timer_struct = @{
   started= bool // the timer has started
 , running= bool // the timer is running
 , ntick_beg= uint //last on
 , ntick_acc= uint //number of ticks accumulated
 }
 

(*
The following linear datatype timer is declared for timers, 
and the abstract type timer_vtype is assumed to equal timer:  *)

datavtype timer = 
  TIMER of (timer_struct) 


(* In order to construct values of an abstract type, we need to concretize it temporarily by using the following form of declaration: 
*)  
assume timer_vtype = timer  




implement
timer_new () = let
//
val timer = TIMER (_)
val TIMER (x) = timer
//
val () = x.started := false
val () = x.running := false
val () = x.ntick_beg := 0u
val () = x.ntick_acc := 0u
//
(*  The special proof function fold@ is called on timer to fold it plus the proofs of at-views 
attached to L1 and L2 into a linear list.  *)
prval () = fold@ (timer)
//
in
  timer
end // end of [timer_new]

// TODO implement the rest of the abstract view type example