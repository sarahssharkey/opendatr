#' Functions for retrieving datasets
#' @docType package
#' @name opendatr
#' @import rjstat
NULL

#' A JSON Stat Data Retrieval Function
#'
#' This function allows you to retrieve JSON-stat data at a specified URL in data frame format.
#' @param dataURL URL of JSON-stat data
#' @keywords json,jsonstat
#' @export
#' @examples
#' getJSONStatData()
getJSONStatData <- function(dataURL){
  data <- fromJSONstat(dataURL)
  return(data[[1]])
}

#' A CSV Data Retrieval Function
#'
#' This function allows you to retrieve CSV data at a specified URL in data frame format.
#' @param dataURL URL of CSV data
#' @keywords CSV, csv
#' @export
#' @examples
#' getCSVData()
getCSVData <- function(dataURL){
  data <- read.csv(dataURL)
  return(data)
}
