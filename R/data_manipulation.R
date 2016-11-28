#' Functions for manipulating datasets
#' @docType package
#' @name opendatr
NULL

#' A function for getting common intersection of N lists
#'
#' This function takes N lists and returns their common element(s)
#' @param ... Lists passed as parameters
#' @keywords common,intersect
#' @export
#' @examples
#' getIntersectOfMany()
getIntersectOfMany <- function(...){
  return(Reduce(intersect, list(...)))
}
