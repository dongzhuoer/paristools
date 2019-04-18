#pragma once
#include <Rcpp.h>
#include "../inst/include/paristools.hpp"

std::list<paristools::loc> parse_CIGAR(const std::string& chrom, unsigned flag, unsigned long pos, const std::string& CIGAR);
std::list<paristools::loc> parse_CIGAR(Rcpp::String chrom, unsigned flag, unsigned long pos, Rcpp::String CIGAR)

Rcpp::List sam_to_loc_df(Rcpp::DataFrame sam);





