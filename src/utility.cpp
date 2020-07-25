// [[Rcpp::interfaces(r, cpp)]]

#include <Rcpp.h>
#include "common.hpp"

using namespace Rcpp;
using paristools::loc;


// get strand information from SAM's FLAG field

// [[Rcpp::export]]
std::string get_strand(const unsigned flag) {
    const unsigned strand_bit {16u};
    
    if (flag & strand_bit) 
        return "-";
    else 
        return "+";    
}



// help sam_to_loc_df to convert internal C++ structure to tibble 
List as_loc_df(const std::list<loc>& loc_list) {
    unsigned n = loc_list.size();
    CharacterVector chrom(n); 
    CharacterVector strand(n);
    IntegerVector start(n);
    IntegerVector end(n);
    
    unsigned i {0u};
    for (auto i_loc = loc_list.begin(); i_loc != loc_list.end(); ++i_loc) {
        chrom[i]  = i_loc->chrom;
        strand[i] = i_loc->strand;
        start[i]  = i_loc->start;
        end[i]    = i_loc->end;
        ++i;
    }

    List loc_df = List::create(chrom, strand, start, end);
    loc_df.attr("names") = CharacterVector::create("chrom", "strand", "start", "end");
    return Rcppzhuoer::as_tibble(loc_df);
}

// [[Rcpp::export]]
List test_as_loc_df() {
    std::list<loc> loc_list {{"neat1", "+", 1, 100}, {"neat1", "-", 17, 49}};
    
    return as_loc_df(loc_list);
}



//' @title calculate genome coverage for one chromosome
//' @name cal_coverage_impl
//' 
//' @details we use 1-based coordinate, [start, end]
//' 
//' @param chrom_loc_df data.frame. Locations on one chromosome, columns are `strand`, `start`, `end`. There must be at least one region of minimum length 1.
//' 
//' @return tibble. Columns are `pos`, `+`, `-`, the latter two are integers representing the genome, index is 1-based genome position, value is number of reads covering that position.
//' 
//' @keywords internal

// [[Rcpp::export]]
List cal_coverage_impl(DataFrame chrom_loc_df) {
    CharacterVector strand = chrom_loc_df["strand"];
    IntegerVector   start  = chrom_loc_df["start"];
    IntegerVector   end    = chrom_loc_df["end"];
    // here we use vector to represent the genome e.g., vec[4] store reads coverage at 5th base
    // for a large genome, when only a minority bases are covered, 
    //    we may need to consider map to save memory (at the sacrifice of time)
    decltype(end[0]) genom_len = *std::max_element(end.begin(), end.end());

    std::map<String, IntegerVector> n_reads = {};
    n_reads["+"] = IntegerVector(genom_len);
    n_reads["-"] = IntegerVector(genom_len);

    for (decltype(start.size()) i = {0u}; i < start.size(); ++i) 
        for (decltype(end[0]) j = start[i]; j <= end[i]; ++j)
            n_reads[strand[i]][j - 1] +=1;

    List result = List::create(seq_len(genom_len), n_reads["+"], n_reads["-"]);
    result.attr("names") = CharacterVector::create("pos", "+", "-");
    return Rcppzhuoer::as_tibble(result);
}



// [[Rcpp::export]]
int cpp_version() {
    return __cplusplus;
}



