testthat::context('Testing main.cpp')
if (basename(getwd()) == 'testthat') setwd('../..')  # workspace is reset per file

testthat::test_that('parse_CIGAR()', {
    testthat::expect_true(T);
    
    test_parse_CIGAR('neat1', 0, 2691, '8S20M3S', 8+20+3);
    test_parse_CIGAR('neat1', 16, 388, '4S31M', 4+31);
    test_parse_CIGAR('neat1', 256, 2534, '5M504N38M', 5+38);
})

