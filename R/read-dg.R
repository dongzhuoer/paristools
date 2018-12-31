# common import
#' @importFrom tibble add_column
#' @importFrom stringr str_extract str_split str_split_fixed
NULL


#' @title parse genome location specification in `.duplexgroup` file
#' 
#' @param loc character
#'
#' @details 
#' we assume chr only contains alpha-numeric characters
#' 
#' @examples 
#' parse_loc('neat1(+):1-15')
#' parse_loc(c('neat1|+:40-69', 'neat1|+:27-50'))
#' 
#' @export

# loc = c('neat1|+:40-69', 'neat1|+:27-50')
parse_loc <- function(loc) {
    tibble::tibble(
        chr    = str_extract(loc, '\\w+'),
        strand = str_extract(loc, '[+-]'),
        start  = str_extract(loc, '(?<=:)\\d+') %>% as.integer(),
        end    = str_extract(loc, '\\d+$') %>% as.integer()
    )
}

#' @title parse genome location of left & right segments
#' 
#' @param locs character
#' @param sep string. separate left & right segments, passed on to [stringr::fixed()]
#' 
#' @examples 
#' parse_locs('neat1(+):1-15|neat1(-):40-50', '|')
#' 
#' parse_locs(c('neat1|+:1-15<=>neat1|-:298-316', 'neat1|+:1-16<=>neat1|+:303-317'), '<=>')
#' 
#' @export

# locs = c('neat1|+:1-15<=>neat1|-:298-316', 'neat1|+:1-16<=>neat1|+:303-317')
# sep = '<=>'
parse_locs <- function(locs, sep) {
   mat <- str_split_fixed(locs, stringr::fixed(sep), 2) 
   left <-  mat[, 1] %>% parse_loc %>% add_column(pair = "left")
   right <- mat[, 2] %>% parse_loc %>% add_column(pair = "right")
   dplyr::bind_rows(left, right)
}


#' @title read `.duplexgroup` file
#' 
#' @param file string. path to input file, passed onto [readr::read_file()]
#' 
#' @return a tibble of 8 variables
#' 
#' @examples 
#' read_duplexgroup(system.file('extdata', 'Neat1_1.duplexgroup', package = 'paristools'))
#' 
#' 
#' @section implementation:
#' `read_duplexgroup()` runs quite fast, since we fully utilize R's
#' vectorisation feature, at the price of _obscured_ code.
#'
#' [read_duplexgroup_old()] is much clearer, it parses each group separately.
#' reading its source can help you understand the implementation.
#'
#' In short, the most difficult part is, how to label each row with correct
#' identifier (group id here) after we concatenate each loc line and
#' [parse_locs()] at once,
#' 
#' @export
 
# file <- 'inst/extdata/Neat1_1.duplexgroup'
read_duplexgroup <- function(file) {
    group <- file %>% readr::read_file() %>% stringr::str_remove_all('\n$') %>% 
        str_split('\n(?=Group )') %>% .[[1]]     # each element is a duplexgroup
    group_mat <- str_split_fixed(group, '---', 2)       # columns: genome, reads
    
    genome_line <- group_mat[ , 1]
    genome_loc <- genome_line %>% str_extract('(?<=position )[^,]+') 
    genome_df <- genome_loc %>% parse_locs('|') %>% add_column(type = 'genome')

    reads_lines <- group_mat[ , 2] # each element contains multiple reads
    reads_loc <- reads_lines %>% paste0(collapse = '') %>% 
        {str_split(., '\n')[[1]][-1]} %>% {str_split_fixed(., '\t', 3)[ , 3]}
    reads_df <- reads_loc %>% parse_locs('<=>') %>% add_column(type = 'read')

    # `support` stores how many reads each group contains, make sure it's correct
    support <- genome_line %>% str_extract('(?<=support )[\\d]+') %>% as.integer()
    if (!identical(stringr::str_count(reads_lines, '\n'), support))
        stop('number of chimeric reads mismatch group support value')
    
    # the difficult part: label each row with correct identifier
    id <- genome_line %>% str_extract('\\d+') 
    score <- genome_line %>% str_extract('(?<=score )[\\d\\.]+(?=\\.)') %>% as.double()
    tag_df <- tibble::tibble(id = id, score = score);
        # rep(times = 2): left + right, rep(times = support): each group has multiple reads
    genome_tag_idx <- seq_along(id) %>% rep(times = 2)
    reads_tag_idx <- seq_along(id) %>% rep(times = support) %>% rep(times = 2)

    dplyr::bind_rows(
        dplyr::bind_cols(genome_df, tag_df[genome_tag_idx, ]),
        dplyr::bind_cols(reads_df, tag_df[reads_tag_idx, ])
     ) %>% dplyr::arrange(id, type)
}


# obsolete ------------------------------


#' @title read `.duplexgroup` file
#' 
#' @keywords internal
read_duplexgroup_old <- function(file) {
    # parse a duplex group
    parse_group <- function(group) {
        lines <- stringr::str_split(group, '\n')[[1]][-2]
        
        genome <- stringr::str_extract(lines[1], '(?<=position )[^,]+')
        reads  <- stringr::str_split(lines[-1], '\t', simplify = T)[ , 3]
        
        dplyr::bind_rows(
            genome %>% parse_locs('|')   %>% tibble::add_column('type' = 'genome'),
            reads  %>% parse_locs('<=>') %>% tibble::add_column('type' = 'read')
        ) %>% tibble::add_column(
            'id' = stringr::str_extract(lines[1], '\\d+'), 
            'score' = stringr::str_extract(lines[1], '(?<=score )[\\d\\.]+(?=\\.)')
        )
    }
    
    file %>% readr::read_file() %>% 
        stringr::str_split('\n(?=Group )') %>% unlist() %>% 
        parallel::mclapply(parse_group) %>% dplyr::bind_rows() %>%
        dplyr::mutate_at('score', as.numeric)
} 


