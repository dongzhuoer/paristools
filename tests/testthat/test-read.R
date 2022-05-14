testthat::context('Testing read.R')
setwd(here::here(''))  # workspace is reset per file



testthat::test_that('read_sam()', {
    sam <- read_sam('inst/extdata/Neat1_1.Aligend_trunc.sam')
    
    testthat::expect_true(tibble::is_tibble(sam))
    testthat::expect_identical(dim(sam), c(4996L, 11L))
    testthat::expect_identical(
        colnames(sam), 
        c('QNAME', 'FLAG', 'RNAME', 'POS', 'MAPQ', 'CIGAR', 'RNEXT', 'PNEXT', 'TLEN', 'SEQ', 'QUAL')
    )
    testthat::expect_identical(
        purrr::map_chr(sam, typeof) |> purrr::set_names(NULL), 
        c("character", "integer", "character", "integer", "integer", "character", 
          "character", "integer", "integer", "character", "character")
    )
})


testthat::test_that('read_bed()', {
    sample_bed <- paste(
        'chr22\t1000\t5000\tcloneA\t960\t+',
        'chr22\t2000\t6000\tcloneB\t900\t-',
        sep = '\n'
    )
    bed <- read_bed(sample_bed)
    testthat::expect_true(tibble::is_tibble(bed))
    testthat::expect_identical(dim(bed), c(2L, 6L))
    testthat::expect_identical(
        colnames(bed), 
        c("chrom", "start", "end", "name", "score", "strand")
    )
    testthat::expect_identical(
        purrr::map_chr(bed, typeof) |> purrr::set_names(NULL), 
        c("character", "integer", "integer", "character", "integer", "character")
    )
})
