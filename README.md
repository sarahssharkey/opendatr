# opendatr
OpenData Visualisation Library for R

opendatr required has the following features:

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
