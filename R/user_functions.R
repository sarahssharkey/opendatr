#' User functions for working with datasets
#' @docType package
#' @name opendatr
NULL

#' A function that returns plotting information about datasets
#'
#' This function takes N data sets as urls and returns a list of information about them
#' @param ... Lists passed as parameters
#' @keywords common,intersect,data,variable
#' @export
#' getDatasetInfo
getDatasetInfo <- function(...) {
  datasets <- apply((matrix(c(...), nrow = 1, ncol = length(c(...)))), 2, getDataSet)
  names(datasets) <- paste("dataset", 0:(length(datasets)-1))
  returnVal <- list()
  for (index in 1:length(datasets)){
    d <- as.list(setNames(names(datasets[[index]]), names(datasets[[index]])))
    for (i in names(d)){
      if (class(datasets[[index]][[i]]) == "factor"){
        d[[i]] <- levels(datasets[[index]][[i]])
      }
    }
    returnVal[[paste("dataset", index-1)]] <- d
  }
  returnVal[["commonVariables"]] <- getCommonDataVariables(datasets)


  return(returnVal)
}
