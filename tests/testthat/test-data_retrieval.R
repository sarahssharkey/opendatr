library(testthat)
library(opendatr)
context("Data retrieval")

test_that("getJSONStatData runs as expected", {
    data <- getJSONStatData("json_with_extension.json")
    
    #returns the right names
    expect_equivalent(names(data), c("Sex","Year","Statistic","value"))
    #returns the right rows
    expect_equivalent(data[4,]$Sex, "Both sexes")
    expect_equivalent(data[4,]$Year, "2015")
    expect_equivalent(data[4,]$Statistic, "Persons who had blood sugar measured (%)")
    #Gives an error if not a .JSON-Stat file??
    expect_error(getJSONStatData("csv_with_extension.csv"))
})

test_that("getCSVData runs as expected", {
    data <- getCSVData("csv_with_extension.csv")
    
    #returns the right names
    expect_equivalent(names(data), c("X_id","identifier","name","spaces","free_spaces","opening_times","latitude","longitude","date"))
    #returns the right rows
    expect_equivalent(data[4,]$X_id, 5)
    expect_equivalent(data[4,]$identifier, 101)
    expect_equivalent(data[4,]$free_spaces, 266)
    #Gives an error if not a .csv file??
    expect_error(getCSVData("json_with_extension.json"), "error: dataURL passed must be a csv")
})

test_that("getDataSet runs as expected", {
    csv_with_extension_data <- getCSVData("csv_with_extension.csv")
    json_with_extension_data <- getJSONStatData ("json_with_extension.json")
    csv_without_extension_data <- getCSVData("csv_without_extension")
    json_without_extension_data <- fromJSONstat("json_without_extension")
    
    #returns data from CSV file without extension
    expect_equivalent(getDataSet("csv_without_extension"), csv_without_extension_data)
    #returns data from CSV file with extension
    expect_equivalent(getDataSet("csv_with_extension.csv"), csv_with_extension_data)
    #returns data from JSON-Stat file without extension.
    expect_equivalent(getDataSet("json_without_extension"), json_without_extension_data)
    #returns data from JSON-Stat file with extension.
    expect_equivalent(getDataSet("json_with_extension.json"), json_with_extension_data)
    #Gives an error if not csv or JSON-Stat file??
    expect_error(getDataSet("xml_file.xml"), "error: dataURL passed must be a csv or json.")
})
