// [[Rcpp::plugins(cpp17)]]
// [[Rcpp::interfaces(r, cpp)]]

#include <Rcpp.h>
#include "common.hpp"

using namespace Rcpp;
using paristools::loc;



// [[Rcpp::export]]
std::string get_strand(const unsigned flag) {
    const unsigned strand_bit {16u};
    
    if (flag ^ strand_bit) 
        return "+";
    else 
        return "-";    
}




List as_locs(const std::list<loc>& loc_list) {
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

    List locs = List::create(chrom, strand, start, end);
    locs.attr("names") = CharacterVector::create("chrom", "strand", "start", "end");
    return Rcppzhuoer::as_tibble(locs);
}

// [[Rcpp::export]]
List test_as_locs() {
    std::list<loc> loc_list {{"neat1", "+", 1, 100}, {"neat1", "-", 17, 49}};
    Rcout << "ignore 2 copy loc above" << std::endl;
    
    return as_locs(loc_list);
}











// [[Rcpp::export]]
int cpp_version() {
    return __cplusplus;
}
/*** R
cpp_version()
*/





/*** R
# system.file('extdata', 'Neat1_1.Aligend_trunc.sam', package = 'paristools') %>% paristools::read_sam() %>% coverage()
*/

/*** R
*/
