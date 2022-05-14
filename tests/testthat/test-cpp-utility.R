testthat::context('Testing utility.cpp')
setwd(here::here(''))  # workspace is reset per file



testthat::test_that('cpp_version()', {
    testthat::expect_identical(
        stringr::str_sub(cpp_version(), 0, 4),
        "2017"
    )
})


testthat::test_that("as_tibble()", {
    l <- list(x = rnorm(3), y = 1:3);
    testthat::expect_identical(as_tibble(l), tibble::as_tibble(l))
    testthat::expect_identical(class(l), 'list')    # shouldn't modify input
    
    testthat::expect_error(
        as_tibble(list(x = rnorm(3), y = 1:2)),
        "2th element should be of length 3, not 2"
    )
    
    testthat::expect_error(
        as_tibble(list()),
        "not support empty list"
    )
})


testthat::test_that('get_strand()', {
    testthat::expect_identical(
        purrr::map_chr(c(0L, 16L, 256L, 272L), get_strand),
        c("+", "-", "+", "-")
    )
})


testthat::test_that('as_loc_df()', {
    testthat::expect_identical(
        test_as_loc_df(),
        tibble::tibble(chrom = "neat1", strand = c("+", "-"), start = c(1L, 17L), end = c(100L, 49L))
    )
})


testthat::test_that('cal_coverage_impl()', {
    sam <- tibble::tibble(strand = c('+', '-', '-', '+'), start = c(1, 2, 1, 2), end = c(4, 3, 3, 4));
    testthat::expect_identical(
        cal_coverage_impl(sam),
        tibble::tibble("pos" = seq(1, 4), "+" = c(1L, 2L, 2L, 2L), "-" = c(1L, 2L, 2L, 0L))
    )
})
