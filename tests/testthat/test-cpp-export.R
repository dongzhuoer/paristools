testthat::context('Testing C++ export')
if (basename(getwd()) == 'testthat') setwd('../..')  # workspace is reset per file



testthat::test_that('get_strand()', {
    testthat::skip_if(getOption('testthat_quick'))

    testthat::expect_identical(
        callr::r(function() {Rcpp::evalCpp('paristools::get_strand(16)', depends = 'paristools')}),
        "-"
    )
})
