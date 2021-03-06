#' @title AutoH2oGBMSizeFreqDist
#'
#' @description AutoH2oGBMSizeFreqDist for building size and frequency distributions via quantile regressions. Size (or severity) and frequency (or count) quantile regressions are build. Use this with the ID_SingleLevelGibbsSampler function to simulate the joint distribution.
#'
#' @author Adrian Antico
#' @family Supervised Learning - Compound
#'
#' @param CountData This is your CountData generated from the IntermittentDemandBootStrapper() function
#' @param SizeData This is your SizeData generated from the IntermittentDemandBootStrapper() function
#' @param CountQuantiles The default are deciles, i.e. seq(0.10,0.90,0.10). More granularity the better, but it will take longer to run.
#' @param SizeQuantiles The default are deciles, i.e. seq(0.10,0.90,0.10). More granularity the better, but it will take longer to run.
#' @param AutoTransform Set to FALSE not to have the your target variables automatically transformed for the best normalization.
#' @param DataPartitionRatios The default is c(0.75,0.20,0.05). With CatBoost, you should allocate a decent amount to the validation data (second input). Three inputs are required.
#' @param StratifyColumnName You can specify grouping columns to stratify by
#' @param StratifyTargets Set to TRUE to stratify by the target variables to ensure the a more even allocation for potentially highly skewed data
#' @param NTrees Default is 1500. If the best model utilizes all trees, you should consider increasing the argument.
#' @param MaxMem The max memory allocation. E.g. "28G"
#' @param NThreads The max threads to use. E.g. 4
#' @param EvalMetric Set to "Quantile". Alternative quantile methods may become available in the future.
#' @param GridTune The default is set to FALSE. If you set to TRUE, make sure to specify MaxModelsGrid to a number greater than 1.
#' @param CountTargetColumnName Column names or column numbers
#' @param SizeTargetColumnName Column names or column numbers
#' @param CountFeatureColNames Column names or column numbers
#' @param SizeFeatureColNames Column names or column numbers
#' @param ModelIDs A two element character vector. E.g. c("CountModel","SizeModel")
#' @param MaxModelsGrid Set to a number greater than 1 if GridTune is set to TRUE
#' @param ModelPath This path file is where all your models will be stored. If you leave MetaDataPath NULL, the evaluation metadata will also be stored here. If you leave this NULL, the function will not run.
#' @param MetaDataPath A separate path to store the model metadata for evaluation.
#' @param NumOfParDepPlots Set to a number greater than or equal to 1 to see the relationships between your features and targets.
#' @return This function does not return anything. It can only store your models and model evaluation metadata to file.
#' @examples
#' \donttest{
#' AutoH2oGBMSizeFreqDist(
#'   CountData = NULL,
#'   SizeData = NULL,
#'   CountQuantiles = seq(0.10,0.90,0.10),
#'   SizeQuantiles = seq(0.10,0.90,0.10),
#'   AutoTransform = TRUE,
#'   DataPartitionRatios = c(0.75,0.20,0.05),
#'   StratifyColumnName = NULL,
#'   StratifyTargets = FALSE,
#'   NTrees = 1500,
#'   MaxMem = {gc();paste0(as.character(floor(as.numeric(system("awk '/MemFree/ {print $2}' /proc/meminfo", intern=TRUE)) / 1000000)),"G")},
#'   NThreads = max(1, parallel::detectCores()-2),
#'   EvalMetric = "Quantile",
#'   GridTune = FALSE,
#'   CountTargetColumnName = NULL,
#'   SizeTargetColumnName = NULL,
#'   CountFeatureColNames = NULL,
#'   SizeFeatureColNames = NULL,
#'   ModelIDs = c("CountModel","SizeModel"),
#'   MaxModelsGrid = 5,
#'   ModelPath = NULL,
#'   MetaDataPath = NULL,
#'   NumOfParDepPlots = 0)
#' }
#' @noRd
AutoH2oGBMSizeFreqDist <- function(CountData = NULL,
                                   SizeData = NULL,
                                   CountQuantiles = seq(0.10,0.90,0.10),
                                   SizeQuantiles = seq(0.10,0.90,0.10),
                                   AutoTransform = TRUE,
                                   DataPartitionRatios = c(0.75,0.20,0.05),
                                   StratifyColumnName = NULL,
                                   StratifyTargets = FALSE,
                                   NTrees = 1500,
                                   MaxMem = {gc();paste0(as.character(floor(as.numeric(system("awk '/MemFree/ {print $2}' /proc/meminfo", intern=TRUE)) / 1000000)),"G")},
                                   NThreads = max(1, parallel::detectCores()-2),
                                   EvalMetric = "Quantile",
                                   GridTune = FALSE,
                                   CountTargetColumnName = NULL,
                                   SizeTargetColumnName = NULL,
                                   CountFeatureColNames = NULL,
                                   SizeFeatureColNames = NULL,
                                   ModelIDs = c("CountModel","SizeModel"),
                                   MaxModelsGrid = 5,
                                   ModelPath = NULL,
                                   MetaDataPath = NULL,
                                   NumOfParDepPlots = 0) {

  # data.table optimize----
  if(parallel::detectCores() > 10) data.table::setDTthreads(threads = max(1L, parallel::detectCores() - 2L)) else data.table::setDTthreads(threads = max(1L, parallel::detectCores()))

  # Return immediately if no paths are given----
  if(is.null(ModelPath)) return("Need to supply a path in ModelPath for saving models")

  # Count Model AutoTransform----
  if(AutoTransform) TransFormCols <- CountTargetColumnName else TransFormCols <- NULL

  # Clear GPU garbage----
  gc()

  # Target stratification----
  if(StratifyTargets) {
    StratTargetColumns <- "Counts"
    StratTargetPrecision <- 0.001
  } else {
    StratTargetColumns <- NULL
    StratTargetPrecision <- NULL
  }

  # Count Model AutoDataPartition----
  CountDataSets <- AutoDataPartition(
    data = CountData,
    NumDataSets = 3,
    Ratios = DataPartitionRatios,
    PartitionType = "random",
    StratifyColumnNames = StratifyColumnName,
    TimeColumnName = NULL)

  # Store data sets----
  CountDataTrain <- CountDataSets$TrainData
  CountDataValidate <- CountDataSets$ValidationData
  CountDataTest <- CountDataSets$TestData

  # Build Count Models----
  for(quan in CountQuantiles) {

    # Copy data sets----
    CountDataTrainCopy <- data.table::copy(CountDataTrain)
    CountDataValidateCopy <- data.table::copy(CountDataValidate)
    CountDataTestCopy <- data.table::copy(CountDataTest)

    # Build Model----
    TestModel <- AutoH2oGBMRegression(
      data = CountDataTrainCopy,
      ValidationData = CountDataValidateCopy,
      TestData = CountDataTestCopy,
      TargetColumnName = CountTargetColumnName,
      FeatureColNames = CountFeatureColNames,
      TransformNumericColumns = TransFormCols,
      Alpha = quan,
      Distribution = "quantile",
      eval_metric = EvalMetric,
      Trees = NTrees,
      GridTune = GridTune,
      MaxMem = MaxMem,
      NThreads = NThreads,
      MaxModelsInGrid = MaxModelsGrid,
      model_path = ModelPath,
      metadata_path = MetaDataPath,
      ModelID = paste0(ModelIDs[1],"_",quan),
      NumOfParDepPlots = NumOfParDepPlots,
      ReturnModelObjects = FALSE,
      SaveModelObjects = TRUE,
      IfSaveModel = "standard",
      H2OShutdown = TRUE,
      Methods = c("BoxCox", "Asinh", "Asin", "Log", "LogPlus1", "Logit", "YeoJohnson"))

    # Pause Runs by 10 seconds----
    Sys.sleep(10)
  }

  # Clear Count Model Data----
  rm(CountDataSets,CountData,CountDataTrain,CountDataValidate,CountDataTest)

  # Size Model AutoTransform----
  if(AutoTransform) {
    TransFormCols <- SizeTargetColumnName
  } else {
    TransFormCols <- NULL
  }

  # Target stratification----
  if(StratifyTargets) {
    StratTargetColumns <- "Size"
    StratTargetPrecision <- 0.001
  } else {
    StratTargetColumns <- NULL
    StratTargetPrecision <- NULL
  }

  # Size Model AutoDataPartition----
  SizeDataSets <- AutoDataPartition(
    data = SizeData,
    NumDataSets = 3,
    Ratios = DataPartitionRatios,
    PartitionType = "random",
    StratifyColumnNames = NULL,
    TimeColumnName = NULL)

  # Store data sets----
  SizeDataTrain <- SizeDataSets$TrainData
  SizeDataValidate <- SizeDataSets$ValidationData
  SizeDataTest <- SizeDataSets$TestData

  # Clear GPU garbage----
  gc()

  # Build Size Models----
  for(quan in SizeQuantiles) {

    # Copy data----
    SizeDataTrainCopy <- data.table::copy(SizeDataTrain)
    SizeDataValidateCopy <- data.table::copy(SizeDataValidate)
    SizeDataTestCopy <- data.table::copy(SizeDataTest)

    # Build Models----
    TestModel <- AutoH2oGBMRegression(
      data = SizeDataTrainCopy,
      ValidationData = SizeDataValidateCopy,
      TestData = SizeDataTestCopy,
      TargetColumnName = SizeTargetColumnName,
      FeatureColNames = SizeFeatureColNames,
      TransformNumericColumns = TransFormCols,
      Alpha = quan,
      Distribution = "quantile",
      eval_metric = EvalMetric,
      Trees = NTrees,
      GridTune = GridTune,
      MaxMem = MaxMem,
      NThreads = NThreads,
      MaxModelsInGrid = MaxModelsGrid,
      model_path = ModelPath,
      metadata_path = MetaDataPath,
      ModelID = paste0(ModelIDs[2],"_",quan),
      NumOfParDepPlots = NumOfParDepPlots,
      ReturnModelObjects = FALSE,
      SaveModelObjects = TRUE,
      IfSaveModel = "standard",
      H2OShutdown = TRUE,
      Methods = c("BoxCox", "Asinh", "Asin", "Log", "LogPlus1", "Logit", "YeoJohnson"))

    # Pause Runs by 10 seconds----
    Sys.sleep(10)
  }
}
