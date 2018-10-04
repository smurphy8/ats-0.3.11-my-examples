#include
"share/atspre_staload.hats"

// Each binding is given a fixed scope in which the binding is considered legal or effective. 
// The scope of a toplevel binding in a file starts from the point where the binding is introduced until the very end of the file. 
// The bindings introduced in the following example between the keywords let and in are effective until the keyword end is reached


// Let bindings
val area = let 
  val PI = 3.14159 and radius = 10.0 
  in PI * radius * radius 
  end 
  
// Where bindings

val areaWhere = 
  PI * radius * radius where {
  val PI = 3.14159 and radius = 10.0
  }
  
// Local bindings 
// The difference between let and local should be clear: 
// The former is used to form an expression while the latter is used to introduce a sequence of declarations. 

local 

val PI = 3.14159 and radius = 10.0 

in

val areaLocal = PI * radius * radius

end

  