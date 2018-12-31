testthat::context('Testing utility.cpp')
if (basename(getwd()) == 'testthat') setwd('../..')  # workspace is reset per file

testthat::test_that('get_strand()', {
    testthat::expect_identical(
        purrr::map_chr(c(0L, 256L, 16L), get_strand),
        c("+", "+", "-")
    )
})

testthat::test_that('as_locs()', {
    testthat::expect_identical(
         test_as_locs(),
        tibble::tibble(chrom = "neat1", strand = c("+", "-"), start = c(1L, 17L), end = c(100L, 49L))
    )
})
