(*

Chapter 15. Dataviewtypes as Linear Datatypes

A dataviewtype can be thought of as a linear version of datatype. To a large extent, it is a combination of a datatype and a dataview. This programming feature is primarily introduced into ATS for the purpose of providing in the setting of manual memory management the kind of convenience brought by pattern matching. In a situation where GC must be reduced or even completely eliminated, dataviewtypes can often be chosen as a replacement for datatypes. I now present in this chapter some commonly encountered dataviewtypes and their uses. 


*)
#include "share/atspre_staload.hats"
staload UN  = "prelude/SATS/unsafe.sats"
staload _  = "prelude/DATS/unsafe.dats"


// TODO implement data-view