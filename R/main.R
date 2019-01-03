#' @title calculate genome coverage
#' 
#' @param loc_df data.frame. must contain 4 columns: `chrom`, `strand`, `start`, `end`
#' 
#' @return tibble. 4 elements, `chrom`, `strand`, `pos`, `n_reads`. `n_reads` means number of reads covering given position.
#' @details we use 1-based coordinate, [start, end]
#' 
#' @export

# loc_df = tibble::tibble(chrom = c('I', 'II'), start = c(1, 2), end = c(4, 3), strand = c('+', '-'))
cal_coverage <- function(loc_df) {
    cal_coverage_impl_df <- function(loc_df, chrom) {
        n_reads_l <- cal_coverage_impl(loc_df) 
        plus  <- n_reads_l[["+"]]
        minus <- n_reads_l[["-"]]
        
        dplyr::bind_rows(
            tibble::tibble(pos = seq_along(plus),  n_reads = plus,  strand = "+"),
            tibble::tibble(pos = seq_along(minus), n_reads = minus, strand = "-")
        )
    }
    
    loc_df %>% dplyr::group_by(chrom) %>% dplyr::group_map(cal_coverage_impl_df) %>% dplyr::ungroup()
}

get_dg_coverage <- function(duplex_group, genome_coverage, max_support = 2L) {
    semi_join(
        duplex %>% filter(type == 'genome'),
        duplex %>% filter(type == 'read') %>% count(id) %>% filter(n <= 2)
    ) %>%
    select('strand', 'start', 'end', 'pair', 'id') %>%
    pmap_dfr(~ tibble(strand = ..1, pos = seq(..2, ..3), pair = ..4, id = ..5)) %>% 
    left_join(coverage) %>% 
    group_by_at(c('pair', 'id')) %>% summarise(n_reads = mean(n_reads)) %>% ungroup()

}
