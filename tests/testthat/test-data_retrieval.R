library(testthat)
library(opendatr)
context("Data retrieval")

test_that("getJSONStatData runs as expected", {
    data <- getJSONStatData("json_with_extension.json")
    
    #returns the right names
    expect_equivalent(names(data), c("Sex","Year","Statistic","value"))
    #returns the right rows
    expect_equivalent(as.character(data[4,]$Sex), "Both sexes")
    expect_equivalent(as.character(data[4,]$Year), "2015")
    expect_equivalent(as.character(data[4,]$Statistic), "Persons who had blood sugar measured (%)")
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

test_that("getDataset runs as expected", {
    csv_with_extension_data <- getCSVData("csv_with_extension.csv")
    json_with_extension_data <- getJSONStatData ("json_with_extension.json")
    csv_without_extension_data <- getCSVData("http://data.corkcity.ie/datastore/dump/c8735eb1-6da3-4dbd-9541-8995ba36a424")
    json_without_extension_data <- getJSONStatData("json_without_extension")
    
    #returns data from JSON-Stat file with extension.
    expect_equivalent(getDataset("json_with_extension.json"), json_with_extension_data)
    #returns data from CSV file with extension
    expect_equivalent(getDataset("csv_with_extension.csv"), csv_with_extension_data)
    #returns data from JSON-Stat file without extension.
    expect_equivalent(getDataset("http://www.cso.ie/StatbankServices/StatbankServices.svc/jsonservice/responseinstance/IH060"), json_without_extension_data)
    #returns data from CSV file without extension
    expect_equivalent(getDataset("http://data.corkcity.ie/datastore/dump/c8735eb1-6da3-4dbd-9541-8995ba36a424"), csv_without_extension_data)
    #Gives an error if not csv or JSON-Stat file??
    expect_error(getDataset("http://www.npws.ie/sites/default/files/publications/pdf/IWM46.pdf"), "error: dataURL passed must be a csv or json.")
})
