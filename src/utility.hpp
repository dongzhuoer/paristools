#pragma once
#include <Rcpp.h>
#include "../inst/include/paristools.hpp"

std::string get_strand(const unsigned flag);
Rcpp::List as_loc_df(const std::list<paristools::loc>& loc_list);
Rcpp::List cal_coverage_impl(Rcpp::DataFrame loc_df);





