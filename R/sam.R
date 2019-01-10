# common import
NULL



#' @title read `.sam` file
#' 
#' @inheritParams read_duplexgroup
#' 
#' @return a tibble of 11 variables
#' 
#' @description 
#' Read `.sam` file, only preserve 11 mandatory fields
#' 
#' @examples 
#' sam_file <- system.file('extdata', 'Neat1_1.Aligend_trunc.sam', package = 'paristools')
#' read_sam(sam_file)
#' 
#' @details 
#' Since `.sam` file can cantain arbitrary columns after the required 11, and it doesn't contain a header line, I find it hard to use [readr::read_tsv()]. Finally, I use [stringr::str_split_fixed()] to split the file into 12 columns, the last one which stored extra fields is discarded.
#' 
#' @export

# path = 'inst/extdata/Neat1_1.Aligend_trunc.sam'
read_sam <- function(file) {
    col_names <- c('QNAME', 'FLAG', 'RNAME', 'POS', 'MAPQ', 'CIGAR', 'RNEXT', 'PNEXT', 'TLEN', 'SEQ', 'QUAL')
    n_col <- length(col_names)

    lines <- file %>% readr::read_lines() %>% stringr::str_subset('^[^@]')
    mat <- stringr::str_split_fixed(lines, stringr::fixed('\t'), n_col + 1)
    mat_core <- mat[ , seq_len(n_col)]           # select mandatory fields

    mat_core %>% tibble::as_tibble() %>% 
        rlang::set_names(col_names) %>% 
        dplyr::mutate_at(c(2, 4, 5, 8, 9), as.integer)
}

#' @title read `.sam` file
#' 
#' @inheritParams read_duplexgroup
#' @param ... passed on to [readr::read_tsv()]
#' 
#' @return a tibble of 6 variables
#' 
#' @examples 
#' NULL
#' 
#' @export

read_bed <- function(file, ...) {
    readr::read_tsv(
        file,
        c('chrom', 'start', 'end', 'name', 'score', 'strand'), 'ciicic', ...
    )
}


