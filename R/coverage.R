#' @title calculate genome coverage
#' 
#' @param loc_df data.frame. must contain 4 columns: `chrom`, `strand`, `start`, `end`
#' 
#' @return tibble. 4 elements, `chrom`, `strand`, `pos`, `n_reads`. `n_reads` means number of reads covering given position.
#' @details we use 1-based coordinate, [start, end]
#' 
#' @examples 
#' sam_file <- system.file('extdata', 'Neat1_1.Aligend_trunc.sam', package = 'paristools')
#' sam_file %>% read_sam() %>% sam_to_loc_df() %>% cal_coverage()
#' 
#' @export

# loc_df = tibble::tibble(chrom = c('I', 'II'), start = c(1, 2), end = c(4, 3), strand = c('+', '-'))
cal_coverage <- function(loc_df) {
    cal_coverage_impl_df <- function(loc_df, chrom) {
        n_reads_l <- cal_coverage_impl(loc_df) 
        plus  <- n_reads_l[["+"]]
        minus <- n_reads_l[["-"]]
        
        dplyr::bind_rows(
            tibble::tibble(strand = "+", pos = seq_along(plus),  n_reads = plus),
            tibble::tibble(strand = "-", pos = seq_along(minus), n_reads = minus)
        )
    }
    
    loc_df %>% dplyr::group_by(chrom) %>% dplyr::group_map(cal_coverage_impl_df) %>% dplyr::ungroup()
}


#' @title calculate average coverage of duplex group segment
#'
#' @param duplex_group tibble. see [read_duplexgroup()]
#' @param genome_coverage tibble. see [cal_coverage()]
#'
#' @return tibble. 
#'
#' @examples
#' sam_file <- system.file('extdata', 'Neat1_1.Aligend_trunc.sam', package = 'paristools')
#' duplexgroup_file <- system.file('extdata', 'Neat1_1.duplexgroup', package = 'paristools');
#' get_dg_coverage(
#'     read_duplexgroup(duplexgroup_file),
#'     sam_file %>% read_sam() %>% sam_to_loc_df() %>% cal_coverage()
#' )
#' 
#' @export 
 
# duplex_group <- 'inst/extdata/Neat1_1.duplexgroup' %>% read_duplexgroup()
# genome_coverage <- 'inst/extdata/Neat1_1.Aligend_trunc.sam' %>% read_sam() %>% sam_to_loc_df() %>% cal_coverage()
get_dg_coverage <- function(duplex_group, genome_coverage) {
    dg_support <- duplex_group %>% dplyr::filter(pair == 'left', type == 'read') %>% 
        dplyr::count(id, name = 'support')
    
    duplex_group %>% dplyr::filter(type == 'genome') %>%
        dplyr::select('strand', 'start', 'end', 'pair', 'id') %>%
        purrr::pmap_dfr(~ tibble::tibble(strand = ..1, pos = seq(..2, ..3), pair = ..4, id = ..5)) %>% 
        dplyr::left_join(genome_coverage, by = c('strand', 'pos')) %>% 
        dplyr::group_by(id, chrom, strand, pair) %>% 
        dplyr::summarise(n_reads = mean(n_reads)) %>% dplyr::ungroup() %>% 
        dplyr::left_join(dg_support, by = 'id')
}
