testthat::context('Testing read-dg.R')
setwd(here::here(''))  # workspace is reset per file



# parse_loc ------------------
testthat::test_that('parse_loc()', {
    testthat::expect_identical(
        parse_loc('neat1(+):1-15'),
        tibble::tibble(chrom = "neat1", strand = "+", start = 1L, end = 15L)
    )
    
    testthat::expect_identical(
        parse_loc(c('neat1|+:40-69', 'neat1|+:27-50')),
        tibble::tibble(chrom = "neat1", strand = "+", start = c(40L, 27L), end = c(69L, 50L))
    )
})


# parse_locs ------------------
testthat::test_that('parse_locs()', {
    testthat::expect_identical(
        parse_locs('neat1(+):1-15|neat1(-):40-50', '|'),
        tibble::tibble(
            chrom = c("neat1", "neat1"), strand = c("+", "-"), start = c(1L, 40L),
            end = c(15L, 50L), pair = c("left", "right"))
    )

    testthat::expect_identical(
        parse_locs(c('neat1|+:1-15<=>neat1|-:298-316', 'neat1|+:1-16<=>neat1|+:303-317'), '<=>'),
        tibble::tibble(
            chrom = "neat1", strand = c("+", "+", "-", "+"), start = c(1L, 1L, 298L, 303L),
            end = c(15L, 16L, 316L, 317L), pair = c("left", "left", "right", "right"))
    )
})


# read_duplexgroup ------------------
testthat::test_that('read_duplexgroup() demo', {
    simple_raw_duplexgroup <- paste(
        'Group 0 == position neat1(+):1-15|neat1(+):40-50, support 2, left 183, right 229, score 0.010.',
        '---',
        '\tST-E00310:689:HTHKKCCXY:4:1221:20730:16340\tneat1|+:1-15<=>neat1|+:40-69',
        '\tST-E00310:689:HTHKKCCXY:4:1107:16122:19786\tneat1|+:1-19<=>neat1|+:27-50',
        sep = '\n'
    )
    
    testthat::expect_identical(
        read_duplexgroup(simple_raw_duplexgroup),
        tibble::tibble(
            chrom = "neat1", strand = "+", start = c(1L, 40L, 1L, 1L, 40L, 27L),
            end = c(15L, 50L, 15L, 19L, 69L, 50L),
            pair = c("left", "right", "left", "left", "right", "right"),
            type = c("genome", "genome", "read", "read", "read", "read"), id = "0", score = 0.010
        )
    );
    
    testthat::expect_error(
        simple_raw_duplexgroup |> stringr::str_replace('support 2', 'support 3') |> 
            read_duplexgroup(),
        'number of chimeric reads mismatch group support value'
    )
})


testthat::test_that('read_duplexgroup() real file', {
    duplexgroup <- read_duplexgroup('inst/extdata/Neat1_1.duplexgroup')
    
    testthat::expect_true(tibble::is_tibble(duplexgroup))
    testthat::expect_identical(dim(duplexgroup), c(15964L, 8L))
    testthat::expect_identical(
        colnames(duplexgroup), 
        c("chrom", "strand", "start", "end", "pair", "type", "id", "score")
    )
});
