let prelude = https://hackage.haskell.org/package/ats-pkg/src/dhall/atspkg-prelude.dhall

in prelude.default ⫽
  { bin =
    [ prelude.bin ⫽
      { src = "src/ats-0.3.11-my-examples.dats"
      , target = "${prelude.atsProject}/ats-0.3.11-my-examples"
      }
    ]
  }
