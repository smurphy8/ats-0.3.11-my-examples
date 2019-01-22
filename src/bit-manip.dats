#include 
"share/atspre_staload.hats"

staload "libats/SATS/bitvec.sats"

staload _(*anon*) = "libats/DATS/bitvec.dats"



(* A quick example of accessing and using a bit vector *)


val _ = let
#define nbit 16
val out = stdout_ref
val bvp1 = bitvecptr_make_full (nbit)
val () = fprint (out, "bvp1 = ")
val () = fprint_bitvecptr (out, bvp1, nbit)
val () = fprint (out, "\n")
val () = bitvecptr_free (bvp1) 

in end

// sortdef iovec = {b0:int | b0 <2} {b1:int | b1 <2}

(* 

First attempt at constructing a safe `bitWrite` function. 

Members:

*DataDirectionRegisterN : Data Direction Register N whose length matches the size of the pointer
DataDirectionRegisterBitVectorN : Bit vector for data direction register N
*PortN : The Data port (Pointer) that will be written
i : The bit index that will be written in the port
j : The bit index for the Bit vector

val : The binary value written to the Port

Properties:

1. i = j
2. Some proof that DataDirectionRegisterBitVectorN @ * DataDirectionRegisterN
3. Some proof that DataDirectionRegisterBitVectorN[j] = 1
4. Some proof that *PortN and DDRN are tied together 

*)





val _ = println!("hello from bit-manip.dats")
val _ = let val i = i2u(2) 
        in i 
        end
val _ = println!("goodbye from bit-manip.dats")







(*  
--------------------------------------------------
Data Direction Mockup stuff
--------------------------------------------------

Below are functions mimicing the proof terms needed 
for a data direction register 

a data direction registers says whether something is writeable or not
by assigning a 1 or a zero to a value then that value corresponds to a port
that can then be read or written to.

For instance to write to PortB pin 0 
isSet(0,DDRB) Should be true
 
*)



datatype bit_status =
  | set of () | unset of ()

sortdef bit = {n:nat | n <2}





dataprop IsWriteableDummy(int,int,bool) = 
  | {i,j:int} WriteableDummy(i,j,true) of ()
  | {i,j:int} NotWriteableDummy(i,j,false) of ()




sortdef bit = {b:int| b <2 && b >= 0}
typedef Bit = [b:bit] int(b)


typedef twoBitVector = @(bool,bool)


// Dummy Set bit vector function as an example
// extern  
// fn setBitVector (i:int) : void


(* Dummy bit vector function *) 
fn getBitVectorDummy {i,j:int}  (bv:int(j)) : [b:bool] (IsWriteableDummy(i,j,b) | bool(b)) = 
  if bv > 3 then   
  (WriteableDummy() | true)
  else
  (NotWriteableDummy() | false)

 
(* This function contains a lot of important ideas
there is a proof term we wrote by hand (IsWriteableDummy)
*)
fn setBitVectorWithProof {i,j:int} {w:bool} (pf:IsWriteableDummy(i,j,w) | b:int(j)) : 
   [t:bool | t== true] (IsWriteableDummy(i,j,t) | void)  = 
   if b > 3 then
     (WriteableDummy() |())
   else
     let val b = () // setBitVector(b);
     in
     (WriteableDummy() | ())
     end



(* Obviously this isn't really doing anything *)
fn writeBitVectorWithProofDummy {i,j:int} (pf:IsWriteableDummy(i,j,true) | b:int(j)) : void =  ()
  

  

val _ = let 
            val i         = 2
            val (pf  | _) = getBitVectorDummy(i) 
            val (pfW | _) = setBitVectorWithProof(pf|i)            
        in writeBitVectorWithProofDummy(pfW|i)
        end
  








(*  
--------------------------------------------------
Data Direction Mockup stuff
--------------------------------------------------

Okay now lets try it for real

with viewtypes and everything!

The first thing, we want to transform the dataprop into a
dataviewprop.

a data direction registers says whether something is writeable or not
by assigning a 1 or a zero to a value then that value corresponds to a port
that can then be read or written to.

For instance to write to PortB pin 0 
isSet(0,DDRB) Should be true
 
*)

datavtype is_writeable_ptr(i:int,l:addr,bool) = 
  | Writeable (i,l,true) of (bitvecptr(l,16))
  | NotWriteable (i,l,false) of (bitvecptr(l,16))

vtypedef IsWriteable(i:int,t:bool) = [l:addr] is_writeable_ptr(i,l,t)

