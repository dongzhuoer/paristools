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

## develop

1. Refer to this [post](https://dongzhuoer.github.io/_redirects/develop-upon-my-r-package.html)


```r


```

