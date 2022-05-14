# Overview

Utility for working with PARIS data



# Installation

```r
if (!('remotes' %in% .packages(T))) install.packages('remotes');
remotes::install_github('dongzhuoer/paristools');
```



# For developers

1. TO DO: implement `get_dg_coverage()` in C++, currently, we only run ~1000 DG, so I just use (very slow) R code.
