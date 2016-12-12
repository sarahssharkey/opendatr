library(testthat)
library(opendatr)
context("Data manipulation")

test_that("getCommonDataVariables runs as expected for 1D", {
    test_1 <- c("x","y","z")
    test_2 <- c("x","y")
    names(test_1) <- c("a","b","c")
    names(test_2) <- c("b","c")
    test_list <- list(test_1,test_2)
    common <- c("b","c")
    result <- getCommonDataVariables(test_list)
    expect_equivalent(result, common)
})

test_that("getCommonDataVariables runs as expected for 2D", {
    test_list <- list(women,PlantGrowth)
    result <- getCommonDataVariables(test_list)
    expect_equivalent(result,c("weight"))
})

test_that("getCommonDataVariables runs as expected for 1D odd no. datasets", {
    test_1 <- c("x","y","z")
    test_2 <- c("x","y")
    test_3 <- c("blah","blahs","wow")
    names(test_1) <- c("a","b","c")
    names(test_2) <- c("b","c")
    names(test_3) <- c("c","d","e")
    test_list <- list(test_1, test_2, test_3)
    common <- c("c")
    result <- getCommonDataVariables(test_list)
    expect_equivalent(result, common)
})
