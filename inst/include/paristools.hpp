#pragma once
#include <Rcpp.h>
// [[Rcpp::depends(Rcppzhuoer)]]
#include <Rcppzhuoer.h>

namespace paristools {
    struct loc {
        std::string chrom {};
        std::string strand {};
        unsigned long start {};
        unsigned long end {};
        Rcppzhuoer::foo<void> foo {}; // comment me in release
    };
}
