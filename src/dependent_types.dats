#include 
"share/atspre_staload.hats"
staload UN = "prelude/SATS/unsafe.sats"
staload "prelude/SATS/string.sats"
(*

Enhanced Expressiveness for Specification

The primary purpose of introducing dependent types into the type system of ATS is to greatly enhance the expressiveness of types so that they can be employed to capture program invariants with much greater precision. Generally speaking, dependent types are types dependent on values of expressions. For instance, bool is a type constructor in ATS that forms a type bool(b) when applied to a given boolean value b. As this type can only be assigned to a boolean expression of the value b, it is often referred to as a singleton type, that is, a type for exactly one value. Clearly, the meaning of bool(b) depends on the boolean value b. Similarly, int is a type constructor in ATS that forms a type int(i) when applied to a given integer i. This type is also a singleton type as it can only be assigned to an integer expression of the value i. Please note that both bool and int are overloaded as they also refer to (non-dependent) types. I will gradually introduce many other examples of dependent types. In particular, I will present a flexible means for the programmer to declare dependent datatypes.

The statics of ATS is a simply-typed language, and the types in this language are called sorts so as to avoid some potential confusion (with the types for dynamic terms). The following four listed sorts are commonly used:

    bool: for static terms of boolean values

    int: for static terms of integer values

    type: for static terms representing boxed types (for dynamic terms)

    t@ype: for static terms representing unboxed types (for dynamic terms) 

The sorts bool and int are classified as predicative sorts while the sorts type and t@ype are impredicative. A boxed type is a static term of the sort type while an unboxed type is a static term of the sort t@ype. As types, bool and int are static terms of the sort t@ype. As type constructors, bool and int are static terms of the sorts (bool -> t@ype) and (int -> t@ype), respectively. Also note that the type constructor list0 is of the sort (t@ype -> type), which indicates that list0 forms a boxed type when applied to an unboxed one. There are a variety of built-in static functions in ATS for constructing static terms of the sorts bool and int, and I list as follows some of these functions together with the sorts assigned to them: 




By combining a sort with one or more predicates, we can define a subset sort. For instance, the following subset sorts are defined in the file basics_pre.sats, which is automatically loaded by the ATS compiler: 
*)



sortdef nat = {a: int | a >=0}
sortdef pos = {a: int | a >=1}
sortdef neg = {a: int | a <= ~1}

sortdef nat1 = {a: nat | a <1} // 1


// Note that predicates can be sequenced together with the semicolon symbol (;) to form a conjunction:

sortdef nat2 = {a: nat | a > 1; a <3} // 2

// Or (||)  and And (&&) are usable in predicates 

sortdef natZeroOrOne = {a:int | a == 0 || a == 1} // 0,1 set

sortdef natTwoOrThree = {a:int | a > 1 && a < 4} // 2,3  


(*

In order to unleash the expressiveness of dependent types, 
we need to employ both universal and existential quantification 
over static variables. For instance, the type Int in ATS is defined as follows: 

*)


typedef Int = [a:int] int(a)

// where the syntax [a:int] means existential quantification over a static variable a of the sort int.

(*

Essentially, this means that for each value of the type Int, there exists an integer I such that the value is of the type int(I). 
Therefore, any value that can be given the type int can also be given the type Int. 
A type like Int is often referred to as an existentially quantified type. 

*)

typedef Nat = [a:int | a > 0] int(a)

(* alteratively:

typedef Nat = [a:nat] int(a)

*)

(*
Constraint-Solving during Typechecking

Typechecking in ATS involves generating and solving constraints. 
As an example, the code below implements the well-known factorial function:

*)


(*

WHY FACT WON'T WORK LIKE THIS

+ For each natural number n, n > 0 implies n - 1 >= 0
+ For each natural number n and each natural number r1, n > 0 implies n * r1>= 0
+ For each natural number n, 1 >= 0 holds. 

fun
fact{n:nat} ( x: int(n) ) : [r:nat] int(r) =
  if x > 0 then x * fact (x-1) else 1

*)



// String Processing Example:
typedef String = [n:nat] string(n)

(* This is a very useful illustration of how 
to cast and manipulate some of the proof terms.


*)
fun stringIsAtEnd  
   {n:int} {i:nat | i < n} 
   (str: string(n), i: size_t (i)): bool (i==n) = let    
   val pointerToBeginningOfString = string2ptr(str)
   val offsetBy_i = add_ptr_bsz(pointerToBeginningOfString, i)
   val string_term_null = '\000'
   in $UN.cast{bool(n==i)}($UN.ptr1_get<char>(offsetBy_i) = 
      string_term_null)
end
   
   
val test = stringIsAtEnd("here", g1int2uint(3))