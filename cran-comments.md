## Test environments
* local OS X install, R 3.4.0
* ubuntu 12.04 (on travis-ci), R 3.4.0
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

## Reverse dependencies

This is a new release, so there are no reverse dependencies.

---

* This is a new release
* There is one note "no visible binding for global variable" which pertains to the implementation of a dplyr function within one of the package's functions. As far as I can tell, this is a false positive and does not affect the functioning of the package.
  

