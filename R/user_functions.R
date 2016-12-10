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

#' A function that plots N datasets on graph(s) based on the information entered by the user
#'
#' This function takes a list of information in the specified format
#' list parameter =
#'[ urlList = [dataset0 = url0, dataset1 = url1, ...., datasetn = urln],
#'  graphType = [graph1, graph2, ..... graphn],
#'  commonVariable = var || [commonVar0, commonVar1, .... , commonVarn],
#'  yAxis = [dataset0 = colName, dataset1 = colName, ...., datasetN = colName],
#'  factors = [
#'    dataset0factors = [factor0 = val0, factor = val1, factor2 = val2, …., factorn = valn],
#'    dataset1factors = [factor0 = val0, factor1 = val1, factor2 = val2, …., factorn = valn],
#'    ....
#'    datasetNfactors = [factor0 = val0, factor1 = val1, factor2 = val2, …., factorn = valn]
#'    ]]
#' @param ... List in above format specifying the plot the user would like
#' @keywords common,intersect,data,variable
#' @export
#' plotDatasets
plotDatasets <- function(plotInfo) {
  urls <- plotInfo[["urlList"]]
  datasets <- apply((matrix(as.vector(unlist(urls)), nrow = 1, ncol = length(urls))), 2, getDataSet)
  graphType <- plotInfo[["graphType"]]
  commonVariable <- plotInfo[["commonVariable"]]
  if (class(commonVariable) == "character"){
    classType <- class(datasets[[1]][[commonVariable]])
    for (i in 2:length(datasets)){
      newClassType <- class(datasets[[i]][[commonVariable]])
      if (newClassType != classType){
        print(paste("incompatible common variable types", classType, newClassType))
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
        print(paste("incompatible common variable types", classType, newClassType))
      }
    }
  }
  factors <- plotInfo[["factors"]]
  for (i in 1:length(factors)){
    subDataset <- datasets[[i]]
    datasetFactors <- factors[[i]]
    factorNames <- names(datasetFactors)
    for (j in 1:length(datasetFactors)){
      subDataset <- subset(subDataset, subDataset[[factorNames[j]]] == datasetFactors[[j]])
    }
    datasets[[i]] <- subDataset
  }
  yAxis <- plotInfo$yAxis
  plotData <- list(datasets = list(), graphTypes = graphType)

  for (i in 1:length(datasets)){
    if (class(commonVariable) == "list"){
      xAxisVal <- commonVariable[[i]]
    }
    else{
      xAxisVal <- commonVariable
    }
    yAxisVal <- yAxis[[i]]
    ds <- datasets[[i]]

    datasetList <- list(xVals = ds[[xAxisVal]],
                        yVals = ds[[yAxisVal]],
                        xLabel = xAxisVal,
                        yLabel = yAxisVal)


    plotData[["datasets"]][[i]] <- datasetList
  }

  return(plotData)
}
