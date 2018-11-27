(*

From Blog Post:

https://bluishcoder.co.nz/2013/01/25/an-introduction-to-pointers-in-ats.html


An Introduction to using pointers in ATS

The ATS programming language was designed to enable safe systems programming. 
This requires dealing with pointers safely. In this post I intend to go through 
the basics of pointer handling in ATS and how this safety is achieved.

*)
#include "share/atspre_staload.hats"


(*

Raw Pointers

ATS has a basic pointer type called ptr. 
This is a non-dependent type and is the equivalent to a void* 
in the C programming language. It also has a dependently typed 
pointer type that is indexed over an addr sort 
(sorts are the types of type indexes) that represents the address of the pointer. 

This allows the proof and type system to reason about pointer addresses. 

Pointer arithmetic can be done on values of these types but they can't be safely dereferenced. 

The following example shows some basic usage:
*)

extern fun malloc (s: size_t): ptr = "mac#malloc"
extern fun free (p:ptr) : void = "mac#free"

val v = let 
  val a = malloc(g0int2uint_int_size(3));
  val _ = print(a);
  in  free(a)
  end