testthat::context('Testing main.R')
if (basename(getwd()) == 'testthat') setwd('../..')  # workspace is reset per file


testthat::test_that('cal_coverage()', {
    loc_df = tibble::tibble(chrom = c('I', 'II'), start = c(1, 2), end = c(4, 3), strand = c('+', '-'))
    
    testthat::expect_identical(
        cal_coverage(loc_df),
        tibble::tibble(
            chrom = c("I", "I", "I", "I", "I", "I", "I", "I", "II", "II", "II", "II", "II", "II"), 
            pos = c(1L, 2L, 3L, 4L, 1L, 2L, 3L, 4L, 1L, 2L, 3L, 1L, 2L, 3L), 
            n_reads = c(1L, 1L, 1L, 1L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 1L, 1L), 
            strand = c("+", "+", "+", "+", "-", "-", "-", "-", "+", "+", "+", "-", "-", "-")
        )
    )
})
