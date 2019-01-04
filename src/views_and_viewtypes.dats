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


(*  Crazy Closure function in ATS book 

We are going to pair a function which takes an enviornment and a variable
\(env, a) -> b with an environment env 
Then store it all in a pointer p.

This is an implmentation of a pointer to a closure.
thus cloptr = closure-pointer

In the implementation, env is passed as reference.
Interestingly the type system forces this as part of the type!

Also it is interesting that it is explicitly stated

*)

vtypedef cloptr 
  (a:t@ype, b:t@ype, l:addr) = 
  [env:t@ype]  // ∃ env of t@ype
  (((&env,a) -> b, env) @ l | ptr l) 

// Apply a value to a closure pointer

fun 
  {a: t@ype} {b: t@ype} 
  cloptr_app {l: addr}
  (pclo : !cloptr (a,b,l) , x: a): b = let
  val p = pclo.1 // Taking the address out
             
  val  res = !p.0      //f(&env,a) → b 
              (!p.1,x) // (&env,a)
  in res end
  
// TODO implement cloptr example
val example_using_cloptr = ()













// ---------------------------------------------------

(* LEFT Values and Call by Reference *)

// --------------------------------------------------







(*

In ATS, the simplest expression representing a left-value 
is !p, where ! is a special symbol and p a value of the 
type ptr(L) for some address L. When this expression is 
typechecked, a proof of T@L for some type T is required 
to be found among the currently available proofs.

The default strategy for passing a function argument in ATS 
is call-by-value. However, it is also allowed in ATS to specify 
that call-by-reference is chosen for passing a particular 
function argument. By call-by-reference, it is meant that 
the argument to be passed must be a left-value and what is 
actually passed is the address of the left-value 
(instead of the value stored at the address). 
For example, the following defined function swap2 
makes essential use of call-by-reference: 

The '&' means implement using call by reference


*)



fn {a : t@ype} 
swap2 (x1: &a ,  x2: &a) : void = let
  val tmp = x1 in x1 := x2; x2 := tmp end
  
  
// Swap1 implemented as swap2
(* Though the syntax seems confusing to me,the parameters being passed are the addresses of the pointers
rather than the locations the pointers point to in the call to swap2 *)
fn { a: t@ype}
swap1 {l1,l2: addr}
  (pf1: !a @ l1 , pf2: !a @ l2 |   p1: ptr l1 , p2:ptr l2) : void  = swap2(!p1,!p2)
  



(*
dotproduct:

Given a type T and an integer N, the syntax @[T][N] stands for a flat array consisting N elements of the type T.
Please note that a value of the type @[T][N] is of the size N*sizeof(T).  If a function has a parameter representing an array then this 
parameter is most likely call by reference.  For instance, the following code implements a function that takes two arrays of doubles
to compute their dot product 
*)

fun dotprod ( A: &(@[double][3])
            , B: &(@[double][3])):double = 
  (
    A[0] * B[0] + A[1] * B[1] + A[2] * B[2]
  )           
  


(* Stack-Allocated Variables
   Given a type T and an address L how do I get a *)


fn foo (): void = let
  var x0:int 
  val () = x0 := 0
  var x1: int = 1
  
  var y:int with pfy
  val () = y := 2
  var z: int with pfz = 3 // pfz is an alias of view@(z): int(3) @ z
  in end
  


  
(*
The keyword var is for declaring a local variable.
When a variable is declared, either its type or its initial value needs to be given. 

If a variable is declared without a type, then the type of its initial value 
is assumed to be its type.

Assume that a variable x is declared of type T.  Then the pointer to the location of the 
variable is denoted by addr@(x), where addr@ is a keyword, and its associated linear proof 
(of some at-view) can be referred to as view@(x), where view@ is a keyword.  

A variable is another form of left-value in ATS.  In the body of foo, x0 is declared to be a 
variable of type int and then is initialized with the integer 0.

x1 is declared to be a variable of the type int that is given the initial value 1;

y is declared to be a variable of type int while pfy is introduced as an alias for view@(y)
*)

fn fact {n:nat}
  (n: int(n)):int = let
  fun loop{n:nat}{l:addr} .<n>.
   (pf: !int @ l | n: int n, res: ptr l): void = 
     if n > 0 then let
       val () = !res := n * !res in loop(pf | n-1, res)
     end
   var res: int with pf = 1
   val () = loop(pf|n, addr@res)
   in res end


val example_dotProd = let
  var A = @[double][3](1.0) // [1,1,1]
  var B = @[double][3](1.0,2.0,3.0) //[1.0,2.0,3.0]
  
  val () = println! ("a * b = ", dotprod (A,B))
  in 
  end   