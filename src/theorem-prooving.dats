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


datatype bit_status =
  | set of () | unset of ()

sortdef bit = {n:nat | n <2}



dataprop IsSet(int) = 
  |IsSet(1) of ()
//  |IsSetOne  (1)  of IsSet(i)


dataprop IsWriteable(int,int,bool) = 
  | {i,j:int} Writeable(i,j,true) of ()
  | {i,j:int} NotWriteable(i,j,false) of ()
//  | {i:int} {t:int} IsWriteable(i,t,false) of () 

sortdef bit = {b:int| b <2 && b >= 0}
typedef Bit = [b:bit] int(b)


typedef twoBitVector = @(bool,bool)

extern  
fn setBitVector (i:int) : void


// extern
fn getBitVectorStatus {i,j:int}  (bv:int(j)) : [b:bool] (IsWriteable(i,j,b)|bool(b)) = 
  if bv > 3 then   
  (Writeable() | true)
  else
  (NotWriteable() | false)

 
//extern

(* fn setBitVectorWithProof {i:int} {w:bool} (b:int(i)) : void  =  *)
(*   let  *)
(*   val (pf:IsWriteable(i,i,w)|total) = getBitVectorStatus{i}(b) in *)
(*    () *)
(*   end *)






 

// extern
fun writeThing {i:int|i==1 }  (b0:int(i)): (IsSet(i) | void) = case+ b0 of
 | 1 => (IsSet()|())
 

  

// val _ = writeThing(0)  
  
