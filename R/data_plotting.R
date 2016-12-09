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
#' @keywords data,plot
#' @export
#' plotDataSet
plotDataSet <- function(x, y, xlabel, ylabel) {
  plot(x,y, xlab = xlabel, ylab = ylabel, type = "b", main = sprintf("%s over %s", ylabel, xlabel))

}
