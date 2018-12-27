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

## develop

1. Refer to this [post](https://dongzhuoer.github.io/_redirects/develop-upon-my-r-package.html)


```r
microbenchmark::microbenchmark(
    times = 10L,
    read_duplexgroup = paristools::read_duplexgroup('inst/extdata/Neat1_1.duplexgroup'),
    read_duplexgroup2 = paristools::read_duplexgroup2('inst/extdata/Neat1_1.duplexgroup')
)
bench::system_time(
    paristools::read_duplexgroup('inst/extdata/Neat1_1.duplexgroup')
)

bench::mark(
    paristools::read_duplexgroup2('inst/extdata/Neat1_1.duplexgroup')
)

```

