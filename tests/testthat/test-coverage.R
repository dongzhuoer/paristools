testthat::context('Testing coverage.R')
setwd(here::here(''))  # workspace is reset per file


testthat::test_that('cal_coverage()', {
    loc_df = tibble::tibble(chrom = c('I', 'II'), start = c(1, 2), end = c(4, 3), strand = c('+', '-'))
    
    testthat::expect_identical(
        cal_coverage(loc_df),
        tibble::tibble(
            chrom = c("I", "I", "I", "I", "I", "I", "I", "I", "II", "II", "II", "II", "II", "II"), 
            strand = c("+", "+", "+", "+", "-", "-", "-", "-", "+", "+", "+", "-", "-", "-"),
            pos = c(1L, 2L, 3L, 4L, 1L, 2L, 3L, 4L, 1L, 2L, 3L, 1L, 2L, 3L), 
            n_reads = c(1L, 1L, 1L, 1L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 1L, 1L)
        )
    )
})

testthat::test_that('get_dg_coverage()', {
    sam_file <- system.file('extdata', 'Neat1_1.Aligend_trunc.sam', package = 'paristools')
    genome_coverage <- sam_file %>% read_sam() %>% sam_to_loc_df() %>% cal_coverage()
    duplex_group <- read_duplexgroup('inst/extdata/Neat1_1.duplexgroup')
    dg_coverage <- get_dg_coverage(duplex_group, genome_coverage)

    testthat::expect_equal(
        tolerance = 1e-4,
        dg_coverage[c(1, 3), ],
        tibble::tibble(id = c("0", "1"), chrom = "neat1", strand = "+", pair = "left", n_reads = c(22.8, 22.8), support = 2L)
    )
})
