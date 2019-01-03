# paristools
[![Build Status](https://travis-ci.com/dongzhuoer/paristools.svg?branch=master)](https://travis-ci.com/dongzhuoer/paristools)


## Overview

Utility for working with PARIS data




## Installation

```r
if (!('remotes' %in% .packages(T))) install.packages('remotes');
remotes::install_github('dongzhuoer/paristools');
```

## Usage

refer to `vignette('paristools')`.

## to do:

1. test-cpp-export locs_to_coverage_impl()
1. test-cpp-export sam_to_locs()



## Rcpp issue

1. this package can't be depended by standalone file

```
// [[Rcpp::depends(paristools)]]
#include <paristools.h>
```

cause

```
In file included from /home/zhuoer/.local/lib/R/paristools/include/paristools.h:7:
/home/zhuoer/.local/lib/R/paristools/include/paristools.hpp:4:10: fatal error: 'Rcppzhuoer.h' file not found
#include <Rcppzhuoer.h>
         ^~~~~~~~~~~~~~
```

2. pure C++ function can't be exported

`List as_locs(const std::list<loc>& loc_list);`

3. in fact, the above two is quite related. We want to export `paristools.hpp` for defination of custom struct, `loc`. But if we don't export functions like `as_locs()` at all, then we won't need to export anything in header file. (That's only true for this package, exporting a header file which depends on another package is still impossible, and may be needed.)

4. find why you can't testthat cpp export

Thanks for `verbose = T`, I find the code doesn't include `#include <paristools.h>` ^[later I find Rcpp can't find the file, so it doesn't include]. After set `includes` parameter, still fail. Thanks for `cacheDir = 'tests/testthat'`, I can get the temp `.cpp` file, and directly run `clang++` command. Finally, I found the cause.

Rcpp use `find.package()` to determine package path, when you use testthat 
`find.package('pkg')` return the project dir (in normal session, it return package in the library, `.local/lib/R/pkg`). The reason is that `find.package()` looks for loaded namesace first, and testthat load pkg namespace from the the project dir. Finally, I use `callr::r()` to avoid the problem.

## develop

1. Refer to this [post](https://dongzhuoer.github.io/_redirects/develop-upon-my-r-package.html)


```r


```

