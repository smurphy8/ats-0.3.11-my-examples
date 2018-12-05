#include 
"share/atspre_staload.hats"

staload "libats/SATS/bitvec.sats"


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




