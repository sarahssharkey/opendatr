#' Functions for plotting datasets
#' @docType package
#' @name opendatr
NULL

#' A function that plots data based on the x and y values passed in
#'
#' @param datasets datasets = [dataset0 = [xVals, yVals, xLabel, yLabel], dataset1 = [xVals, yVals, xLabel, yLabel], ..... ]
#' @param plots list of plots wanted (l = line, h = bar etc)
#' @keywords data,plot
#' plotDataset
plotDataset <- function(plotInfo) {
  graphTypes <- plotInfo[["graphTypes"]]
  datasets <- plotInfo[["datasets"]]

  par(mfrow=c(length(datasets),1))
  i <- 1
  for(set in datasets){
    x = set[["xVals"]]
    y = set[["yVals"]]
    xlabel = set[["xLabel"]]
    ylabel = set[["yLabel"]]
    title = set[["title"]]
    graphType <- graphTypes[[i]]
    i <- i + 1
    if(graphType != "pie"){
      plotType = ""
      switch(graphType,
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
      plot(x,y, xlab = xlabel, ylab = ylabel, type = plotType, main = title, cex = 1/length(x))

      #lines(x = c(2003:2017), y = c(10000,100000,10000,10000,10000,10000,10000,10000,10000,10000,10000,10000,10000,10000,1000), col = "red")

      #axis(side = 1, cex = 0.5)#, at = x, cex = .1)
    }
    else if(graphType == "pie"){
      percentages <- round(y/sum(y)*100)
      percentLabel = paste(x, sprintf(" - %s%%", percentages))
      pie(y, main = title, labels = "", col = rainbow(length(x)), radius = 2)
      legend(x = "bottomleft", legend = percentLabel, fill = rainbow(length(x)), cex = 0.4, ncol = 5)
    }
  }
}
