

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
#' @importFrom stringr str_extract
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
read_duplexgroup2 <- function(path) {
    group <- path %>% readr::read_file() %>% stringr::str_remove_all('\n$') %>% 
        stringr::str_split('\n(?=Group )') %>% unlist()
    
    group_mat <- stringr::str_split_fixed(group, '---', 2)
    
    
    genome_line <- group_mat[ , 1]
    reads_lines <- group_mat[ , 2]

    id <- genome_line %>% stringr::str_extract('\\d+') 
    score <- genome_line %>% stringr::str_extract('(?<=score )[\\d\\.]+(?=\\.)') %>% as.double()
    support <- genome_line %>% str_extract('(?<=support )[\\d]+') %>% as.integer()
        
    if (!identical(stringr::str_count(reads_lines, '\n'), support))
        stop('number of chimeric reads mismatch group support value')

 dplyr::bind_rows(
    dplyr::bind_cols(
        genome_line %>% stringr::str_extract('(?<=position )[^,]+') %>% parse_locs('|') %>% tibble::add_column(type = 'genome'),
        list(id = id, score = score) %>% purrr::map_dfc(rep, times = 2)
    )
    ,
    dplyr::bind_cols(
        reads_lines %>% paste0(collapse = '') %>% stringr::str_split('\n') %>% .[[1]] %>% .[-1] %>% stringr::str_split_fixed('\t', 3) %>% .[ , 3] %>% parse_locs('<=>')%>% tibble::add_column(type = 'read'),
        list(id = id, score = score) %>% purrr::map(rep, times = support) %>% purrr::map_dfc(rep, times = 2)
    ) 
 ) %>% dplyr::arrange(id, type) %>% dplyr::mutate_at(dplyr::vars(start, end), as.integer)
}

