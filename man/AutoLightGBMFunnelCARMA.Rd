% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AutoLightGBMFunnel.R
\name{AutoLightGBMFunnelCARMA}
\alias{AutoLightGBMFunnelCARMA}
\title{AutoLightGBMFunnelCARMA}
\usage{
AutoLightGBMFunnelCARMA(
  data,
  GroupVariables = NULL,
  BaseFunnelMeasure = NULL,
  ConversionMeasure = NULL,
  ConversionRateMeasure = NULL,
  CohortPeriodsVariable = NULL,
  CalendarDate = NULL,
  CohortDate = NULL,
  EncodingMethod = "credibility",
  OutputSelection = c("Importances", "EvalPlots", "EvalMetrics", "Score_TrainData"),
  WeightsColumnName = NULL,
  TruncateDate = NULL,
  PartitionRatios = c(0.7, 0.2, 0.1),
  TimeUnit = c("day"),
  CalendarTimeGroups = c("day", "week", "month"),
  CohortTimeGroups = c("day", "week", "month"),
  TransformTargetVariable = TRUE,
  TransformMethods = c("Identity", "YeoJohnson"),
  AnomalyDetection = list(tstat_high = 3, tstat_low = -2),
  Jobs = c("Evaluate", "Train"),
  SaveModelObjects = TRUE,
  ModelID = "Segment_ID",
  ModelPath = NULL,
  MetaDataPath = NULL,
  DebugMode = FALSE,
  CalendarVariables = c("wday", "mday", "yday", "week", "isoweek", "month", "quarter",
    "year"),
  HolidayGroups = c("USPublicHolidays", "EasterGroup", "ChristmasGroup",
    "OtherEcclesticalFeasts"),
  HolidayLookback = NULL,
  CohortHolidayLags = c(1L, 2L, 7L),
  CohortHolidayMovingAverages = c(3L, 7L),
  CalendarHolidayLags = c(1L, 2L, 7L),
  CalendarHolidayMovingAverages = c(3L, 7L),
  ImputeRollStats = -0.001,
  CalendarLags = list(day = c(1L, 7L, 21L), week = c(1L, 4L, 52L), month = c(1L, 6L,
    12L)),
  CalendarMovingAverages = list(day = c(1L, 7L, 21L), week = c(1L, 4L, 52L), month =
    c(1L, 6L, 12L)),
  CalendarStandardDeviations = NULL,
  CalendarSkews = NULL,
  CalendarKurts = NULL,
  CalendarQuantiles = NULL,
  CalendarQuantilesSelected = "q50",
  CohortLags = list(day = c(1L, 7L, 21L), week = c(1L, 4L, 52L), month = c(1L, 6L,
    12L)),
  CohortMovingAverages = list(day = c(1L, 7L, 21L), week = c(1L, 4L, 52L), month =
    c(1L, 6L, 12L)),
  CohortStandardDeviations = NULL,
  CohortSkews = NULL,
  CohortKurts = NULL,
  CohortQuantiles = NULL,
  CohortQuantilesSelected = "q50",
  PassInGrid = NULL,
  GridTune = FALSE,
  BaselineComparison = "default",
  MaxModelsInGrid = 25L,
  MaxRunMinutes = 180L,
  MaxRunsWithoutNewWinner = 10L,
  LossFunction = "regression",
  EvalMetric = "mae",
  GridEvalMetric = "mae",
  NumOfParDepPlots = 1L,
  Device_Type = "CPU",
  Input_Model = NULL,
  Task = "train",
  Boosting = "gbdt",
  LinearTree = FALSE,
  Trees = 1000,
  ETA = 0.1,
  Num_Leaves = 31,
  Deterministic = TRUE,
  NThreads = parallel::detectCores()/2,
  SaveInfoToPDF = FALSE,
  Force_Col_Wise = FALSE,
  Force_Row_Wise = FALSE,
  Max_Depth = 6,
  Min_Data_In_Leaf = 20,
  Min_Sum_Hessian_In_Leaf = 0.001,
  Bagging_Freq = 1,
  Bagging_Fraction = 1,
  Feature_Fraction = 1,
  Feature_Fraction_Bynode = 1,
  Lambda_L1 = 0,
  Lambda_L2 = 0,
  Extra_Trees = FALSE,
  Early_Stopping_Round = 10,
  First_Metric_Only = TRUE,
  Max_Delta_Step = 0,
  Linear_Lambda = 0,
  Min_Gain_To_Split = 0,
  Drop_Rate_Dart = 0.1,
  Max_Drop_Dart = 50,
  Skip_Drop_Dart = 0.5,
  Uniform_Drop_Dart = FALSE,
  Top_Rate_Goss = FALSE,
  Other_Rate_Goss = FALSE,
  Monotone_Constraints = NULL,
  Monotone_Constraints_method = "advanced",
  Monotone_Penalty = 0,
  Forcedsplits_Filename = NULL,
  Refit_Decay_Rate = 0.9,
  Path_Smooth = 0,
  Max_Bin = 255,
  Min_Data_In_Bin = 3,
  Data_Random_Seed = 1,
  Is_Enable_Sparse = TRUE,
  Enable_Bundle = TRUE,
  Use_Missing = TRUE,
  Zero_As_Missing = FALSE,
  Two_Round = FALSE,
  Convert_Model = NULL,
  Convert_Model_Language = "cpp",
  Boost_From_Average = TRUE,
  Alpha = 0.9,
  Fair_C = 1,
  Poisson_Max_Delta_Step = 0.7,
  Tweedie_Variance_Power = 1.5,
  Lambdarank_Truncation_Level = 30,
  Is_Provide_Training_Metric = TRUE,
  Eval_At = c(1, 2, 3, 4, 5),
  Num_Machines = 1,
  Gpu_Platform_Id = -1,
  Gpu_Device_Id = -1,
  Gpu_Use_Dp = TRUE,
  Num_Gpu = 1
)
}
\arguments{
\item{data}{data object}

\item{BaseFunnelMeasure}{E.g. "Leads". This value should be a forward looking variable. Say you want to forecast ConversionMeasure 2 months into the future. You should have two months into the future of values of BaseFunnelMeasure}

\item{ConversionMeasure}{E.g. "Conversions". Rate is derived as conversions over leads by cohort periods out}

\item{ConversionRateMeasure}{Conversions over Leads for every cohort}

\item{CohortPeriodsVariable}{Numeric. Numerical value of the the number of periods since cohort base date.}

\item{CalendarDate}{The name of your date column that represents the calendar date}

\item{CohortDate}{The name of your date column that represents the cohort date}

\item{OutputSelection}{= c('Importances', 'EvalPlots', 'EvalMetrics', 'Score_TrainData')}

\item{WeightsColumnName}{= NULL}

\item{TruncateDate}{NULL. Supply a date to represent the earliest point in time you want in your data. Filtering takes place before partitioning data so feature engineering can include as many non null values as possible.}

\item{PartitionRatios}{Requires three values for train, validation, and test data sets}

\item{TimeUnit}{Base time unit of data. "days", "weeks", "months", "quarters", "years"}

\item{CalendarTimeGroups}{TimeUnit value must be included. If you want to generate lags and moving averages in several time based aggregations, choose from "days", "weeks", "months", "quarters", "years".}

\item{CohortTimeGroups}{TimeUnit value must be included. If you want to generate lags and moving averages in several time based aggregations, choose from "days", "weeks", "months", "quarters", "years".}

\item{TransformTargetVariable}{TRUE or FALSe}

\item{TransformMethods}{Choose from "Identity", "BoxCox", "Asinh", "Asin", "Log", "LogPlus1", "Logit", "YeoJohnson"}

\item{AnomalyDetection}{Provide a named list. See examples}

\item{Jobs}{Default is "eval" and "train"}

\item{SaveModelObjects}{Set to TRUE to return all modeling objects to your environment}

\item{ModelID}{A character string to name your model and output}

\item{ModelPath}{Path to where you want your models saved}

\item{MetaDataPath}{Path to where you want your metadata saved. If NULL, function will try ModelPath if it is not NULL.}

\item{DebugMode}{Internal use}

\item{CalendarVariables}{"wday", "mday", "yday", "week", "isoweek", "month", "quarter", "year"}

\item{HolidayGroups}{c("USPublicHolidays","EasterGroup","ChristmasGroup","OtherEcclesticalFeasts")}

\item{HolidayLookback}{Number of days in range to compute number of holidays from a given date in the data. If NULL, the number of days are computed for you.}

\item{CohortHolidayLags}{c(1L, 2L, 7L),}

\item{CohortHolidayMovingAverages}{c(3L, 7L),}

\item{CalendarHolidayLags}{c(1L, 2L, 7L),}

\item{CalendarHolidayMovingAverages}{= c(3L, 7L),}

\item{ImputeRollStats}{Constant value to fill NA after running AutoLagRollStats()}

\item{CalendarLags}{List of the form list("day" = c(1L, 7L, 21L), "week" = c(1L, 4L, 52L), "month" = c(1L, 6L, 12L))}

\item{CalendarMovingAverages}{List of the form list("day" = c(1L, 7L, 21L), "week" = c(1L, 4L, 52L), "month" = c(1L, 6L, 12L))}

\item{CalendarStandardDeviations}{List of the form list("day" = c(1L, 7L, 21L), "week" = c(1L, 4L, 52L), "month" = c(1L, 6L, 12L))}

\item{CalendarSkews}{List of the form list("day" = c(1L, 7L, 21L), "week" = c(1L, 4L, 52L), "month" = c(1L, 6L, 12L))}

\item{CalendarKurts}{List of the form list("day" = c(1L, 7L, 21L), "week" = c(1L, 4L, 52L), "month" = c(1L, 6L, 12L))}

\item{CalendarQuantiles}{List of the form list("day" = c(1L, 7L, 21L), "week" = c(1L, 4L, 52L), "month" = c(1L, 6L, 12L))}

\item{CalendarQuantilesSelected}{Supply a vector of "q5", "q10", "q15", "q20", "q25", "q30", "q35", "q40", "q45", "q50", "q55", "q60", "q65", "q70", "q75", "q80", "q85", "q90", "q95"}

\item{CohortLags}{List of the form list("day" = c(1L, 7L, 21L), "week" = c(1L, 4L, 52L), "month" = c(1L, 6L, 12L))}

\item{CohortMovingAverages}{List of the form list("day" = c(1L, 7L, 21L), "week" = c(1L, 4L, 52L), "month" = c(1L, 6L, 12L))}

\item{CohortStandardDeviations}{List of the form list("day" = c(1L, 7L, 21L), "week" = c(1L, 4L, 52L), "month" = c(1L, 6L, 12L))}

\item{CohortSkews}{List of the form list("day" = c(1L, 7L, 21L), "week" = c(1L, 4L, 52L), "month" = c(1L, 6L, 12L))}

\item{CohortKurts}{List of the form list("day" = c(1L, 7L, 21L), "week" = c(1L, 4L, 52L), "month" = c(1L, 6L, 12L))}

\item{CohortQuantiles}{List of the form list("day" = c(1L, 7L, 21L), "week" = c(1L, 4L, 52L), "month" = c(1L, 6L, 12L))}

\item{CohortQuantilesSelected}{Supply a vector of "q5", "q10", "q15", "q20", "q25", "q30", "q35", "q40", "q45", "q50", "q55", "q60", "q65", "q70", "q75", "q80", "q85", "q90", "q95"

# Grid tuning}

\item{PassInGrid}{Defaults to NULL. Pass in a single row of grid from a previous output as a data.table (they are collected as data.tables)}

\item{GridTune}{Set to TRUE to run a grid tuning procedure. Set a number in MaxModelsInGrid to tell the procedure how many models you want to test.}

\item{BaselineComparison}{Set to either "default" or "best". Default is to compare each successive model build to the baseline model using max trees (from function args). Best makes the comparison to the current best model.}

\item{MaxModelsInGrid}{Number of models to test from grid options}

\item{MaxRunMinutes}{Maximum number of minutes to let this run}

\item{MaxRunsWithoutNewWinner}{Number of models built before calling it quits

# ML Args begin}

\item{LossFunction}{= 'regression'}

\item{EvalMetric}{= 'mae'}

\item{NumOfParDepPlots}{Tell the function the number of partial dependence calibration plots you want to create. Calibration boxplots will only be created for numerical features (not dummy variables)}

\item{Device_Type}{= 'CPU'}

\item{Input_Model}{= NULL}

\item{Task}{= 'train'}

\item{Boosting}{= 'gbdt'}

\item{LinearTree}{= FALSE}

\item{Trees}{= 1000}

\item{ETA}{= 0.10}

\item{Num_Leaves}{= 31}

\item{Deterministic}{= TRUE

# Learning Parameters
# https://lightgbm.readthedocs.io/en/latest/Parameters.html#learning-control-parameters}

\item{NThreads}{= parallel::detectCores() / 2}

\item{Force_Col_Wise}{= FALSE}

\item{Force_Row_Wise}{= FALSE}

\item{Max_Depth}{= 6}

\item{Min_Data_In_Leaf}{= 20}

\item{Min_Sum_Hessian_In_Leaf}{= 0.001}

\item{Bagging_Freq}{= 1.0}

\item{Bagging_Fraction}{= 1.0}

\item{Feature_Fraction}{= 1.0}

\item{Feature_Fraction_Bynode}{= 1.0}

\item{Lambda_L1}{= 0.0}

\item{Lambda_L2}{= 0.0}

\item{Extra_Trees}{= FALSE}

\item{Early_Stopping_Round}{= 10}

\item{First_Metric_Only}{= TRUE}

\item{Max_Delta_Step}{= 0.0}

\item{Linear_Lambda}{= 0.0}

\item{Min_Gain_To_Split}{= 0}

\item{Drop_Rate_Dart}{= 0.10}

\item{Max_Drop_Dart}{= 50}

\item{Skip_Drop_Dart}{= 0.50}

\item{Uniform_Drop_Dart}{= FALSE}

\item{Top_Rate_Goss}{= FALSE}

\item{Other_Rate_Goss}{= FALSE}

\item{Monotone_Constraints}{= NULL}

\item{Monotone_Constraints_method}{= 'advanced'}

\item{Monotone_Penalty}{= 0.0}

\item{Forcedsplits_Filename}{= NULL}

\item{Refit_Decay_Rate}{= 0.90}

\item{Path_Smooth}{= 0.0

# IO Dataset Parameters
# https://lightgbm.readthedocs.io/en/latest/Parameters.html#io-parameters}

\item{Max_Bin}{= 255}

\item{Min_Data_In_Bin}{= 3}

\item{Data_Random_Seed}{= 1}

\item{Is_Enable_Sparse}{= TRUE}

\item{Enable_Bundle}{= TRUE}

\item{Use_Missing}{= TRUE}

\item{Zero_As_Missing}{= FALSE}

\item{Two_Round}{= FALSE

# Convert Parameters}

\item{Convert_Model}{= NULL}

\item{Convert_Model_Language}{= 'cpp'

# Objective Parameters
# https://lightgbm.readthedocs.io/en/latest/Parameters.html#objective-parameters}

\item{Boost_From_Average}{= TRUE}

\item{Alpha}{= 0.90}

\item{Fair_C}{= 1.0}

\item{Poisson_Max_Delta_Step}{= 0.70}

\item{Tweedie_Variance_Power}{= 1.5}

\item{Lambdarank_Truncation_Level}{= 30

# Metric Parameters (metric is in Core)
# https://lightgbm.readthedocs.io/en/latest/Parameters.html#metric-parameters}

\item{Is_Provide_Training_Metric}{= TRUE,}

\item{Eval_At}{= c(1,2,3,4,5)

# Network Parameters
# https://lightgbm.readthedocs.io/en/latest/Parameters.html#network-parameters}

\item{Num_Machines}{= 1

# GPU Parameters}

\item{Gpu_Platform_Id}{= -1}

\item{Gpu_Device_Id}{= -1}

\item{Gpu_Use_Dp}{= TRUE}

\item{Num_Gpu}{= 1}

\item{#}{https://lightgbm.readthedocs.io/en/latest/Parameters.html#gpu-parameters}
}
\description{
AutoLightGBMFunnelCARMA is a forecasting model for cohort funnel forecasting for grouped data or non-grouped data
}
\examples{
\dontrun{
# Create Fake Data
data <- RemixAutoML::FakeDataGenerator(ChainLadderData = TRUE)

# Subset data for training
ModelDataBase <- data[CalendarDateColumn < '2020-01-01' & CohortDateColumn < '2020-01-01']
ModelData <- data.table::copy(ModelDataBase)

# Train Funne Model
TestModel <- RemixAutoML::AutoLightGBMFunnelCARMA(

  # Data Arguments
  data = ModelData,
  GroupVariables = NULL,
  BaseFunnelMeasure = "Leads", # if you have XREGS, supply vector such as c("Leads", "XREGS1", "XREGS2")
  ConversionMeasure = "Appointments",
  ConversionRateMeasure = NULL,
  CohortPeriodsVariable = "CohortDays",
  WeightsColumnName = NULL,
  CalendarDate = "CalendarDateColumn",
  CohortDate = "CohortDateColumn",
  PartitionRatios = c(0.70,0.20,0.10),
  TruncateDate = NULL,
  TimeUnit = "days",
  TransformTargetVariable = TRUE,
  TransformMethods = c("Asinh","Asin","Log","LogPlus1","Sqrt","Logit"),
  AnomalyDetection = list(tstat_high = 3, tstat_low = -2),

  # MetaData Arguments
  Jobs = c("eval","train"),
  SaveModelObjects = FALSE,
  ModelID = "ModelTest",
  ModelPath = getwd(),
  MetaDataPath = NULL,
  DebugMode = TRUE,
  NumOfParDepPlots = 1L,
  EncodingMethod = "credibility",
  NThreads = parallel::detectCores(),

  # Feature Engineering Arguments
  CalendarTimeGroups = c("days","weeks","months"),
  CohortTimeGroups = c("days", "weeks"),
  CalendarVariables = c("wday","mday","yday","week","month","quarter","year"),
  HolidayGroups = c("USPublicHolidays","EasterGroup","ChristmasGroup","OtherEcclesticalFeasts"),
  HolidayLookback = NULL,
  CohortHolidayLags = c(1L,2L,7L),
  CohortHolidayMovingAverages = c(3L,7L),
  CalendarHolidayLags = c(1L,2L,7L),
  CalendarHolidayMovingAverages = c(3L,7L),

  # Time Series Features
  ImputeRollStats = -0.001,
  CalendarLags = list("day" = c(1L,2L,7L,35L,42L), "week" = c(5L,6L,10L,12L,25L,26L)),
  CalendarMovingAverages = list("day" = c(7L,14L,35L,42L), "week" = c(5L,6L,10L,12L,20L,24L), "month" = c(6L,12L)),
  CalendarStandardDeviations = NULL,
  CalendarSkews = NULL,
  CalendarKurts = NULL,
  CalendarQuantiles = NULL,
  CalendarQuantilesSelected = "q50",
  CohortLags = list("day" = c(1L,2L,7L,35L,42L), "week" = c(5L,6L)),
  CohortMovingAverages = list("day" = c(7L,14L,35L,42L), "week" = c(5L,6L), "month" = c(1L,2L)),
  CohortStandardDeviations = NULL,
  CohortSkews = NULL,
  CohortKurts = NULL,
  CohortQuantiles = NULL,
  CohortQuantilesSelected = "q50",

  # ML Grid Tuning
  PassInGrid = NULL,
  GridTune = FALSE,
  BaselineComparison = "default",
  MaxModelsInGrid = 25L,
  MaxRunMinutes = 180L,
  MaxRunsWithoutNewWinner = 10L,

  # ML Setup Parameters
  LossFunction = 'regression',
  EvalMetric = 'mae',
  GridEvalMetric = 'mae',

  # LightGBM Args
  Device_Type = 'CPU',
  Input_Model = NULL,
  Task = 'train',
  Boosting = 'gbdt',
  LinearTree = FALSE,
  Trees = 50,
  ETA = 0.10,
  Num_Leaves = 31,
  Deterministic = TRUE,

  # Learning Parameters
  # https://lightgbm.readthedocs.io/en/latest/Parameters.html#learning-control-parameters
  Force_Col_Wise = FALSE,
  Force_Row_Wise = FALSE,
  Max_Depth = 6,
  Min_Data_In_Leaf = 20,
  Min_Sum_Hessian_In_Leaf = 0.001,
  Bagging_Freq = 1.0,
  Bagging_Fraction = 1.0,
  Feature_Fraction = 1.0,
  Feature_Fraction_Bynode = 1.0,
  Lambda_L1 = 0.0,
  Lambda_L2 = 0.0,
  Extra_Trees = FALSE,
  Early_Stopping_Round = 10,
  First_Metric_Only = TRUE,
  Max_Delta_Step = 0.0,
  Linear_Lambda = 0.0,
  Min_Gain_To_Split = 0,
  Drop_Rate_Dart = 0.10,
  Max_Drop_Dart = 50,
  Skip_Drop_Dart = 0.50,
  Uniform_Drop_Dart = FALSE,
  Top_Rate_Goss = FALSE,
  Other_Rate_Goss = FALSE,
  Monotone_Constraints = NULL,
  Monotone_Constraints_method = 'advanced',
  Monotone_Penalty = 0.0,
  Forcedsplits_Filename = NULL, # use for AutoStack option; .json file
  Refit_Decay_Rate = 0.90,
  Path_Smooth = 0.0,

  # IO Dataset Parameters
  # https://lightgbm.readthedocs.io/en/latest/Parameters.html#io-parameters
  Max_Bin = 255,
  Min_Data_In_Bin = 3,
  Data_Random_Seed = 1,
  Is_Enable_Sparse = TRUE,
  Enable_Bundle = TRUE,
  Use_Missing = TRUE,
  Zero_As_Missing = FALSE,
  Two_Round = FALSE,

  # Convert Parameters
  Convert_Model = NULL,
  Convert_Model_Language = 'cpp',

  # Objective Parameters
  # https://lightgbm.readthedocs.io/en/latest/Parameters.html#objective-parameters
  Boost_From_Average = TRUE,
  Alpha = 0.90,
  Fair_C = 1.0,
  Poisson_Max_Delta_Step = 0.70,
  Tweedie_Variance_Power = 1.5,
  Lambdarank_Truncation_Level = 30,

  # Metric Parameters (metric is in Core)
  # https://lightgbm.readthedocs.io/en/latest/Parameters.html#metric-parameters
  Is_Provide_Training_Metric = TRUE,
  Eval_At = c(1,2,3,4,5),

  # Network Parameters
  # https://lightgbm.readthedocs.io/en/latest/Parameters.html#network-parameters
  Num_Machines = 1,

  # GPU Parameters
  # https://lightgbm.readthedocs.io/en/latest/Parameters.html#gpu-parameters
  Gpu_Platform_Id = -1,
  Gpu_Device_Id = -1,
  Gpu_Use_Dp = TRUE,
  Num_Gpu = 1)

# Separate out the Base Funnel Measures Data
LeadsData <- data[, lapply(.SD, data.table::first), .SDcols = c("Leads"), by = c("CalendarDateColumn")]
ModelData <- ModelDataBase[, Leads := NULL]

# Forecast Funnel Model
Test <- RemixAutoML::AutoLightGBMFunnelCARMAScoring(
  TrainData = ModelData,
  ForwardLookingData = LeadsData,
  TrainEndDate = ModelData[, max(CalendarDateColumn)],
  ForecastEndDate = LeadsData[, max(CalendarDateColumn)],
  TrainOutput = TestModel$ModelOutput,
  ArgsList = TestModel$ArgsList,
  ModelPath = NULL,
  MaxCohortPeriod = 15,
  DebugMode = TRUE)
}
}
\seealso{
Other Automated Funnel Data Forecasting: 
\code{\link{AutoCatBoostFunnelCARMAScoring}()},
\code{\link{AutoCatBoostFunnelCARMA}()},
\code{\link{AutoLightGBMFunnelCARMAScoring}()},
\code{\link{AutoXGBoostFunnelCARMAScoring}()},
\code{\link{AutoXGBoostFunnelCARMA}()}
}
\author{
Adrian Antico
}
\concept{Automated Funnel Data Forecasting}
