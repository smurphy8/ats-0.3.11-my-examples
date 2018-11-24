#include
"share/atspre_staload.hats"

staload "prelude/DATS/integer.dats"
// The keyword fn initiates the definition of a non-recursive function, 
// and the name following it is for the function to be defined.

fn square (x:int):int = x * x


val square_with_lam = lam (x : double) : double => x * x
         
// Function Arity 

(* 
The term arity denotes how many inputs a function has 
Functions of 0,1,2,3 are described as 
+ nullary
+ unary
+ binary
+ ternary 

*)         


// typedef used below binds a synonym for the type
typedef int2 = (int,int)


// Interface Only definition
extern
fun gt_int_int (x: int, y: int): bool // >


// Recursive Functions
fun fib (n:int) :int = case n of
  | 0 => 0
  | 1 => 1
  | x =>  fib(x-1) + fib(x-2)


// Printer
val _ = print (fib(7))  