// Given two types T1 and T2, we can form a tuple type (T1, T2), which can also be written as @(T1, T2). 
// Assume that exp1 and exp2 are two expressions of the types T1 and T2, respectively. 
// Then the expression (exp1, exp2), which can also be written as @(exp1, exp2), 
// refers to a tuple of the tuple type (T1, T2). 
// Accordingly, we can form tuples and tuple types of more components. 
// In order for a tuple type to be assigned to a tuple, the tuple and the tuple type must have the equal number of components. 

#include
"share/atspre_staload.hats"


// Unboxed Tuples are the default!
// Construction
val xyz : (char, int, double)  = ('A', 1, 2.0)

// Access
val x : char = xyz.0 and y : int  = xyz.1 and z : double = xyz.2

// Pattern matching
val (x':char,y',z'): (char, int, double) = xyz


//Boxed Tuples (size of a pointer)

// The type of a Boxed tuple matches its construction (with the single quote)
val anotherXYZ : '(char,int,double) = '('A',1,2.0)

// access mimic 
val xBoxed = anotherXYZ.0

// pattern matches type and construction (with the single quote)
val '(xB,yB,zB) = anotherXYZ