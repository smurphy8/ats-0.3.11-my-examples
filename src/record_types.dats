#include
"share/atspre_staload.hats"



// A record is just like a tuple except that each field name of the record is chosen by the programmer
//  (instead of being fixed). Similarly, a record type is just like a tuple type. For instance, 
// a record type point2D is defined as follows: 



// Unboxed records are prefixed with `@`
typedef
point2d = @{ x= double, y=double}

// Construction
val theOrigin : point2d = @{ x= 0.0, y=0.0} 

// access 
val o_x : double = theOrigin.x and o_y : double = theOrigin.y

// pattern matching 
val @{x= matchedOnTheRight_X, ... } = theOrigin

val @{x= matchedOnTheRight_y, ... } = theOrigin

// Boxed records

typedef
point2dBoxed = '{ xb = double, yb = double}

// Construction 
val theOrigin' : point2dBoxed = '{ xb = 0.0, yb =0.0}  

// access 
val o_xb : double = theOrigin'.xb and o_yb : double = theOrigin'.yb 

// pattern matching 
val '{xb= matchedOnTheRight_Xb, ... } = theOrigin' 

val '{xb = matchedOnTheRight_yb , ... } = theOrigin' 
