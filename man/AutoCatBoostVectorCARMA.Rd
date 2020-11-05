% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AutoCatBoostVectorCARMA.R
\name{AutoCatBoostVectorCARMA}
\alias{AutoCatBoostVectorCARMA}
\title{AutoCatBoostVectorCARMA}
\usage{
AutoCatBoostVectorCARMA(
  data,
  NonNegativePred = FALSE,
  RoundPreds = FALSE,
  TrainOnFull = FALSE,
  TargetColumnName = "Target",
  DateColumnName = "DateTime",
  HierarchGroups = NULL,
  GroupVariables = NULL,
  FC_Periods = 30,
  TimeUnit = "week",
  TimeGroups = c("weeks", "months"),
  NumOfParDepPlots = 10L,
  TargetTransformation = FALSE,
  Methods = c("BoxCox", "Asinh", "Asin", "Log", "LogPlus1", "Logit", "YeoJohnson"),
  AnomalyDetection = NULL,
  XREGS = NULL,
  Lags = c(1L:5L),
  MA_Periods = c(2L:5L),
  SD_Periods = NULL,
  Skew_Periods = NULL,
  Kurt_Periods = NULL,
  Quantile_Periods = NULL,
  Quantiles_Selected = c("q5", "q95"),
  Difference = TRUE,
  FourierTerms = 6L,
  CalendarVariables = c("second", "minute", "hour", "wday", "mday", "yday", "week",
    "isoweek", "month", "quarter", "year"),
  HolidayVariable = c("USPublicHolidays", "EasterGroup", "ChristmasGroup",
    "OtherEcclesticalFeasts"),
  HolidayLags = 1L,
  HolidayMovingAverages = 1L:2L,
  TimeTrendVariable = FALSE,
  ZeroPadSeries = NULL,
  DataTruncate = FALSE,
  SplitRatios = c(0.7, 0.2, 0.1),
  TaskType = "GPU",
  NumGPU = 1,
  EvalMetric = "RMSE",
  EvalMetricValue = 1.5,
  LossFunction = "RMSE",
  LossFunctionValue = 1.5,
  GridTune = FALSE,
  PassInGrid = NULL,
  ModelCount = 100,
  MaxRunsWithoutNewWinner = 50,
  MaxRunMinutes = 24L * 60L,
  NTrees = 1000,
  L2_Leaf_Reg = 3,
  RandomStrength = 1,
  BorderCount = 254,
  Depth = 6,
  BootStrapType = c("Bayesian", "Bernoulli", "Poisson", "MVS", "No"),
  PartitionType = "timeseries",
  Timer = TRUE,
  DebugMode = FALSE
)
}
\arguments{
\item{data}{Supply your full series data set here}

\item{NonNegativePred}{TRUE or FALSE}

\item{RoundPreds}{Rounding predictions to an integer value. TRUE or FALSE. Defaults to FALSE}

\item{TrainOnFull}{Set to TRUE to train on full data}

\item{TargetColumnName}{List the column names of your target variables column. E.g. c("Target1","Target2", ..., "TargetN")}

\item{DateColumnName}{List the column name of your date column. E.g. "DateTime"}

\item{HierarchGroups}{Vector of hierachy categorical columns.}

\item{GroupVariables}{Defaults to NULL. Use NULL when you have a single series. Add in GroupVariables when you have a series for every level of a group or multiple groups.}

\item{FC_Periods}{Set the number of periods you want to have forecasts for. E.g. 52 for weekly data to forecast a year ahead}

\item{TimeUnit}{List the time unit your data is aggregated by. E.g. "1min", "5min", "10min", "15min", "30min", "hour", "day", "week", "month", "quarter", "year".}

\item{TimeGroups}{Select time aggregations for adding various time aggregated GDL features.}

\item{NumOfParDepPlots}{Supply a number for the number of partial dependence plots you want returned}

\item{TargetTransformation}{Run AutoTransformationCreate() to find best transformation for the target variable. Tests YeoJohnson, BoxCox, and Asigh (also Asin and Logit for proportion target variables).}

\item{Methods}{Transformation options to test which include "BoxCox", "Asinh", "Asin", "Log", "LogPlus1", "Logit", "YeoJohnson"}

\item{AnomalyDetection}{NULL for not using the service. Other, provide a list, e.g. AnomalyDetection = list("tstat_high" = 4, tstat_low = -4)}

\item{XREGS}{Additional data to use for model development and forecasting. Data needs to be a complete series which means both the historical and forward looking values over the specified forecast window needs to be supplied.}

\item{Lags}{Select the periods for all lag variables you want to create. E.g. c(1:5,52)}

\item{MA_Periods}{Select the periods for all moving average variables you want to create. E.g. c(1:5,52)}

\item{SD_Periods}{Select the periods for all moving standard deviation variables you want to create. E.g. c(1:5,52)}

\item{Skew_Periods}{Select the periods for all moving skewness variables you want to create. E.g. c(1:5,52)}

\item{Kurt_Periods}{Select the periods for all moving kurtosis variables you want to create. E.g. c(1:5,52)}

\item{Quantile_Periods}{Select the periods for all moving quantiles variables you want to create. E.g. c(1:5,52)}

\item{Quantiles_Selected}{Select from the following "q5", "q10", "q15", "q20", "q25", "q30", "q35", "q40", "q45", "q50", "q55", "q60", "q65", "q70", "q75", "q80", "q85", "q90", "q95"}

\item{Difference}{Puts the I in ARIMA for single series and grouped series.}

\item{FourierTerms}{Set to the max number of pairs. E.g. 2 means to generate two pairs for by each group level and interations if hierarchy is enabled.}

\item{CalendarVariables}{NULL, or select from "second", "minute", "hour", "wday", "mday", "yday", "week", "isoweek", "month", "quarter", "year"}

\item{HolidayVariable}{NULL, or select from "USPublicHolidays", "EasterGroup", "ChristmasGroup", "OtherEcclesticalFeasts"}

\item{HolidayLags}{Number of lags to build off of the holiday count variable.}

\item{HolidayMovingAverages}{Number of moving averages to build off of the holiday count variable.}

\item{TimeTrendVariable}{Set to TRUE to have a time trend variable added to the model. Time trend is numeric variable indicating the numeric value of each record in the time series (by group). Time trend starts at 1 for the earliest point in time and increments by one for each success time point.}

\item{ZeroPadSeries}{Set to "all", "inner", or NULL. See TimeSeriesFill for explanation}

\item{DataTruncate}{Set to TRUE to remove records with missing values from the lags and moving average features created}

\item{SplitRatios}{E.g c(0.7,0.2,0.1) for train, validation, and test sets}

\item{TaskType}{Has to CPU for now. If catboost makes GPU available for "MultiRMSE" then it will be enabled. If you set to GPU the function will coerce it back to CPU.}

\item{NumGPU}{Defaults to 1. If CPU is set this argument will be ignored.}

\item{EvalMetric}{"MultiRMSE" only. If catboost updates this I'll add more later}

\item{EvalMetricValue}{Placeholder for later}

\item{LossFunction}{"MultiRMSE" only. If catboost updates this I'll add more later}

\item{LossFunctionValue}{Placeholder for later}

\item{GridTune}{Set to TRUE to run a grid tune}

\item{PassInGrid}{Defaults to NULL}

\item{ModelCount}{Set the number of models to try in the grid tune}

\item{MaxRunsWithoutNewWinner}{Default is 50}

\item{MaxRunMinutes}{Default is 60*60}

\item{NTrees}{Select the number of trees you want to have built to train the model}

\item{L2_Leaf_Reg}{l2 reg parameter}

\item{RandomStrength}{Default is 1}

\item{BorderCount}{Default is 254}

\item{Depth}{Depth of catboost model}

\item{BootStrapType}{Select from Catboost list}

\item{PartitionType}{Select "random" for random data partitioning "timeseries" for partitioning by time frames}

\item{Timer}{Set to FALSE to turn off the updating print statements for progress}

\item{DebugMode}{Defaults to FALSE. Set to TRUE to get a print statement of each high level comment in function}
}
\value{
Returns a data.table of original series and forecasts, the catboost model objects (everything returned from AutoCatBoostRegression()), a time series forecast plot, and transformation info if you set TargetTransformation to TRUE. The time series forecast plot will plot your single series or aggregate your data to a single series and create a plot from that.
}
\description{
AutoCatBoostVectorCARMA Multiple Regression, Mutlivariate Forecasting with calendar variables, Holiday counts, holiday lags, holiday moving averages, differencing, transformations, interaction-based categorical encoding using target variable and features to generate various time-based aggregated lags, moving averages, moving standard deviations, moving skewness, moving kurtosis, moving quantiles, parallelized interaction-based fourier pairs by grouping variables, and Trend Variables.
}
\examples{
\dontrun{

 # Single group variable and xregs ----

 # Load Walmart Data from Dropbox----
 data <- data.table::fread(
   "https://www.dropbox.com/s/2str3ek4f4cheqi/walmart_train.csv?dl=1")

 # Subset for Stores / Departments With Full Series
 data <- data[, Counts := .N, by = c("Store","Dept")][Counts == 143][
   , Counts := NULL]

 # Subset Columns (remove IsHoliday column)----
 keep <- c("Store","Dept","Date","Weekly_Sales")
 data <- data[, ..keep]
 data <- data[Store == 1][, Store := NULL]
 xregs <- data.table::copy(data)
 data.table::setnames(xregs, "Dept", "GroupVar")
 data.table::setnames(xregs, "Weekly_Sales", "Other")
 data <- data[as.Date(Date) < as.Date('2012-09-28')]

 # Build forecast
 CatBoostResults <- RemixAutoML::AutoCatBoostVectorCARMA(

  # data args
  data = data, # TwoGroup_Data,
  TargetColumnName = "Weekly_Sales",
  DateColumnName = "Date",
  HierarchGroups = NULL,
  GroupVariables = c("Dept"),
  TimeUnit = "weeks",
  TimeGroups = c("weeks","months"),

  # Production args
  TrainOnFull = FALSE,
  SplitRatios = c(1 - 10 / 138, 10 / 138),
  PartitionType = "random",
  FC_Periods = 4,
  Timer = TRUE,
  DebugMode = TRUE,

  # Target transformations
  TargetTransformation = TRUE,
  Methods = c("BoxCox", "Asinh", "Asin", "Log",
    "LogPlus1", "Logit", "YeoJohnson"),
  Difference = FALSE,
  NonNegativePred = FALSE,
  RoundPreds = FALSE,

  # Date features
  CalendarVariables = c("week", "month", "quarter"),
  HolidayVariable = c("USPublicHolidays",
    "EasterGroup",
    "ChristmasGroup","OtherEcclesticalFeasts"),
  HolidayLags = 1,
  HolidayMovingAverages = 1:2,

  # Time series features
  Lags = list("weeks" = seq(2L, 10L, 2L),
    "months" = c(1:3)),
  MA_Periods = list("weeks" = seq(2L, 10L, 2L),
    "months" = c(2,3)),
  SD_Periods = NULL,
  Skew_Periods = NULL,
  Kurt_Periods = NULL,
  Quantile_Periods = NULL,
  Quantiles_Selected = c("q5","q95"),

  # Bonus features
  AnomalyDetection = NULL,
  XREGS = xregs,
  FourierTerms = 2,
  TimeTrendVariable = TRUE,
  ZeroPadSeries = NULL,
  DataTruncate = FALSE,

  # ML Args
  NumOfParDepPlots = 100L,
  EvalMetric = "RMSE",
  EvalMetricValue = 1.5,
  LossFunction = "RMSE",
  LossFunctionValue = 1.5,
  GridTune = FALSE,
  PassInGrid = NULL,
  ModelCount = 5,
  TaskType = "GPU",
  NumGPU = 1,
  MaxRunsWithoutNewWinner = 50,
  MaxRunMinutes = 60*60,
  NTrees = 2500,
  L2_Leaf_Reg = 3.0,
  RandomStrength = 1,
  BorderCount = 254,
  BootStrapType = c("Bayesian", "Bernoulli", "Poisson", "MVS", "No"),
  Depth = 6)

# Two group variables and xregs

# Load Walmart Data from Dropbox----
data <- data.table::fread(
 "https://www.dropbox.com/s/2str3ek4f4cheqi/walmart_train.csv?dl=1")

# Subset for Stores / Departments With Full Series
data <- data[, Counts := .N, by = c("Store","Dept")][Counts == 143][
  , Counts := NULL]

# Subset Columns (remove IsHoliday column)----
keep <- c("Store","Dept","Date","Weekly_Sales")
data <- data[, ..keep]
data <- data[Store \%in\% c(1,2)]

xregs <- data.table::copy(data)
xregs[, GroupVar := do.call(paste, c(.SD, sep = " ")), .SDcols = c("Store","Dept")]
xregs[, c("Store","Dept") := NULL]
data.table::setnames(xregs, "Weekly_Sales", "Other")
xregs[, Other := jitter(Other, factor = 25)]
data <- data[as.Date(Date) < as.Date('2012-09-28')]

# Build forecast
CatBoostResults <- RemixAutoML::AutoCatBoostVectorCARMA(

  # data args
  data = data, # TwoGroup_Data,
  TargetColumnName = "Weekly_Sales",
  DateColumnName = "Date",
  HierarchGroups = NULL,
  GroupVariables = c("Store","Dept"),
  TimeUnit = "weeks",
  TimeGroups = c("weeks","months"),

  # Production args
  TrainOnFull = TRUE,
  SplitRatios = c(1 - 10 / 138, 10 / 138),
  PartitionType = "random",
  FC_Periods = 4,
  Timer = TRUE,
  DebugMode = TRUE,

  # Target transformations
  TargetTransformation = TRUE,
  Methods = c("BoxCox", "Asinh", "Asin", "Log",
              "LogPlus1", "Logit", "YeoJohnson"),
  Difference = FALSE,
  NonNegativePred = FALSE,
  RoundPreds = FALSE,

  # Date features
  CalendarVariables = c("week", "month", "quarter"),
  HolidayVariable = c("USPublicHolidays",
                      "EasterGroup",
                      "ChristmasGroup","OtherEcclesticalFeasts"),
  HolidayLags = 1,
  HolidayMovingAverages = 1:2,

  # Time series features
  Lags = list("weeks" = seq(2L, 10L, 2L),
              "months" = c(1:3)),
  MA_Periods = list("weeks" = seq(2L, 10L, 2L),
                    "months" = c(2,3)),
  SD_Periods = NULL,
  Skew_Periods = NULL,
  Kurt_Periods = NULL,
  Quantile_Periods = NULL,
  Quantiles_Selected = c("q5","q95"),

  # Bonus features
  AnomalyDetection = NULL,
  XREGS = xregs,
  FourierTerms = 2,
  TimeTrendVariable = TRUE,
  ZeroPadSeries = NULL,
  DataTruncate = FALSE,

  # ML Args
  NumOfParDepPlots = 100L,
  EvalMetric = "RMSE",
  EvalMetricValue = 1.5,
  LossFunction = "RMSE",
  LossFunctionValue = 1.5,
  GridTune = FALSE,
  PassInGrid = NULL,
  ModelCount = 5,
  TaskType = "GPU",
  NumGPU = 1,
  MaxRunsWithoutNewWinner = 50,
  MaxRunMinutes = 60*60,
  NTrees = 2500,
  L2_Leaf_Reg = 3.0,
  RandomStrength = 1,
  BorderCount = 254,
  BootStrapType = c("Bayesian", "Bernoulli", "Poisson", "MVS", "No"),
  Depth = 6)
}
}
\seealso{
Other Automated Panel Data Forecasting: 
\code{\link{AutoCatBoostCARMA}()},
\code{\link{AutoH2OCARMA}()},
\code{\link{AutoHurdleCARMA}()},
\code{\link{AutoXGBoostCARMA}()}
}
\author{
Adrian Antico
}
\concept{Automated Panel Data Forecasting}