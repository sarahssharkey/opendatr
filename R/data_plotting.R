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
  if (length(datasets) > 1){
    par(mfrow=c(length(datasets),1))
  }

  i <- 1
  for(set in datasets){
    x = set[["xVals"]]
    y = set[["yVals"]]
    xlabel = set[["xLabel"]]
    ylabel = set[["yLabel"]]
    title = set[["title"]]
    graphType <- graphTypes[[i]]
    i <- i + 1
    if(graphType == "scatter"){
      plot(x,y, xlab = xlabel, ylab = ylabel, main = title, cex = 1/length(x))
    }
    else if(startsWith(graphType, "pie")){
      if (nchar(graphType) > 3){
        scale <- as.numeric(substring(graphType, 5))
      }
      else{
        scale <- 1
      }
      percentages <- round(y/sum(y)*100)
      percentLabel = paste(x, sprintf(" - %s%%", percentages))
      colour = rainbow(length(x))
      textSize = 1
      par(xpd=TRUE)
    pie(y, main = title, labels = "", col = colour, radius = scale)

      textSize = (1 / (logb(length(x),5)))
      if(length(x) > 15){
        textSize = (1 / (logb(length(x),5)))
        legend(x = "left", legend = percentLabel, fill = colour, cex = textSize, ncol = 4)
      }
      else
        legend(x = "left", legend = percentLabel, fill = colour, cex = textSize, ncol = 3)
    }
    else{
      stop("error: Unsupported graph type. Must be scatter or pie.")
    }
  }
}
