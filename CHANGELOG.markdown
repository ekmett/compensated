0.7.2
-----
* Add a library dependency on the `doctests` test suite

0.7.1
-----
* Revamp `Setup.hs` to use `cabal-doctest`. This makes it build
  with `Cabal-2.0`, and makes the `doctest`s work with `cabal new-build` and
  sandboxes.

0.7
---
* Support for newer `bifunctors`, `cereal`, `deepseq`, `generic-deriving`, `semigroupoid` and `vector` dependencies.`

0.6
---
* Updated for `lens` 4.
* Bug fix in `(/=)`

0.4.1
-----
* Marked this package `Trustworthy`.

0.4
---
* Added `NFData` and `Serial` instances

0.3
---
* Major version bump due to large semantics change in `log-domain`.

0.2.0.1
-------
* Wider `generic-deriving` version bounds for GHC HEAD compatibility.

0.2
---
* Added a `Hashable` instance.

0.1.1.1
-------
* Wider `binary` version bounds.

0.1.1
-----
* Fixed a bug in the `Setup.lhs` `postHaddock` hook.
* Reformatted haddocks

0.1
---
* Split from [analytics](https://github.com/analytics/analytics)
