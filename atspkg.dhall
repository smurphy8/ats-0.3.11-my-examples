    let prelude =
          https://hackage.haskell.org/package/ats-pkg/src/dhall/atspkg-prelude.dhall 

in  let bin =
          { bin =
              [   prelude.bin
                ⫽ { src =
                      "src/ats-0.3.11-my-examples.dats"
                  , target =
                      "${prelude.atsProject}/ats-0.3.11-my-examples"
                  }
              ]
          }

in  prelude.default ⫽ bin
