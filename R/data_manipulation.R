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
    colnameFunction <- colnames

    if(is.null(dim(x))){
      colnameFunction <- names
    }

    if(is.null(colnameFunction(x))){
      return(intersect(x,colnameFunction(y)))
    } else {
      return(intersect(colnameFunction(x),colnameFunction(y)))
    }
  }
  return(Reduce(intersectNames, list(...)))
}

#' A function for presenting the data variables of N data sets
#'
#' This function takes N data sets and returns the different variables present in the data sets.
#' @param ... Lists passed as parameters
#' @keywords union,data,variable
#' @export
#' getVariables
getVariables <- function(...) {
    unionNames <- function(x,y) {
        colnameFunction <- colnames
        
        if(is.null(dim(x))){
            colnameFunction <- names
        }
        
        if(is.null(colnameFunction(x))){
            return(union(x,colnameFunction(y)))
        } else {
            return(union(colnameFunction(x),colnameFunction(y)))
        }
    }
    return(Reduce(unionNames, list(...)))
}
