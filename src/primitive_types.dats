// Complete list of primitive types
// A lot of the functions to convert these types are defined in the sats portion 
// of the prelude
#include
"share/atspre_staload.hats"


// This type is for boolean values true and false, 
// and it is translated into the int type in C.
val boolType : bool = true

// This type is translated into the type in C 
// for characters.
val charType : char = 'a'

// This type is translated into the type in C 
// for signed characters.
var scharType : schar = char2schar0('b')

// This type is translated into the type in C 
// for unsigned characters.
var ucharType : uchar = char2uchar0('a')

// This type is translated into the type in C 
// for floating point numbers of single precision.
val floatType : float = g0float2float_double_float(3.0)

// This type is translated into the type in C for unsigned integers.
var uintType : uint = i2u(3)

// This type is translated into the type in C for long integers.
var lintType : lint = g0int2int_int_lint(2)

// This type is translated into the type in C 
// for unsigned long integers.
var ulintType : ulint = g0int2uint_int_ulint(3)

// This type is translated into the type in C for long long integers.
var llintType : llint = g0int2int_int_llint(4)

// This type is translated into the type in C for unsigned 
// long long integers.
var ullintType : ullint = g0int2uint_int_ullint(5)

// This type is translated into the type in C 
// of the same name, which is for unsigned 
// integers of certain precision. 
// Usually, the type size_t can be treated as 
// the type ulint and vice versa.
var sizeType : size_t = g0int2uint_int_size(3)

// This type is translated into the type in C 
// of the same name, which is for signed integers 
// of certain precision. Usually, the type ssize_t 
// can be treated as the type lint and vice versa.
var ssizeType : ssize_t = g0int2int_int_ssize(4)

// This type is translated into the type in C for short integers.
var sintType : sint = g0int2int_int_sint(5)

// This type is translated into the type in C 
// for unsigned short integers.
var usintType : usint = g0int2uint_int_usint(6)


// This type is for strings, and its translation in C 
// is the type for pointers. I will explain this translation elsewhere.
val stringType : string = "test"