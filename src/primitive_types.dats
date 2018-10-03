// Complete list of primitive types
// A lot of the functions to convert these types are defined in the sats portion 
// of the prelude
#include
"share/atspre_staload.hats"



val boolType : bool = true
val charType : char = 'a'

var scharType : schar = char2schar0('b')

var ucharType : uchar = char2uchar0('a')

val floatType : float = g0float2float_double_float(3.0)

var usintType : uint = i2u(3)

val stringType : string = "test"