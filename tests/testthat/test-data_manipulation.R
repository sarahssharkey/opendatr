library(testthat)
library(opendatr)
context("Data manipulation")

test_that("getCommonDataVariables runs as expected", {
  #returns data from .JSON-Stat file
  test_1 <- names("a","b","c")
  test_2 <- names("b","c")
  expect_equal(getCommonDataVariables(test_1, test_2) ["b","c"])

})
