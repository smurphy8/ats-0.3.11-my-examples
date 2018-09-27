{ bin =
    [ { src =
          "src/ats-0.3.11-my-examples.dats"
      , target =
          "target/ats-0.3.11-my-examples"
      , gcBin =
          False
      , libs =
          [] : List Text
      , hsDeps =
          [] : List
               { projectFile :
                   Optional Text
               , cabalFile :
                   Text
               , objectFile :
                   Text
               }
      , hs2ats =
          [] : List { hs : Text, ats : Text, cpphs : Bool }
      , extras =
          [] : List Text
      }
    ]
, test =
    [] : List
         { src :
             Text
         , target :
             Text
         , libs :
             List Text
         , hsDeps :
             List
             { projectFile :
                 Optional Text
             , cabalFile :
                 Text
             , objectFile :
                 Text
             }
         , hs2ats :
             List { hs : Text, ats : Text, cpphs : Bool }
         , gcBin :
             Bool
         , extras :
             List Text
         }
, libraries =
    [] : List
         { name :
             Text
         , src :
             List Text
         , libTarget :
             Text
         , libs :
             List Text
         , includes :
             List Text
         , hsDeps :
             List
             { projectFile :
                 Optional Text
             , cabalFile :
                 Text
             , objectFile :
                 Text
             }
         , links :
             List { _1 : Text, _2 : Text }
         , hs2ats :
             List { hs : Text, ats : Text, cpphs : Bool }
         , extras :
             List Text
         , static :
             Bool
         }
, man =
    [] : Optional Text
, completions =
    [] : Optional Text
, version =
    [ 0, 3, 11 ]
, compiler =
    [ 0, 3, 11 ]
, dependencies =
    [] : List
         { _1 :
             Text
         , _2 :
             { lower :
                 Optional (List Natural)
             , upper :
                 Optional (List Natural)
             }
         }
, clib =
    [] : List
         { _1 :
             Text
         , _2 :
             { lower :
                 Optional (List Natural)
             , upper :
                 Optional (List Natural)
             }
         }
, buildDeps =
    [] : List
         { _1 :
             Text
         , _2 :
             { lower :
                 Optional (List Natural)
             , upper :
                 Optional (List Natural)
             }
         }
, ccompiler =
    "gcc"
, cflags =
    [ "-O2" ]
, atsFlags =
    [] : List Text
, atsSource =
    [] : List
         { atsSrc :
             Text
         , cTarget :
             Text
         , atsGen :
             List { hs : Text, ats : Text, cpphs : Bool }
         , extras :
             List Text
         }
, dynLink =
    True
, extSolve =
    < PatsSolve = {=} | Z3 : {} | Ignore : {} >
, debPkg =
    [] : Optional
         { package :
             Text
         , version :
             List Natural
         , maintainer :
             Text
         , description :
             Text
         , target :
             Text
         , manpage :
             Optional Text
         , binaries :
             List Text
         , libraries :
             List Text
         , headers :
             List Text
         }
, atsLib =
    True
}
