testthat::context('Testing read-sam.R')
if (basename(getwd()) == 'testthat') setwd('../..')  # workspace is reset per file

testthat::test_that('read_sam()', {
    sam <- read_sam('inst/extdata/Neat1_1.Aligend_trunc.sam')
    
    testthat::expect_true(tibble::is_tibble(sam))
    testthat::expect_identical(dim(sam), c(4996L, 11L))
    testthat::expect_identical(
        colnames(sam), 
        c('QNAME', 'FLAG', 'RNAME', 'POS', 'MAPQ', 'CIGAR', 'RNEXT', 'PNEXT', 'TLEN', 'SEQ', 'QUAL')
    )
    testthat::expect_identical(
        purrr::map_chr(sam, typeof) %>% purrr::set_names(NULL), 
        c("character", "integer", "character", "integer", "integer", "character", 
          "character", "integer", "integer", "character", "character")
    )
});
