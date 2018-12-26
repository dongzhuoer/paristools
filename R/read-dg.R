

#' @title parse genome location specification in `.duplexgroup` file
#'
#' @details 
#' we assume chr only contains alpha-numeric characters
#' 
#' @export
parse_loc <- function(loc) {
    tibble::tibble(
        chr    = stringr::str_extract(loc, '\\w+'),
        strand = stringr::str_extract(loc, '[+-]'),
        start  = stringr::str_extract(loc, '(?<=:)\\d+'),
        end    = stringr::str_extract(loc, '\\d+$')
    )
}

#' @title parse genome location of left & right segment
#' 
#' @export
parse_locs <- function(locs, sep) {
   mat <- stringr::str_split(locs, stringr::fixed(sep), simplify = T) 
   left <-  mat[, 1] %>% parse_loc %>% tibble::add_column(pair = "left")
   right <- mat[, 2] %>% parse_loc %>% tibble::add_column(pair = "right")
   dplyr::bind_rows(left, right)
}



#' @title parse a duplex group
#' @section to do: 
#' here we parse each group separately to run faster, we can add tag to each group, and parse at once
#' 
#' @export
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


#' @title read `.duplexgroup` file
#' 
#' @export
read_duplexgroup <- function(path) {
    path %>% readr::read_file() %>% 
        stringr::str_split('\n(?=Group )') %>% unlist() %>% 
        parallel::mclapply(parse_group) %>% dplyr::bind_rows() %>%
        dplyr::mutate_at(c('start', 'end'), as.integer) %>% 
        dplyr::mutate_at('score', as.numeric)
} 


#' @title read `.duplexgroup` file
#' 
#' @export
 
# path <- 'inst/extdata/Neat1_1.duplexgroup'
read_duplexgroup2 <- function() {
    group <- path %>% readr::read_file() %>% stringr::str_split('\n(?=Group )') %>% unlist()
    
    group_mat <- stringr::str_split_fixed(group, '---', 2)
    
    
    genome_line <- group_mat[ , 1]
    reads_lines <- group_mat[ , 2]
    
    dplyr::bind_cols(
        genome_line %>% stringr::str_extract('(?<=position )[^,]+') %>% parse_locs('|'),
        genome_line %>% stringr::str_extract('\\d+') %>% rep(times = 2) %>% tibble::tibble(id = .)
        
    ) %>% tibble::add_column(type = 'genome')
    
    
    reads_lines %>% stringr::str_split_fixed('\t',)[ , 3] %>% parse_locs('|')
    reads_lines[1:3]
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

