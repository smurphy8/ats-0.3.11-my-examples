(*
 Probably the single greatest motivation behind the development of ATS is the desire to make ATS a programming language 
 that can be employed effectively to construct safe and reliable programs running in the kernels of operating systems. 
 
 Instead of following seemingly natural approaches that often focus on carving out a "safe" subset of C and/or put wrappers 
 around "unsafe" programming features in C, ATS relies on the paradigm of programming with theorem-proving to prevent 
 resources such as memory from being misused or mismanaged, advocating an approach to safety that is both general 
 and flexible. For example, a well-typed program constructed in ATS cannot cause buffer overrun at run-time even 
 though pointer arithmetic is fully supported in ATS. More specifically, if a pointer is to be dereferenced, 
 ATS requires that a proof be given attesting to the safety of the dereferencing operation.

 Proofs of this kind are constructed to demonstrate the validity of linear propositions, which are referred 
 to as views in ATS, for classifying resources as well as capabilities.  
 *)
 
#include "share/atspre_staload.hats"
staload UN  = "prelude/SATS/unsafe.sats"
staload _  = "prelude/DATS/unsafe.dats"


(*
Views for Memory Access through Pointers

A view is a linear version of prop, 
where the word linear comes from linear logic, 
a resource-aware logic invented by Jean-Yves Girard. 

There is a built-in sort view for static terms representing views. 
Given a type T and a memory location L, a view of the form T@L can 
be formed to indicate a value of the type T being stored in the 
memory at the location L, where @ is a special infix operator. 
Views of this form are extremely common in practice, and they are 
often referred to as at-views. 

*)





(* From Bluish coders examples on pointers in ATS 
   Super helpful!
*)
extern fun malloc (s: sizeof_t int): [l:agz] (int @ l | ptr l) = "mac#malloc"
extern fun free {l:agz} (pf: int @ l | p: ptr l): void = "mac#free"



(*

This function has to be written with the let signature because the types are evaluated from left to right:


When constructing (pf | !p), 'pf' is held by the type checker and then !p could no longer find the view it needs
in order to fetch the data. So the data needs to be fetched first: let val x = !p in (pf | x)

*)
fun{a:t@ype}
ptr_get0 {l:addr} (pf: a @ l | p: ptr l): (a @ l | a) = 
    let val a = !p in (pf|a) end


(*
Again, the actual actions have to come before reference to the pointers!
So weird
*)
fun {a:t@ype} 
ptr_set0 {l:addr} (pf: a? @ l |p:ptr(l) , x:a) : (a@l | void) = let 
  val () = !p := x
  in (pf|())
  end


(* 

The proofs mean you need an extra placeholder
but that is because you don't have a requirement that the get proof is not consumed
*)

fun {a:t@ype} 
ptr_swap0 {l1,l2 : addr} ( pf1: a@l1   , pf2:a@l2
                         | p1: ptr(l1) , p2:ptr(l2)) : 
                         ( a@l1, a@l2 | void) = let
  val (pf2'| tmp2) = ptr_get0(pf2|p2)
  val (pf1'| tmp1) = ptr_get0(pf1|p1)
  val (pf1_fin| ()) = ptr_set0(pf1'|p1,tmp2)
  val (pf2_fin| ()) = ptr_set0(pf2'|p2,tmp1)
  in  (pf1_fin,pf2_fin|())
  end
                          

                         
// TODO implement swap 1

// get1 first
// demonstrating use of >> operator which says a proof is transformed
// but not consumed (i think)
fun {a:t@ype}
ptr_get1 {l:addr} (pf : !a@l >> a@l | p : ptr l): a = !p 


// get1_alt and get1 implement same thing
fun {a:t@ype}
ptr_get1_alt {l:addr} (pf: !a@l|p:ptr(l)):a = !p


fun {a:t@ype} 
ptr_set1 {l:addr} (pf : !a? @ l >> a@l | p : ptr l ,x:a) :void = let
  val () = !p := x
  in () end



(*
viewtypes as combinations of views and types.

a VT is a view combined with a type VT == (V | T)
*)

vtypedef tptr (a:t@ype, l:addr) = (a @ l | ptr l)


// a counter from a pointer
// This function is interesting because it combines proofs on
// types (refinement) with linear proofs (view type) 
fn getInc {l:addr} {n:nat} (counter: !tptr(int(n),l)  >> tptr(int(n+1),l)):int(n) =
  let
   val n = ptr_get1<int(n)> (counter.0|counter.1)
   val () = ptr_set1<int(n+1)>(counter.0|counter.1,n+1)
  in n end


  
