// [[Rcpp::interfaces(r, cpp)]]

#include <Rcpp.h>
#include "common.hpp"
#include "utility.hpp"

using namespace Rcpp;
using Rcppzhuoer::paste;
using paristools::loc;


std::list<loc> parse_CIGAR(const std::string& chrom, unsigned flag, unsigned long pos, const std::string& CIGAR, unsigned long SEQ_len) {
    if (CIGAR.length() == 0L) return std::list<loc>{};

    unsigned long n {};
    char c {};
    unsigned long len_by_CIGAR {0};
    std::list<loc> loc_list {};
    for (std::istringstream isstream(CIGAR); ;) {
        isstream >> n ;
        isstream.get(c);
        // Rcout << "n = " << n << ", " << c << '\n';
        if (isstream.eof()) break;
        
        if (c == 'S' || c == 'I') {
            len_by_CIGAR += n;
        } else if (c == 'D' || c == 'N') {
            pos += n;
        } else if (c == 'M') {
            len_by_CIGAR += n;
            
            loc tmp {};
            tmp.chrom = chrom;
            tmp.strand = get_strand(flag);
            tmp.start = pos;
            pos += n;
            tmp.end = pos - 1;
            loc_list.emplace_back(std::move(tmp));
        }
    }
    
    if(SEQ_len != len_by_CIGAR) stop(paste("parse ", CIGAR, ": expected ", len_by_CIGAR, ", actual ", SEQ_len).c_str());
    return loc_list;
}

std::list<loc> parse_CIGAR(String chrom, unsigned flag, unsigned long pos, String CIGAR, unsigned long SEQ_len) {
    return parse_CIGAR(std::string{chrom}, flag, pos, std::string{CIGAR}, SEQ_len);
}

// [[Rcpp::export]]
List test_parse_CIGAR (String chrom, unsigned flag, unsigned long pos, String CIGAR, unsigned long SEQ_len) {
    std::list<loc> loc_list = parse_CIGAR(chrom, flag, pos, CIGAR, SEQ_len);
    return as_loc_df(loc_list);
}
/*** R
test_parse_CIGAR('neat1', 16, 123, '8M1S', 9)
*/


//' @title find all mapped region in a `.sam` data.frame
//' @name sam_to_loc_df
//' 
//' @param sam data.frame. see [read_sam()]
//' 
//' @return a tibble of 4 variables, `chrom`, `strand`, `start`, `end`
//' 
//' @examples
//' sam_file <- system.file('extdata', 'Neat1_1.Aligend_trunc.sam', package = 'paristools')
//' sam_file %>% read_sam() %>% sam_to_loc_df()
//' 
//' @export

// [[Rcpp::export]]
List sam_to_loc_df(DataFrame sam) {
    // const DataFrame & doesn't help, we have to carefully make sure not to modify `df`
    CharacterVector chrom = sam["RNAME"];
    IntegerVector   flag  = sam["FLAG"];
    IntegerVector   pos   = sam["POS"];
    CharacterVector CIGAR = sam["CIGAR"];
    CharacterVector SEQ   = sam["SEQ"];

    std::list<loc> loc_list {};
    for (decltype(chrom.size()) i {0}; i < chrom.size(); ++i) {
        if (i % 10000 == 0) Rcpp::checkUserInterrupt();
        String seq = SEQ[i];
        loc_list.splice(
            loc_list.cbegin(),
            parse_CIGAR(chrom[i], flag[i], pos[i], CIGAR[i], strlen(seq.get_cstring()))
        );
    }
    return as_loc_df(loc_list);
}
/*** R
sam <- system.file('extdata', 'Neat1_1.Aligend_trunc.sam', package = 'paristools') %>% paristools::read_sam();

sam_to_loc_df(head(sam))
sam %>% sam_to_loc_df()
library(tidyverse)

# 1. remove 2+ N
# 2. N < 3 ?
# 3. S < 0.2 len
sam %>% filter(str_detect(CIGAR, '0N')) 

sam %>% mutate(x = nchar(SEQ)) %>% ggplot() + geom_bar(aes(x))
*/
