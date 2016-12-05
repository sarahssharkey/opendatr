library(testthat)
library(opendatr)
context("Data retrieval")

test_that("getJSONStatData runs as expected", {
    #returns data from .JSON-Stat file
    expect_equal(getJSONStatData("some url"), the_expected_data)
    #Gives an error if not a .JSON-Stat file??
    expect_error(getJSONStatData("some url"), "??Expected JSON-Stat file type maybe??")
})

test_that("getCSVData runs as expected", {
    #returns data from .csv file
    expect_equal(getCSVData("some url"), the_expected_data)
    #Gives an error if not a .csv file??
    expect_error(getCSVData("some url"), "??Expected CSV file type maybe??")
})

test_that("getDataSet runs as expected", {
    #returns data from CSV file without extension
    expect_equal(getDataSet("some url"), the_expected_data)
    #returns data from CSV file with extension
    expect_equal(getDataSet("some url.CSV"), the_expected_data)
    #returns data from JSON-Stat file without extension.
    expect_equal(getDataSet("http:#www.cso.ie/StatbankServices/StatbankServices.svc/jsonservice/responseinstance/IH060"), the_expected_data)
    #returns data from JSON-Stat file with extension.
    expect_equal(getDataSet("some url.JSON"), the_expected_data)
    #Gives an error if not csv or JSON-Stat file??
    expect_error(getDataSet("some url"), "error: dataURL passed must be a csv or json.")
})
