#' Functions for manipulating datasets
#' @docType package
#' @name opendatr
NULL

#' A function for getting common data variables from N data sets
#'
#' This function takes N data sets and returns their common data variables
#' @param ... Datasets passed as parameters
#' @keywords common,intersect
#' @export
#' @examples
#' getCommonDataVariables()
getCommonDataVariables <- function(...){
  args <- list(...)
  lengthOfArgs <- length(args)
  if(lengthOfArgs < 2) stop("Not enough data sets provided")
  intersectionOfSets <- c()
  a <- args[[1]]
  b <- args[[2]]
  intersectionOfSets <- intersect(a,b)
  for(arg in args[3:lengthOfArgs]){
    if(!is.null(arg))
      intersectionOfSets <- intersect(intersectionOfSets,arg)
  }
  return(intersectionOfSets)
}
