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
    #axis(side = 1, cex = 0.5)#, at = x, cex = .1)
  }
  else if(plotTypeStr == "pie"){
    pie(y, main = sprintf("%s", y), labels =x)
  }
}
