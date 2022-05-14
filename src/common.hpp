#pragma once
#include <Rcpp.h>

namespace paristools {
    struct loc {
        std::string chrom {};
        std::string strand {};
        unsigned long start {};
        unsigned long end {};
    };
}
