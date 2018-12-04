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


