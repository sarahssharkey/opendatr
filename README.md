# opendatr
OpenData Visualisation Library for R

opendatr has the following features:

1. Download opendata in csv format from a given user-specified url

2. Download opendata in json format from a given user-specified url

3. Find common data variables (by name) present in multiple datasets and visualize relationships between variables, across datasets(e.g., trend of home-ownership versus trend of crime-rate, across counties.)

### Installation:


[From github](github.com/sarahssharkey/opendatr) (development version):

```s
library(devtools)
install_github("sarahssharkey/opendatr")
```

### Usage:

```s
library(opendatr)

# Read CSV or JSON-Stat data  
crimeData <- getDataset("http://www.cso.ie/StatbankServices/StatbankServices.svc/jsonservice/responseinstance/CJA07")

# Get information on datasets, the various levels of columns that are factors and common variables between them

datasetInfo <- getDatasetInfo(

# Datasets can be remote URLs of CSV or JSON-Stat data or datasets in the current environment

"http://www.cso.ie/StatbankServices/StatbankServices.svc/jsonservice/responseinstance/HSA01", 
"http://www.cso.ie/StatbankServices/StatbankServices.svc/jsonservice/responseinstance/CNKL1", 
crimeData)

# Can use information given to plot graph(s) of choice

plotDatasets(

# Datasets can be remote URLs of CSV or JSON-Stat data or datasets in the current environment

datasets = list("http://www.cso.ie/StatbankServices/StatbankServices.svc/jsonservice/responseinstance/HSA01", crimeData, "http://www.cso.ie/StatbankServices/StatbankServices.svc/jsonservice/responseinstance/CNKL1"),

# Specify the graph type scatter/pie for each dataset

graphTypes = list("scatter", "scatter", "pie"),

# Specify Year as the common variable in the data sets

commonVariable = "Year",
yAxis = list("value", "value", "value"),
# Specify level of factors to plot for each dataset, unselected factor levels will use all levels
factors = list(
	dataset0factors = list("Housing Sector" = "Private"),
	dataset1factors = list("Type of Offence" = "Robbery, extortion and hijacking offences"),
	dataset2factors = list()
),
xLabels = list("Year", "Year", "Year"),
yLabels = list("Number of House Completions", "Number of Crimes", "Employment"),
titles = list("House Completions in Private Sector per year", "Robbery, extortion and hijacking offences per year", "Employment per year"))

---------------------------------------------------------

datasetInfo <- getDatasetInfo("http://www.cso.ie/StatbankServices/StatbankServices.svc/jsonservice/responseinstance/ADM02", "http://www.cso.ie/StatbankServices/StatbankServices.svc/jsonservice/responseinstance/ADA01")

pigData <- datasetInfo[["datasets"]][[1]] 
animalData <- datasetInfo[["datasets"]][[2]]

plotDatasets(

datasets = list(pigData, animalData), 
graphTypes = list("scatter", "scatter"), 
commonVariable = list("Meat Usage", "Type of Animal"), 
yAxis = list("value", "value"), 
factors = list(
	dataset0factors = list(Month = "2002M01", Statistic = "Pigs Slaughtered (Number)"),
	dataset1factors = list(Year = "2002", Statistic = "Number of Animals Slaughtered (000 Head)")), 
xLabels = list("Type of Pig", "Type of Animal"), 
yLabels = list("Number of Pigs Slaughtered", "Number of Animals Slaughtered"), 
titles = list("Pigs Slaughtered in January 2002", "Animals Slaughtered in 2002"))
```

### Example:

Graphs and charts of the variables from the different datasets can be plotted  in a manner which makes it easy to see any relationships there might be between them.

Here is an example of how graphs & charts made using our package look. There is a decrease in crimes and rise of houses completed until both variables switch in 2006 when there was an economic crash. These variables were taken from different datasets.

![rplot02](https://cloud.githubusercontent.com/assets/16880181/21141652/44f65b70-c136-11e6-8eba-ace0bbf475d1.png)
