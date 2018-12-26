testthat::context('Testing read-dg.R')
if (basename(getwd()) == 'testthat') setwd('../..')  # workspace is reset per file



testthat::test_that('parse_loc()', {
    testthat::expect_identical(
        parse_loc('neat1(+):1-15'),
        tibble::tibble(chr = "neat1", strand = "+", start = "1", end = "15")
    )
    
    testthat::expect_identical(
        parse_loc(c('neat1|+:40-69', 'neat1|+:27-50')),
        tibble::tibble(chr = "neat1", strand = "+", start = c("40", "27"), end = c("69", "50"))
    )
});


testthat::test_that('parse_locs()', {
    testthat::expect_identical(
        parse_locs('neat1(+):1-15|neat1(-):40-50', '|'),
        tibble::tibble(
            chr = c("neat1", "neat1"), strand = c("+", "-"), start = c("1", "40"), 
            end = c("15", "50"), pair = c("left", "right"))
    )
    
    testthat::expect_identical(
        parse_locs(c('neat1|+:1-15<=>neat1|-:298-316', 'neat1|+:1-16<=>neat1|+:303-317'), '<=>'),
        tibble::tibble(
            chr = "neat1", strand = c("+", "+", "-", "+"), start = c("1", "1", "298", "303"), 
            end = c("15", "16", "316", "317"), pair = c("left", "left", "right", "right"))
    )
});


testthat::test_that('parse_group()', {
    testthat::expect_identical(
        paste(
            'Group 0 == position neat1(+):1-15|neat1(+):40-50, support 2, left 183, right 229, score 0.010.',
            '---',
        	'\tST-E00310:689:HTHKKCCXY:4:1221:20730:16340\tneat1|+:1-15<=>neat1|+:40-69',
        	'\tST-E00310:689:HTHKKCCXY:4:1107:16122:19786\tneat1|+:1-19<=>neat1|+:27-50',
            sep = '\n'
        ) %>% parse_group(),
        tibble::tibble(
            chr = "neat1", strand = "+", start = c("1", "40", "1", "1", "40", "27"), 
            end = c("15", "50", "15", "19", "69", "50"), 
            pair = c("left", "right", "left", "left", "right", "right"), 
            type = c("genome", "genome", "read", "read", "read", "read"), id = "0", score = "0.010"
        )
    );
});

testthat::test_that('read_duplexgroup()', {
    testthat::expect_true(T)
    
    read_duplexgroup('inst/extdata/Neat1_1.duplexgroup')
});




