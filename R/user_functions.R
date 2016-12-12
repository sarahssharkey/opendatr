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
  datasets <- getDatasetList(c(...))
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
  if (length(datasets) == 1){
    returnVal[["commonVariables"]] <- list()
  }
  else {
    returnVal[["commonVariables"]] <- getCommonDataVariables(datasets)
  }



  return(returnVal)
}

#' A function that plots N datasets on graph(s) based on the information entered by the user
#' parameters:
#'
#' datasets = list of N data frames and urls
#'
#' graphTypes = list of N character strings specfiying what graph to plot for each dataset, respectively.
#' "pie" for pie charts and "scatter" for scatter plots.
#'
#' commonVariable = a character string common to all datasets or a list of N character strings, each
#' correspoinding to a dataset, respectively, specifying that they are to be considered common variables.
#'
#' yAxis = list of N character strings specifying the values for the yAxis for each dataset, respectively.
#'
#' factors = list of N lists. Each list corresponds to a dataset from the list of datasets, respectively.
#' In each list, an element name and value correspond to a factor column name and corresponding value
#' for that factor column, respectively.
#'
#' xLabels = list of N character strings, specifying the label for the x axis for the corresponding graph
#'
#' yLabels = list of N character strings, specifying the label for the y axis for the corresponding graph
#'
#' titles = list of N character strings, specifying the label for the title for the corresponding graph
#'
#' @param ... Parameters in above format specifying the plot the user would like
#' @keywords common,intersect,data,variable
#' @export
#' plotDatasets
plotDatasets <- function(datasets, graphTypes, commonVariable, yAxis, factors, xLabels, yLabels, titles) {
  datasets <- getDatasetList(datasets)
  checkCommonVariables(datasets, commonVariable)
  for (i in 1:length(factors)){
    subDataset <- datasets[[i]]
    datasetFactors <- factors[[i]]
    factorNames <- names(datasetFactors)
    if (length(datasetFactors) != 0){
      for (j in 1:length(datasetFactors)){
        subDataset <- subset(subDataset, subDataset[[factorNames[j]]] == datasetFactors[[j]])
      }
    }
    datasets[[i]] <- subDataset
  }

  plotData <- list(datasets = list(), graphTypes = graphTypes)

  for (i in 1:length(datasets)){
    if (class(commonVariable) == "list"){
      xAxisVal <- commonVariable[[i]]
    }
    else{
      xAxisVal <- commonVariable
    }
    yAxisVal <- yAxis[[i]]
    ds <- datasets[[i]]
    ds <- aggregate(ds[[yAxisVal]] ~ ds[[xAxisVal]], data = ds, sum)
    names(ds) <- c(xAxisVal, yAxisVal)
    datasetList <- list(xVals = ds[[xAxisVal]],
                        yVals = ds[[yAxisVal]],
                        xLabel = xLabels[[i]],
                        yLabel = yLabels[[i]],
                        title = titles[[i]])


    plotData[["datasets"]][[i]] <- datasetList
  }

  plotDataset(plotData)
}

#' A function that takes a list of data frames and urls and replaces all urls with the corresponding data frame.
#'
#' This function takes a list of N data frames and urls and returns a list of data frames.
#' @param ... List of urls and data frames
#' @keywords data,variable
#' getDatasetList
getDatasetList <- function(datasets) {
  if (length(datasets) == 0){
    stop("error: enter at least one dataset")
  }
  returnList <- list()
  for (i in 1:length(datasets)){
    dataset <- datasets[[i]]
    if (class(dataset) == "character"){
      returnList[[i]] <- getDataset(dataset)
    }
    else if (class(dataset) == "data.frame"){
      returnList[[i]] <- dataset
    }
    else{
      stop("error: datasets given must be either URL to dataset or data frame.")
    }
  }
  return(returnList)
}

#' A function that takes a list of data frames and a list of common variables and checks that the common variables in each each dataset are of the same type.
#'
#' This function takes a list of N data frames and common variables.
#' @param ... List of data frames and common variables.
#' @keywords data,variable,common
#' getDatasetList
checkCommonVariables <- function(datasets, commonVariable) {
  if (class(commonVariable) == "character"){
    classType <- class(datasets[[1]][[commonVariable]])
    for (i in 2:length(datasets)){
      newClassType <- class(datasets[[i]][[commonVariable]])
      if (newClassType != classType){
        stop(paste("error: incompatible common variable types", classType, newClassType))
      }
    }
  }
  else if (class(commonVariable) == "list"){
    commonVar <- commonVariable[[1]]
    classType <- class(datasets[[1]][[commonVar]])
    for (i in 2:length(commonVariable)){
      commonVar <- commonVariable[[i]]
      newClassType <- class(datasets[[i]][[commonVar]])
      if (newClassType != classType){
        stop(paste("error: incompatible common variable types", classType, newClassType))
      }
    }
  }
}
