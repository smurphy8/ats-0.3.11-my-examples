(* 
List of sorts 

https://github.com/githwxi/ATS-Postiats/wiki/sort
*)

#include "share/atspre_staload.hats"



(* 



Sorts I have found in prelude...

./contrib/atscntrb/atscntrb-hx-mytesting/SATS/randgen.sats  sortdef
./src/pats_reader.sats                                      sortdef
./src/pats_lexing.sats                                      | T_SORTDEF of () // sortdef
./libats/libc/SATS/stdio.sats                               sortdef fm = file_mode
./libats/ML/SATS/matrix0.sats                               sortdef
./libats/ML/SATS/array0.sats                                sortdef t0p = t@ype
./libats/ML/SATS/array0.sats                                sortdef vt0p = viewt@ype
./libats/SATS/gmatrix.sats                                  sortdef mord = int
./libats/SATS/gmatrix.sats                                  sortdef uplo = int
./libats/SATS/gmatrix.sats                                  sortdef diag = int
./libats/SATS/gmatrix.sats                                  sortdef side = int
./libats/SATS/gnode.sats                                    sortdef tk = tkind
./libats/SATS/gnode.sats                                    sortdef t0p = t@ype and vt0p = vt@ype
./prelude/basics_dyn.sats                                   sortdef t0p = t@ype and vt0p = vt@ype
./prelude/basics_dyn.sats                                   sortdef fmode = file_mode
./prelude/basics_sta.sats                                   sortdef int8 = {
./prelude/basics_sta.sats                                   sortdef uint8 =
./prelude/basics_sta.sats                                   sortdef tk = tkind
./prelude/basics_pre.sats                                   sortdef nat = { i:int | i >= 0 }
./prelude/basics_pre.sats                                   sortdef nat1 = { n:nat | n < 1 } // for 0
./prelude/basics_pre.sats                                   sortdef nat2 = { n:nat | n < 2 } // for 0, 1
./prelude/basics_pre.sats                                   sortdef nat3 = { n:nat | n < 3 } // for 0, 1, 2
./prelude/basics_pre.sats                                   sortdef nat4 = { n:nat | n < 4 } // for 0, 1, 2, 3
./prelude/basics_pre.sats                                   sortdef pos = { i:int | i >  0 } // positive ints
./prelude/basics_pre.sats                                   sortdef neg = { i:int | i <  0 } // negative ints
./prelude/basics_pre.sats                                   sortdef npos = { i:int | i <= 0 } // non-positive ints
./prelude/basics_pre.sats                                   sortdef nneg = { i:int | i >= 0 } // non-negative ints
./prelude/basics_pre.sats                                   sortdef sgn = { i:int | ~1 <= i; i <= 1 }
./prelude/basics_pre.sats                                   sortdef igz = { i:int | i > 0 }
./prelude/basics_pre.sats                                   sortdef igez = { i:int | i >= 0 }
./prelude/basics_pre.sats                                   sortdef ilez = { i:int | i <= 0 }
./prelude/basics_pre.sats                                   sortdef agz = { l:addr | l > null }
./prelude/basics_pre.sats                                   sortdef agez = { l:addr | l >= null }
./prelude/basics_pre.sats                                   sortdef alez = { l:addr | l <= null }
./prelude/SATS/gnumber.sats                                 sortdef tk = tkind
./prelude/SATS/stream.sats                                  sortdef t0p = t@ype
./prelude/SATS/matrixptr.sats                               sortdef t0p = t@ype and vt0p = viewt@ype
./prelude/SATS/char.sats                                    sortdef tk = tkind
./prelude/SATS/pointer.sats                                 sortdef tk = tkind
./prelude/SATS/pointer.sats                                 sortdef
./prelude/SATS/extern.sats                                  sortdef vt0p = viewt@ype
./prelude/SATS/unsafe.sats                                  sortdef t0p = t@ype and vt0p = viewt@ype
./prelude/SATS/matrix.sats                                  sortdef t0p = t@ype
./prelude/SATS/matrix.sats                                  sortdef vtp = viewtype
./prelude/SATS/matrix.sats                                  sortdef vt0p = viewt@ype
./prelude/SATS/integer_short.sats                           sortdef tk = tkind
./prelude/SATS/parray.sats                                  sortdef vtp = viewtype
./prelude/SATS/integer_fixed.sats                           sortdef tk = tkind
./prelude/SATS/integer_ptr.sats                             sortdef tk = tkind
./prelude/SATS/filebas.sats                                 sortdef t0p = t@ype and vt0p = viewt@ype
./prelude/SATS/matrixref.sats                               sortdef tk = tkind
./prelude/SATS/matrixref.sats                               sortdef t0p = t@ype and vt0p = viewt@ype
./prelude/SATS/arrayref.sats                                sortdef tk = tkind
./prelude/SATS/arrayref.sats                                sortdef t0p = t@ype and vt0p = viewt@ype
./prelude/SATS/array.sats                                   sortdef t0p = t@ype
./prelude/SATS/array.sats                                   sortdef vtp = viewtype
./prelude/SATS/array.sats                                   sortdef vt0p = viewt@ype
./prelude/SATS/integer_size.sats                            sortdef tk = tkind
./prelude/SATS/gprint.sats                                  sortdef t0p = t@ype
./prelude/SATS/option_vt.sats                               sortdef vt0p = viewt@ype
./prelude/SATS/option.sats                                  sortdef t0p = t@ype
./prelude/SATS/integer_long.sats                            sortdef tk = tkind
./prelude/SATS/checkast.sats                                sortdef t0p = t@ype and vt0p = viewt@ype
./prelude/SATS/tuple.sats                                   sortdef t0p = t@ype and vt0p = viewt@ype
./prelude/SATS/arrayptr.sats                                sortdef t0p = t@ype and vt0p = viewt@ype
./prelude/SATS/tostring.sats                                sortdef t0p = t@ype
./prelude/SATS/tostring.sats                                sortdef vt0p = vt@ype
./prelude/SATS/array_prf.sats                               sortdef t0p = t@ype and vt0p = viewt@ype
./prelude/SATS/string.sats                                  sortdef tk = tkind
./prelude/SATS/stream_vt.sats                               sortdef
./prelude/SATS/integer.sats                                 sortdef tk = tkind
./prelude/SATS/reference.sats                               sortdef t0p = t@ype and vt0p = viewt@ype  

*)

staload "contrib/atscntrb/atscntrb-hx-mytesting/SATS/randgen.sats"  
staload "libats/libc/SATS/stdio.sats"                               
staload "libats/ML/SATS/matrix0.sats"                               
staload "libats/ML/SATS/array0.sats"                                
staload "libats/ML/SATS/array0.sats"                                
staload "libats/SATS/gmatrix.sats"                                  
staload "libats/SATS/gmatrix.sats"                                  
staload "libats/SATS/gmatrix.sats"                                  
staload "libats/SATS/gmatrix.sats"                                  
staload "libats/SATS/gnode.sats"                                    
staload "libats/SATS/gnode.sats"                                    
staload "prelude/basics_sta.sats"                                   
staload "prelude/basics_sta.sats"                                   
staload "prelude/basics_sta.sats"                                   
staload "prelude/basics_pre.sats"                                   
staload "prelude/basics_pre.sats"                                   
staload "prelude/basics_pre.sats"                                   
staload "prelude/basics_pre.sats"                                   
staload "prelude/basics_pre.sats"                                   
staload "prelude/basics_pre.sats"                                   
staload "prelude/basics_pre.sats"                                   
staload "prelude/basics_pre.sats"                                   
staload "prelude/basics_pre.sats"                                   
staload "prelude/basics_pre.sats"                                   
staload "prelude/basics_pre.sats"                                   
staload "prelude/basics_pre.sats"                                   
staload "prelude/basics_pre.sats"                                   
staload "prelude/basics_pre.sats"                                   
staload "prelude/basics_pre.sats"                                   
staload "prelude/basics_pre.sats"                                   
staload "prelude/SATS/gnumber.sats"                                 
staload "prelude/SATS/stream.sats"                                  
staload "prelude/SATS/matrixptr.sats"                               
staload "prelude/SATS/char.sats"                                    
staload "prelude/SATS/pointer.sats"                                 
staload "prelude/SATS/pointer.sats"                                 
staload "prelude/SATS/extern.sats"                                  
staload "prelude/SATS/unsafe.sats"                                  
staload "prelude/SATS/matrix.sats"                                  
staload "prelude/SATS/matrix.sats"                                  
staload "prelude/SATS/matrix.sats"                                  
staload "prelude/SATS/integer_short.sats"                           
staload "prelude/SATS/parray.sats"                                  
staload "prelude/SATS/integer_fixed.sats"                           
staload "prelude/SATS/integer_ptr.sats"                             
staload "prelude/SATS/filebas.sats"                                 
staload "prelude/SATS/matrixref.sats"                               
staload "prelude/SATS/matrixref.sats"                               
staload "prelude/SATS/arrayref.sats"                                
staload "prelude/SATS/arrayref.sats"                                
staload "prelude/SATS/array.sats"                                   
staload "prelude/SATS/array.sats"                                   
staload "prelude/SATS/array.sats"                                   
staload "prelude/SATS/integer_size.sats"                            
staload "prelude/SATS/gprint.sats"                                  
staload "prelude/SATS/option_vt.sats"                               
staload "prelude/SATS/option.sats"                                  
staload "prelude/SATS/integer_long.sats"                            
staload "prelude/SATS/checkast.sats"                                
staload "prelude/SATS/tuple.sats"                                   
staload "prelude/SATS/arrayptr.sats"                                
staload "prelude/SATS/tostring.sats"                                
staload "prelude/SATS/tostring.sats"                                
staload "prelude/SATS/array_prf.sats"                               
staload "prelude/SATS/string.sats"                                  
staload "prelude/SATS/stream_vt.sats"                               
staload "prelude/SATS/integer.sats"                                 
staload "prelude/SATS/reference.sats"
(*


ssssssssss
s        s
s SORTS  s
s        s
ssssssssss

*)





sortdef ex0 = t0p
sortdef ex1 = vt0p
sortdef ex2 = fm
sortdef ex3 = mord
sortdef ex4 = uplo
sortdef ex5 = diag
sortdef ex6 = side
sortdef ex7 = tk
sortdef ex8 = fmode
sortdef ex9 = int8
sortdef ex10 = uint8
sortdef ex11 = nat
sortdef ex12 = nat1
sortdef ex13 = nat2
sortdef ex14 = nat3
sortdef ex15 = nat4
sortdef ex16 = pos
sortdef ex17 = neg
sortdef ex18 = npos
sortdef ex19 = nneg
sortdef ex20 = sgn
sortdef ex21 = igz
sortdef ex22 = igez
sortdef ex23 = ilez
sortdef ex24 = agz
sortdef ex25 = agez
sortdef ex26 = alez
sortdef ex27 = addr
sortdef ex28 = viewt@ype
sortdef ex29 = tkind
sortdef ex30 = int
sortdef ex31 = bool
