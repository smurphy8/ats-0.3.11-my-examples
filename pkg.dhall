let prelude = https://hackage.haskell.org/package/ats-pkg/src/dhall/atspkg-prelude.dhall

in λ(x : List Natural) →
  prelude.makePkg { x = x, name = "ats-0.3.11-my-examples", githubUsername = "smurphy8" }
