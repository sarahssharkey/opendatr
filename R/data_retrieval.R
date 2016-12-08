#' Functions for retrieving datasets
#' @docType package
#' @name opendatr
#' @import rjstat
#' @import httr
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
  data <- fromJSONstat(dataURL, use_factors = TRUE)
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
    tryCatch({
        data <- read.csv(dataURL)
    },
    warning=function(cond){
        stop("error: dataURL passed must be a csv.")
    },
    error=function(cond){
        stop("error: dataURL passed must be a csv.")
    })
    data[ , -which(names(data) %in% c(""))]
    data <- Filter(function(x)!all(is.na(x)), data)
    return(data)
}

#' A JSON & CSV Data Retrieval Function
#'
#' This function allows you to retrieve JSON or CSV data from a specified URL in data frame format.
#' @param dataURL of JSON or CSV data
#' @keywords CSV, csv, json, jsonstat
#' @export
#' @examples
#' getDataSet()
getDataSet <- function(dataURL) {
    #Try Determine file-type from dataURL extension.
    if(grepl(".json$",dataURL)){
        d <- getJSONStatData(dataURL);
    }
    else if(grepl(".csv$",dataURL)){
        d <- getCSVData(dataURL)
    }
    else{
        x <- GET(dataURL)
        h <- headers(x)$'Content-Type'
        #Try Determine file-type from HTTP response 'Content-Type'.
        if(grepl("json;",h) | grepl("json$",h)){
            d <- getJSONStatData(dataURL);
        }
        else if(grepl("csv;",h) | grepl("csv$",h)){
            d <- getCSVData(dataURL)
        }
        else{
            #Try download as JSON and CSV
            out <- tryCatch(
            {
                d <- getJSONStatData(dataURL)
            },
            error=function(cond){
                tryCatch({
                    d <- getCSVData(dataURL)
                },
                warning=function(cond){
                    stop("error: dataURL passed must be a csv or json.")
                },
                error=function(cond){
                    stop("error: dataURL passed must be a csv or json.")
                })
            }
            )
        }
    }
}
