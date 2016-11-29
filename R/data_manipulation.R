#' Functions for manipulating datasets
#' @docType package
#' @name opendatr
NULL

#' A function for getting common data variables of N data sets
#'
#' This function takes N data sets and returns their common data variable(s)
#' @param ... Lists passed as parameters
#' @keywords common,intersect,data,variable
#' @export
#' getCommonDataVariables
getCommonDataVariables <- function(...) {
  intersectNames <- function(x,y) {
    if(is.null(colnames(x))){
      return(intersect(x,colnames(y)))
    } else {
      return(intersect(colnames(x),colnames(y)))
    }
  }
  return(Reduce(intersectNames, list(...)))
}
