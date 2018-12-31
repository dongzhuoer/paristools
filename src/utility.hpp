#pragma once
#include <Rcpp.h>
#include "../inst/include/paristools.hpp"

std::string get_strand(const unsigned flag);
Rcpp::List as_locs(const std::list<paristools::loc>& loc_list);






