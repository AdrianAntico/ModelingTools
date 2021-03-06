% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AutoCatBoostHurdleCARMA.R
\name{AutoCatBoostHurdleCARMA}
\alias{AutoCatBoostHurdleCARMA}
\title{AutoCatBoostHurdleCARMA}
\usage{
AutoCatBoostHurdleCARMA(
  data,
  NonNegativePred = FALSE,
  Threshold = NULL,
  RoundPreds = FALSE,
  TrainOnFull = FALSE,
  TargetColumnName = "Target",
  DateColumnName = "DateTime",
  HierarchGroups = NULL,
  GroupVariables = NULL,
  TimeWeights = 1,
  FC_Periods = 30,
  TimeUnit = "week",
  TimeGroups = c("weeks", "months"),
  NumOfParDepPlots = 10L,
  TargetTransformation = FALSE,
  Methods = c("BoxCox", "Asinh", "Log", "LogPlus1", "Sqrt", "Asin", "Logit"),
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
    "wom", "isoweek", "month", "quarter", "year"),
  HolidayVariable = c("USPublicHolidays", "EasterGroup", "ChristmasGroup",
    "OtherEcclesticalFeasts"),
  HolidayLookback = NULL,
  HolidayLags = 1L,
  HolidayMovingAverages = 1L:2L,
  TimeTrendVariable = FALSE,
  ZeroPadSeries = NULL,
  DataTruncate = FALSE,
  SplitRatios = c(0.7, 0.2, 0.1),
  PartitionType = "timeseries",
  Timer = TRUE,
  DebugMode = FALSE,
  TaskType = "GPU",
  NumGPU = 1,
  EvalMetric = "RMSE",
  GridTune = FALSE,
  PassInGrid = NULL,
  ModelCount = 100,
  MaxRunsWithoutNewWinner = 50,
  MaxRunMinutes = 24L * 60L,
  NTrees = list(classifier = 200, regression = 200),
  Depth = list(classifier = 9, regression = 9),
  LearningRate = list(classifier = NULL, regression = NULL),
  L2_Leaf_Reg = list(classifier = NULL, regression = NULL),
  RandomStrength = list(classifier = 1, regression = 1),
  BorderCount = list(classifier = 254, regression = 254),
  BootStrapType = list(classifier = "Bayesian", regression = "Bayesian")
)
}
\arguments{
\item{data}{Supply your full series data set here}

\item{NonNegativePred}{TRUE or FALSE}

\item{Threshold}{Select confusion matrix measure to optimize for pulling in threshold. Choose from 'MCC', 'Acc', 'TPR', 'TNR', 'FNR', 'FPR', 'FDR', 'FOR', 'F1_Score', 'F2_Score', 'F0.5_Score', 'NPV', 'PPV', 'ThreatScore', 'Utility'}

\item{RoundPreds}{Rounding predictions to an integer value. TRUE or FALSE. Defaults to FALSE}

\item{TrainOnFull}{Set to TRUE to train on full data}

\item{TargetColumnName}{List the column name of your target variables column. E.g. 'Target'}

\item{DateColumnName}{List the column name of your date column. E.g. 'DateTime'}

\item{HierarchGroups}{Vector of hierachy categorical columns.}

\item{GroupVariables}{Defaults to NULL. Use NULL when you have a single series. Add in GroupVariables when you have a series for every level of a group or multiple groups.}

\item{TimeWeights}{Timeweights creation. Supply a value, such as 0.9999}

\item{FC_Periods}{Set the number of periods you want to have forecasts for. E.g. 52 for weekly data to forecast a year ahead}

\item{TimeUnit}{List the time unit your data is aggregated by. E.g. '1min', '5min', '10min', '15min', '30min', 'hour', 'day', 'week', 'month', 'quarter', 'year'.}

\item{TimeGroups}{Select time aggregations for adding various time aggregated GDL features.}

\item{NumOfParDepPlots}{Supply a number for the number of partial dependence plots you want returned}

\item{TargetTransformation}{Run AutoTransformationCreate() to find best transformation for the target variable. Tests YeoJohnson, BoxCox, and Asigh (also Asin and Logit for proportion target variables).}

\item{Methods}{Choose from 'YeoJohnson', 'BoxCox', 'Asinh', 'Log', 'LogPlus1', 'Sqrt', 'Asin', or 'Logit'. If more than one is selected, the one with the best normalization pearson statistic will be used. Identity is automatically selected and compared.}

\item{AnomalyDetection}{NULL for not using the service. Other, provide a list, e.g. AnomalyDetection = list('tstat_high' = 4, tstat_low = -4)}

\item{XREGS}{Additional data to use for model development and forecasting. Data needs to be a complete series which means both the historical and forward looking values over the specified forecast window needs to be supplied.}

\item{Lags}{Select the periods for all lag variables you want to create. E.g. c(1:5,52)}

\item{MA_Periods}{Select the periods for all moving average variables you want to create. E.g. c(1:5,52)}

\item{SD_Periods}{Select the periods for all moving standard deviation variables you want to create. E.g. c(1:5,52)}

\item{Skew_Periods}{Select the periods for all moving skewness variables you want to create. E.g. c(1:5,52)}

\item{Kurt_Periods}{Select the periods for all moving kurtosis variables you want to create. E.g. c(1:5,52)}

\item{Quantile_Periods}{Select the periods for all moving quantiles variables you want to create. E.g. c(1:5,52)}

\item{Quantiles_Selected}{Select from the following 'q5', 'q10', 'q15', 'q20', 'q25', 'q30', 'q35', 'q40', 'q45', 'q50', 'q55', 'q60', 'q65', 'q70', 'q75', 'q80', 'q85', 'q90', 'q95'}

\item{Difference}{Puts the I in ARIMA for single series and grouped series.}

\item{FourierTerms}{Set to the max number of pairs. E.g. 2 means to generate two pairs for by each group level and interations if hierarchy is enabled.}

\item{CalendarVariables}{NULL, or select from 'second', 'minute', 'hour', 'wday', 'mday', 'yday', 'week', 'isoweek', 'month', 'quarter', 'year'}

\item{HolidayVariable}{NULL, or select from 'USPublicHolidays', 'EasterGroup', 'ChristmasGroup', 'OtherEcclesticalFeasts'}

\item{HolidayLookback}{Number of days in range to compute number of holidays from a given date in the data. If NULL, the number of days are computed for you.}

\item{HolidayLags}{Number of lags to build off of the holiday count variable.}

\item{HolidayMovingAverages}{Number of moving averages to build off of the holiday count variable.}

\item{TimeTrendVariable}{Set to TRUE to have a time trend variable added to the model. Time trend is numeric variable indicating the numeric value of each record in the time series (by group). Time trend starts at 1 for the earliest point in time and increments by one for each success time point.}

\item{ZeroPadSeries}{Set to 'all', 'inner', or NULL. See TimeSeriesFill for explanation}

\item{DataTruncate}{Set to TRUE to remove records with missing values from the lags and moving average features created}

\item{SplitRatios}{E.g c(0.7,0.2,0.1) for train, validation, and test sets}

\item{PartitionType}{Select 'random' for random data partitioning 'timeseries' for partitioning by time frames}

\item{Timer}{Set to FALSE to turn off the updating print statements for progress}

\item{DebugMode}{Defaults to FALSE. Set to TRUE to get a print statement of each high level comment in function}

\item{TaskType}{Default is 'GPU' but you can also set it to 'CPU'}

\item{NumGPU}{Defaults to 1. If CPU is set this argument will be ignored.}

\item{EvalMetric}{Select from 'RMSE', 'MAE', 'MAPE', 'Poisson', 'Quantile', 'LogLinQuantile', 'Lq', 'NumErrors', 'SMAPE', 'R2', 'MSLE', 'MedianAbsoluteError'}

\item{GridTune}{Set to TRUE to run a grid tune}

\item{PassInGrid}{Defaults to NULL}

\item{ModelCount}{Set the number of models to try in the grid tune}

\item{MaxRunsWithoutNewWinner}{Default is 50}

\item{MaxRunMinutes}{Default is 60*60}

\item{NTrees}{Select the number of trees you want to have built to train the model}

\item{Depth}{Depth of catboost model}

\item{LearningRate}{learning_rate}

\item{L2_Leaf_Reg}{l2 reg parameter}

\item{RandomStrength}{Default is 1}

\item{BorderCount}{Default is 254}

\item{BootStrapType}{Select from Catboost list}
}
\value{
Returns a data.table of original series and forecasts, the catboost model objects (everything returned from AutoCatBoostRegression()), a time series forecast plot, and transformation info if you set TargetTransformation to TRUE. The time series forecast plot will plot your single series or aggregate your data to a single series and create a plot from that.
}
\description{
AutoCatBoostHurdleCARMA is an intermittent demand, Mutlivariate Forecasting algorithms with calendar variables, Holiday counts, holiday lags, holiday moving averages, differencing, transformations, interaction-based categorical encoding using target variable and features to generate various time-based aggregated lags, moving averages, moving standard deviations, moving skewness, moving kurtosis, moving quantiles, parallelized interaction-based fourier pairs by grouping variables, and Trend Variables.
}
\examples{
\dontrun{

 # Single group variable and xregs ----

 # Load Walmart Data from Dropbox----
 data <- data.table::fread(
   'https://www.dropbox.com/s/2str3ek4f4cheqi/walmart_train.csv?dl=1')

 # Subset for Stores / Departments With Full Series
 data <- data[, Counts := .N, by = c('Store','Dept')][Counts == 143][
   , Counts := NULL]

 # Subset Columns (remove IsHoliday column)----
 keep <- c('Store','Dept','Date','Weekly_Sales')
 data <- data[, ..keep]
 data <- data[Store == 1][, Store := NULL]
 xregs <- data.table::copy(data)
 data.table::setnames(xregs, 'Dept', 'GroupVar')
 data.table::setnames(xregs, 'Weekly_Sales', 'Other')
 data <- data[as.Date(Date) < as.Date('2012-09-28')]

 # Add zeros for testing
 data[runif(.N) < 0.25, Weekly_Sales := 0]

 # Build forecast
 CatBoostResults <- RemixAutoML::AutoCatBoostHurdleCARMA(

  # data args
  data = data, # TwoGroup_Data,
  TargetColumnName = 'Weekly_Sales',
  DateColumnName = 'Date',
  HierarchGroups = NULL,
  GroupVariables = c('Dept'),
  TimeWeights = 1,
  TimeUnit = 'weeks',
  TimeGroups = c('weeks','months'),

  # Production args
  TrainOnFull = FALSE,
  SplitRatios = c(1 - 20 / 138, 10 / 138, 10 / 138),
  PartitionType = 'random',
  FC_Periods = 4,
  Timer = TRUE,
  DebugMode = TRUE,

  # Target transformations
  TargetTransformation = TRUE,
  Methods = c('BoxCox', 'Asinh', 'Asin', 'Log',
    'LogPlus1', 'Sqrt', 'Logit', 'YeoJohnson'),
  Difference = FALSE,
  NonNegativePred = FALSE,
  RoundPreds = FALSE,

  # Date features
  CalendarVariables = c('week', 'wom', 'month', 'quarter'),
  HolidayVariable = c('USPublicHolidays',
    'EasterGroup',
    'ChristmasGroup','OtherEcclesticalFeasts'),
  HolidayLookback = NULL,
  HolidayLags = 1,
  HolidayMovingAverages = 1:2,

  # Time series features
  Lags = list('weeks' = seq(2L, 10L, 2L),
    'months' = c(1:3)),
  MA_Periods = list('weeks' = seq(2L, 10L, 2L),
    'months' = c(2,3)),
  SD_Periods = NULL,
  Skew_Periods = NULL,
  Kurt_Periods = NULL,
  Quantile_Periods = NULL,
  Quantiles_Selected = c('q5','q95'),

  # Bonus features
  AnomalyDetection = NULL,
  XREGS = xregs,
  FourierTerms = 2,
  TimeTrendVariable = TRUE,
  ZeroPadSeries = NULL,
  DataTruncate = FALSE,

  # ML Args
  NumOfParDepPlots = 100L,
  EvalMetric = 'RMSE',
  GridTune = FALSE,
  PassInGrid = NULL,
  ModelCount = 5,
  TaskType = 'GPU',
  NumGPU = 1,
  MaxRunsWithoutNewWinner = 50,
  MaxRunMinutes = 60*60,
  NTrees = 2500,
  L2_Leaf_Reg = 3.0,
  LearningRate = list('classifier' = seq(0.01,0.25,0.01), 'regression' = seq(0.01,0.25,0.01)),
  RandomStrength = 1,
  BorderCount = 254,
  BootStrapType = c('Bayesian', 'Bernoulli', 'Poisson', 'MVS', 'No'),
  Depth = 6)

# Two group variables and xregs

# Load Walmart Data from Dropbox----
data <- data.table::fread(
 'https://www.dropbox.com/s/2str3ek4f4cheqi/walmart_train.csv?dl=1')

# Subset for Stores / Departments With Full Series
data <- data[, Counts := .N, by = c('Store','Dept')][Counts == 143][
  , Counts := NULL]

# Put negative values at 0
data[, Weekly_Sales := data.table::fifelse(Weekly_Sales < 0, 0, Weekly_Sales)]

# Subset Columns (remove IsHoliday column)----
keep <- c('Store','Dept','Date','Weekly_Sales')
data <- data[, ..keep]
data <- data[Store \%in\% c(1,2)]

xregs <- data.table::copy(data)
xregs[, GroupVar := do.call(paste, c(.SD, sep = ' ')), .SDcols = c('Store','Dept')]
xregs[, c('Store','Dept') := NULL]
data.table::setnames(xregs, 'Weekly_Sales', 'Other')
xregs[, Other := jitter(Other, factor = 25)]
data <- data[as.Date(Date) < as.Date('2012-09-28')]

# Add some zeros for testing
data[runif(.N) < 0.25, Weekly_Sales := 0]

# Build forecast
Output <- RemixAutoML::AutoCatBoostHurdleCARMA(

  # data args
  data = data,
  TargetColumnName = 'Weekly_Sales',
  DateColumnName = 'Date',
  HierarchGroups = NULL,
  GroupVariables = c('Store','Dept'),
  TimeWeights = 1,
  TimeUnit = 'weeks',
  TimeGroups = c('weeks','months'),

  # Production args
  TrainOnFull = TRUE,
  SplitRatios = c(1 - 20 / 138, 10 / 138, 10 / 138),
  PartitionType = 'random',
  FC_Periods = 4,
  Timer = TRUE,
  DebugMode = TRUE,

  # Target transformations
  TargetTransformation = TRUE,
  Methods = c('BoxCox', 'Asinh', 'Asin', 'Log',
              'LogPlus1', 'Sqrt', 'Logit', 'YeoJohnson'),
  Difference = FALSE,
  NonNegativePred = FALSE,
  Threshold = NULL,
  RoundPreds = FALSE,

  # Date features
  CalendarVariables = c('week', 'wom', 'month', 'quarter'),
  HolidayVariable = c('USPublicHolidays',
                      'EasterGroup',
                      'ChristmasGroup','OtherEcclesticalFeasts'),
  HolidayLookback = NULL,
  HolidayLags = 1,
  HolidayMovingAverages = 1:2,

  # Time series features
  Lags = list('weeks' = seq(2L, 10L, 2L),
              'months' = c(1:3)),
  MA_Periods = list('weeks' = seq(2L, 10L, 2L),
                    'months' = c(2,3)),
  SD_Periods = NULL,
  Skew_Periods = NULL,
  Kurt_Periods = NULL,
  Quantile_Periods = NULL,
  Quantiles_Selected = c('q5','q95'),

  # Bonus features
  AnomalyDetection = NULL,
  XREGS = xregs,
  FourierTerms = 2,
  TimeTrendVariable = TRUE,
  ZeroPadSeries = NULL,
  DataTruncate = FALSE,

  # ML Args
  NumOfParDepPlots = 100L,
  EvalMetric = 'RMSE',
  GridTune = FALSE,
  PassInGrid = NULL,
  ModelCount = 5,
  TaskType = 'GPU',
  NumGPU = 1,
  MaxRunsWithoutNewWinner = 50,
  MaxRunMinutes = 60*60,
  NTrees = list('classifier' = 200, 'regression' = 200),
  Depth = list('classifier' = 9, 'regression' = 9),
  LearningRate = list('classifier' = NULL, 'regression' = NULL),
  L2_Leaf_Reg = list('classifier' = NULL, 'regression' = NULL),
  RandomStrength = list('classifier' = 1, 'regression' = 1),
  BorderCount = list('classifier' = 254, 'regression' = 254),
  BootStrapType = list('classifier' = 'Bayesian', 'regression' = 'Bayesian'))
}
}
\seealso{
Other Automated Panel Data Forecasting: 
\code{\link{AutoCatBoostCARMA}()},
\code{\link{AutoCatBoostVectorCARMA}()},
\code{\link{AutoH2OCARMA}()},
\code{\link{AutoLightGBMCARMA}()},
\code{\link{AutoLightGBMHurdleCARMA}()},
\code{\link{AutoXGBoostCARMA}()},
\code{\link{AutoXGBoostHurdleCARMA}()}
}
\author{
Adrian Antico
}
\concept{Automated Panel Data Forecasting}
