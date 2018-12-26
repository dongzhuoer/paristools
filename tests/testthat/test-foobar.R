testthat::context('Testing foobar')
if (basename(getwd()) == 'testthat') setwd('../..')  # workspace is reset per file

testthat::test_that('foobar()', {
    testthat::expect_true(T);

    print('haha, I\'m not skipped')    
});

testthat::test_that('foobar()', {
    testthat::expect_true(T);

    'Nice, I can use %>% ' %>% print()    
});
