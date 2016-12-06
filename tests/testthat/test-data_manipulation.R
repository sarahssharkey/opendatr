library(testthat)
library(opendatr)
context("Data manipulation")

test_that("getCommonDataVariables runs as expected for 1D", {
  test_1 <- c("x","y","z")
  test_2 <- c("x","y")
  names(test_1) <- c("a","b","c")
  names(test_2) <- c("b","c")
  common <- c("b","c")
  result <- getCommonDataVariables(test_1, test_2)
  expect_equivalent(result, common)
})

test_that("getCommonDataVariables runs as expected for 2D", {
  result <- getCommonDataVariables(women,PlantGrowth)
  expect_equivalent(result,c("weight"))
})

test_that("getCommonDataVariables runs as expected for 1D odd no. datasets", {
  test_1 <- c("x","y","z")
  test_2 <- c("x","y")
  test_3 <- c("blah","blahs","wow")
  names(test_1) <- c("a","b","c")
  names(test_2) <- c("b","c")
  names(test_3) <- c("c","d","e")

  common <- c("c")
  result <- getCommonDataVariables(test_1, test_2, test_3)
  expect_equivalent(result, common)
})