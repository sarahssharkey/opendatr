#' Functions for plotting datasets
#' @docType package
#' @name opendatr
NULL

#' A function that plots data based on the x and y values passed in
#'
#' @param x x value to be plotted
#' @param y y value to be plotted
#' @param xlabel label for x axis
#' @param ylabel label for y axis
#' @param plotType Type of plot wanted (l = line, h = bar etc)
#' @keywords data,plot
#' @export
#' plotDataSet
plotDataSet <- function(x, y, xlabel, ylabel, plotTypeStr) {
  if(plotTypeStr != "pie"){
    plotType = ""
    switch(plotTypeStr,
           "line" = {
             plotType = "l"
           },
           "bar" = {
             plotType = "h"
           },
           "scatter" = {
             plotType = "p"
           }
    )
    plot(x,y, xlab = xlabel, ylab = ylabel, type = plotType, main = sprintf("%s over %s", ylabel, xlabel))
    lines(x = c(2003:2017), y = c(10000,100000,10000,10000,10000,10000,10000,10000,10000,10000,10000,10000,10000,10000,1000), col = "red")
    #axis(side = 1, cex = 0.5)#, at = x, cex = .1)
  }
  else if(plotTypeStr == "pie"){
    percentages <- round(y/sum(y)*100)
    percentLabel = paste(x, sprintf(" - %s%%", percentages))
    pie(y, main = sprintf("%s per %s", ylabel, xlabel), labels = percentLabel, col = rainbow(length(x)))
  }
}

#' A function that plots data based on the x and y values passed in
#'
#' @param datasets datasets = [dataset0 = [xVals, yVals, xLabel, yLabel], dataset1 = [xVals, yVals, xLabel, yLabel], ..... ]
#' @param plots list of plots wanted (l = line, h = bar etc)
#' @keywords data,plot
#' @export
#' plotDataSet
plotDataSet <- function(dataset, plots) {
  for(plot in plots){
    frame()
    for(set in dataset){
      x = set[[1]]
      y = set[[2]]
      xlabel = set[[3]]
      ylabel = set[[4]]
      if(plot != "pie"){
        plotType = ""
        switch(plot,
               "line" = {
                 plotType = "l"
               },
               "bar" = {
                 plotType = "h"
               },
               "scatter" = {
                 plotType = "p"
               }
        )
        plot(x,y, xlab = xlabel, ylab = ylabel, type = plotType, main = sprintf("%s over %s", ylabel, xlabel))
        #lines(x = c(2003:2017), y = c(10000,100000,10000,10000,10000,10000,10000,10000,10000,10000,10000,10000,10000,10000,1000), col = "red")

        #axis(side = 1, cex = 0.5)#, at = x, cex = .1)
      }
      else if(plot == "pie"){
        percentages <- round(y/sum(y)*100)
        percentLabel = paste(x, sprintf(" - %s%%", percentages))
        pie(y, main = sprintf("%s per %s", ylabel, xlabel), labels = percentLabel, col = rainbow(length(x)))
      }
    }
  }
}

