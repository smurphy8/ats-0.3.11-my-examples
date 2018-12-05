#include
"share/atspre_staload.hats"


(* Given a list xss of length m in which each element is of the type list(T,n) , 
for some type T, list_concat<T>(xss) constructs a list of the type: list(T,m*n).

When the first matching clause in the code for list_concat is typechecked,
a constraint is generated that is essentially like the following one:

m= m1 + 1 implying n + (m1*n) = m*n holds for all natural numbers m, m1 and n.

*)

  
fun{
a:t@ype
} list_concat{m,n:nat}
(
  xss: list(list(a, n), m)
) : [p:nat] (MUL(m, n, p) | list(a, p)) =
(
//
case+ xss of
| list_nil () =>
    (MULbas() | list_nil())
| list_cons (xs, xss) => let
    val (pf | res) = list_concat (xss)
  in
    (MULind pf | list_append<a> (xs, res))
  end // end of [list_cons]
//
) (* end of [list_concat] *)
  
  
(*
Given a list xss of the type list(list(T,n),m), list_concat(xss) now returns a pair (pf | res) 
such that pf is a proof of the prop-type MUL(m,n,p) for some natural number p and res is a list 
of the type list(T,p), where the symbol bar (|) is used to separate proofs from values. 

In other words, pf acts as a witness to the equality p=m*n. After proof erasure is performed, 
this implementation of list_concat is essentially translated into the previous one 
(as far as dynamic semantics is concerned). In particular, there is no need for proof 
construction at run-time. 

*)  

prfn 
mul_istot{m,n:int}():<prf> [p:int] MUL(m, n, p) = let
//
prfun istot
  {m:nat;n:int} .<m>. (): [p:int] MUL(m, n, p) =
  sif m > 0 then MULind(istot{m-1,n}()) else MULbas()
// end of [istot]
//
in
  sif m >= 0 then istot{m,n}() else MULneg(istot{~m,n}())
end // end of [mul_istot]  


(*  
--------------------------------------------------
Data Direction Mockup stuff
--------------------------------------------------

Below are functions mimicing the proof terms needed 
for a data direction register 

a data direction registers says whether something is writeable or not
by assigning a 1 or a zero to a value then that value corresponds to a port
that can then be read or written to.

For instance to write to PortB pin 0 
isSet(0,DDRB) Should be true
 
*)



datatype bit_status =
  | set of () | unset of ()

sortdef bit = {n:nat | n <2}



dataprop IsSet(int) = 
  |IsSet(1) of ()
//  |IsSetOne  (1)  of IsSet(i)


dataprop IsWriteable(int,int,bool) = 
  | {i,j:int} Writeable(i,j,true) of ()
  | {i,j:int} NotWriteable(i,j,false) of ()

sortdef bit = {b:int| b <2 && b >= 0}
typedef Bit = [b:bit] int(b)


typedef twoBitVector = @(bool,bool)


// Dummy Set bit vector function as an example
// extern  
// fn setBitVector (i:int) : void



fn getBitVector {i,j:int}  (bv:int(j)) : [b:bool] (IsWriteable(i,j,b)|bool(b)) = 
  if bv > 3 then   
  (Writeable() | true)
  else
  (NotWriteable() | false)

 
(* This function contains a lot of important ideas
   First, you can use sif to directly manipulate a static term (w in this case)
   Also, there is a proof term we wrote by hand (IsWriteable)
*)
fn setBitVectorWithProof {i,j:int} {w:bool} (pf:IsWriteable(i,j,w) | b:int(i)) : 
   [t:bool | t== true] (IsWriteable(i,j,t) | void)  = 
   sif w == true then
     (pf|())
   else
     let val _ = () // setBitVector(b);
     in
     (Writeable() | ())
     end




 

// extern
fun writeThing {i:int|i==1 }  (b0:int(i)): (IsSet(i) | void) = case+ b0 of
 | 1 => (IsSet()|())
 

  

// val _ = writeThing(0)  
  
