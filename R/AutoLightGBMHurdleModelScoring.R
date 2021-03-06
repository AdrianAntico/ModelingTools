#' @title AutoLightGBMHurdleModelScoring
#'
#' @description AutoLightGBMHurdleModelScoring can score AutoLightGBMHurdleModel() models
#'
#' @author Adrian Antico
#' @family Automated Model Hurdle Modeling
#'
#' @param TestData scoring data.table
#' @param Path Supply if ArgsList is NULL or ModelList is null.
#' @param ModelID Supply if ArgsList is NULL or ModelList is null. Same as used in model training.
#' @param ArgsList Output from the hurdle model
#' @param ModelList Output from the hurdle model
#' @param Threshold NULL to use raw probabilities to predict. Otherwise, supply a threshold
#' @param CARMA Keep FALSE. Used for CARMA functions internals
#' @return A data.table with the final predicted value, the intermediate model predictions, and your source data
#' @examples
#' \dontrun{
#'
#' # Define file path
#' Path <- getwd()
#'
#' # Create hurdle data with correlated features
#' data <- RemixAutoML::FakeDataGenerator(
#'   Correlation = 0.70,
#'   N = 25000,
#'   ID = 3,
#'   FactorCount = 2L,
#'   AddDate = TRUE,
#'   ZIP = 1,
#'   Classification = FALSE,
#'   MultiClass = FALSE)
#'
#' # Define features
#' Features <- names(data)[!names(data) %in%
#'   c("Adrian","IDcol_1","IDcol_2","IDcol_3","DateTime")]
#'
#' Output <- RemixAutoML::AutoLightGBMHurdleModel(
#'
#'    # Operationalization args
#'    TrainOnFull = FALSE,
#'    PassInGrid = NULL,
#'
#'    # Metadata args
#'    NThreads = max(1L, parallel::detectCores()-2L),
#'    ModelID = "ModelTest",
#'    Paths = normalizePath("./"),
#'    MetaDataPaths = NULL,
#'
#'    # data args
#'    data,
#'    ValidationData = NULL,
#'    TestData = NULL,
#'    Buckets = 0L,
#'    TargetColumnName = NULL,
#'    FeatureColNames = NULL,
#'    PrimaryDateColumn = NULL,
#'    WeightsColumnName = NULL,
#'    IDcols = NULL,
#'    ClassWeights = c(1,1),
#'    DebugMode = FALSE,
#'
#'    # options
#'    EncodingMethod = "credibility",
#'    TransformNumericColumns = NULL,
#'    Methods = c('Asinh','Asin','Log','LogPlus1','Sqrt','Logit'),
#'    SplitRatios = c(0.70, 0.20, 0.10),
#'    ReturnModelObjects = TRUE,
#'    SaveModelObjects = FALSE,
#'    NumOfParDepPlots = 10L,
#'
#'    # grid tuning args
#'    GridTune = FALSE,
#'    grid_eval_metric = "accuracy",
#'    MaxModelsInGrid = 1L,
#'    BaselineComparison = "default",
#'    MaxRunsWithoutNewWinner = 10L,
#'    MaxRunMinutes = 60L,
#'
#'    # Core parameters https://lightgbm.readthedocs.io/en/latest/Parameters.html#core-parameters
#'    input_model = list('classifier' = NULL, 'regression' = NULL),
#'    task = list('classifier' = 'train', 'regression' = 'train'),
#'    device_type = list('classifier' = 'CPU', 'regression' = 'CPU'),
#'    objective = list('classifier' = 'binary', 'regression' = 'regression'),
#'    metric = list('classifier' = 'binary_logloss', 'regression' = 'rmse'),
#'    boosting = list('classifier' = 'gbdt', 'regression' = 'gbdt'),
#'    LinearTree = list('classifier' = FALSE, 'regression' = FALSE),
#'    Trees = list('classifier' = 1000L, 'regression' = 1000L),
#'    eta = list('classifier' = NULL, 'regression' = NULL),
#'    num_leaves = list('classifier' = 31, 'regression' = 31),
#'    deterministic = list('classifier' = TRUE, 'regression' = TRUE),
#'
#'    # Learning Parameters https://lightgbm.readthedocs.io/en/latest/Parameters.html#learning-control-parameters
#'    force_col_wise = list('classifier' = FALSE, 'regression' = FALSE),
#'    force_row_wise = list('classifier' = FALSE, 'regression' = FALSE),
#'    max_depth = list('classifier' = NULL, 'regression' = NULL),
#'    min_data_in_leaf = list('classifier' = 20, 'regression' = 20),
#'    min_sum_hessian_in_leaf = list('classifier' = 0.001, 'regression' = 0.001),
#'    bagging_freq = list('classifier' = 0, 'regression' = 0),
#'    bagging_fraction = list('classifier' = 1.0, 'regression' = 1.0),
#'    feature_fraction = list('classifier' = 1.0, 'regression' = 1.0),
#'    feature_fraction_bynode = list('classifier' = 1.0, 'regression' = 1.0),
#'    extra_trees = list('classifier' = FALSE, 'regression' = FALSE),
#'    early_stopping_round = list('classifier' = 10, 'regression' = 10),
#'    first_metric_only = list('classifier' = TRUE, 'regression' = TRUE),
#'    max_delta_step = list('classifier' = 0.0, 'regression' = 0.0),
#'    lambda_l1 = list('classifier' = 0.0, 'regression' = 0.0),
#'    lambda_l2 = list('classifier' = 0.0, 'regression' = 0.0),
#'    linear_lambda = list('classifier' = 0.0, 'regression' = 0.0),
#'    min_gain_to_split = list('classifier' = 0, 'regression' = 0),
#'    drop_rate_dart = list('classifier' = 0.10, 'regression' = 0.10),
#'    max_drop_dart = list('classifier' = 50, 'regression' = 50),
#'    skip_drop_dart = list('classifier' = 0.50, 'regression' = 0.50),
#'    uniform_drop_dart = list('classifier' = FALSE, 'regression' = FALSE),
#'    top_rate_goss = list('classifier' = FALSE, 'regression' = FALSE),
#'    other_rate_goss = list('classifier' = FALSE, 'regression' = FALSE),
#'    monotone_constraints = list('classifier' = NULL, 'regression' = NULL),
#'    monotone_constraints_method = list('classifier' = 'advanced', 'regression' = 'advanced'),
#'    monotone_penalty = list('classifier' = 0.0, 'regression' = 0.0),
#'    forcedsplits_filename = list('classifier' = NULL, 'regression' = NULL),
#'    refit_decay_rate = list('classifier' = 0.90, 'regression' = 0.90),
#'    path_smooth = list('classifier' = 0.0, 'regression' = 0.0),
#'
#'    # IO Dataset Parameters
#'    max_bin = list('classifier' = 255, 'regression' = 255),
#'    min_data_in_bin = list('classifier' = 3, 'regression' = 3),
#'    data_random_seed = list('classifier' = 1, 'regression' = 1),
#'    is_enable_sparse = list('classifier' = TRUE, 'regression' = TRUE),
#'    enable_bundle = list('classifier' = TRUE, 'regression' = TRUE),
#'    use_missing = list('classifier' = TRUE, 'regression' = TRUE),
#'    zero_as_missing = list('classifier' = FALSE, 'regression' = FALSE),
#'    two_round = list('classifier' = FALSE, 'regression' = FALSE),
#'
#'    # Convert Parameters
#'    convert_model = list('classifier' = NULL, 'regression' = NULL),
#'    convert_model_language = list('classifier' = "cpp", 'regression' = "cpp"),
#'
#'    # Objective Parameters
#'    boost_from_average = list('classifier' = TRUE, 'regression' = TRUE),
#'    is_unbalance = list('classifier' = FALSE, 'regression' = FALSE),
#'    scale_pos_weight = list('classifier' = 1.0, 'regression' = 1.0),
#'
#'    # Metric Parameters (metric is in Core)
#'    is_provide_training_metric = list('classifier' = TRUE, 'regression' = TRUE),
#'    eval_at = list('classifier' = c(1,2,3,4,5), 'regression' = c(1,2,3,4,5)),
#'
#'    # Network Parameters
#'    num_machines = list('classifier' = 1, 'regression' = 1),
#'
#'    # GPU Parameters
#'    gpu_platform_id = list('classifier' = -1, 'regression' = -1),
#'    gpu_device_id = list('classifier' = -1, 'regression' = -1),
#'    gpu_use_dp = list('classifier' = TRUE, 'regression' = TRUE),
#'    num_gpu = list('classifier' = 1, 'regression' = 1))
#'
#' # Score XGBoost Hurdle Model
#' HurdleScores <- RemixAutoML::AutoLightGBMHurdleModelScoring(
#'   TestData = data,
#'   Path = Path,
#'   ModelID = "ModelTest",
#'   ModelList = NULL,
#'   ArgsList = NULL,
#'   Threshold = NULL)
#' }
#' @export
AutoLightGBMHurdleModelScoring <- function(TestData = NULL,
                                           Path = NULL,
                                           ModelID = NULL,
                                           ArgsList = NULL,
                                           ModelList = NULL,
                                           Threshold = NULL,
                                           CARMA = FALSE) {

  # Load ArgsList and ModelList if NULL ----
  if(is.null(Path) && (is.null(ArgsList) || is.null(ModelList))) stop("Supply a value to the Path argument to where the ArgsList and ModelList are located")

  # Load ArgsList and ModelList if not supplied ----
  if(is.null(ArgsList)) load(file.path(Path, paste0(ModelID, "_HurdleArgList.Rdata")), envir = .GlobalEnv)

  # Define Buckets ----
  Buckets <- ArgsList$Buckets

  # Score Classification Model ----
  if(length(Buckets) == 1L) TargetType <- "Classification" else TargetType <- "Multiclass"

  # Store classifier model----
  if(!is.null(ModelList)) {
    ClassModel <- ModelList[[1L]]
  } else if(!is.null(ArgsList$ModelID)) {
    ClassModel <- load(file.path(ArgsList$Paths, ArgsList$ModelID))
  } else {
    stop("Need to supply a ModelList")
  }

  # Store FeatureNames ----
  FeatureNames <- ArgsList$FeatureColNames

  # Factor levels list ----
  if(!is.null(ArgsList$FactorLevelsList)) FactorLevelsList <- ArgsList$FactorLevelsList else FactorLevelsList <- NULL

  # Store IDcols ----
  IDcols <- c(setdiff(names(TestData), c(ArgsList$FeatureColNames)))

  # Store colnames ----
  ColumnNames <- names(TestData)

  # Classification Model Scoring ----
  TestData <- AutoLightGBMScoring(
    ScoringData = TestData,
    FeatureColumnNames = FeatureNames,
    IDcols = IDcols,
    ModelObject = ClassModel,
    ModelPath = ArgsList$Paths,
    ModelID = ArgsList$ModelID,
    EncodingMethod = ArgsList$EncodingMethod,
    ReturnShapValues = FALSE,
    FactorLevelsList = ArgsList$Class_FactorLevelsList,
    TargetLevels = ArgsList$TargetLevels,
    OneHot = FALSE,
    TargetType = TargetType,
    ReturnFeatures = TRUE,
    TransformationObject = NULL,
    TargetColumnName = NULL,
    TransformNumeric = FALSE,
    BackTransNumeric = FALSE,
    TransID = NULL,
    TransPath = NULL,
    MDP_Impute = FALSE,
    MDP_CharToFactor = TRUE,
    MDP_RemoveDates = FALSE,
    MDP_MissFactor = "0",
    MDP_MissNum = -1)

  # Change name for classification ----
  if(tolower(TargetType) == 'classification') {
    data.table::setnames(TestData, 'Predictions', 'Predictions_C1')
    TestData[, Predictions_C0 := 1 - Predictions_C1]
    data.table::setcolorder(TestData, c(ncol(TestData), 1L, 2L:(ncol(TestData) - 1L)))
  }

  # Change Name of Predicted MultiClass Column ----
  if(tolower(TargetType) != 'classification') {
    data.table::setnames(TestData, 'Predict', 'Predictions_MultiClass')
  }

  # Begin regression model scoring ----
  looper <- ArgsList$looper
  counter <- max(looper)

  # Loop through model scoring ----
  for(bucket in looper) {

    # Update IDcols----
    IDcolsModified <- c(IDcols, setdiff(names(TestData), ColumnNames))

    # Check for constant value bucket----
    if(!any(bucket %in% c(ArgsList$degenerate))) {

      # Increment----
      counter <- counter - 1L

      # Score TestData----
      if(bucket == max(looper)) ModelIDD <- paste0(ArgsList$ModelID,"_",bucket,"+") else ModelIDD <- paste0(ArgsList$ModelID, "_", bucket)

      # Manage TransformationResults
      if(is.null(ArgsList$TransformNumericColumns)) TransformationResults <- NULL else TransformationResults <- ArgsList$TransformNumericColumns

      # Store Transformations----
      if(!is.null(ArgsList$TransformNumericColumns)) {
        TransformationResults <- ArgsList[[paste0("TransformationResults_", ModelIDD)]]
        Transform <- TRUE
      } else {
        TransformationResults <- NULL
        Transform <- FALSE
      }

      # Load Model----
      if(!is.null(ModelList)) {
        model <- ModelList[[ModelIDD]]
      } else {
        load(file.path(ArgsList$Paths, ModelIDD))
      }

      # XGBoost Model Scroring ----
      TestData <- AutoLightGBMScoring(
        ScoringData = TestData,
        FeatureColumnNames = FeatureNames,
        IDcols = IDcolsModified,
        ModelObject = model,
        ModelPath = NULL,
        ModelID = ArgsList$ModelID,
        EncodingMethod = ArgsList$EncodingMethod,
        ReturnShapValues = FALSE,
        FactorLevelsList = ArgsList[[paste0(ModelIDD, "_FactorLevelsList")]],
        TargetLevels = NULL,
        OneHot = FALSE,
        TargetType = "regression",
        ReturnFeatures = TRUE,
        TransformationObject = NULL,
        TargetColumnName = NULL,
        TransformNumeric = if(is.null(ArgsList[[paste0("TransformationResults_", ModelIDD)]])) FALSE else TRUE,
        BackTransNumeric = if(is.null(ArgsList[[paste0("TransformationResults_", ModelIDD)]])) FALSE else TRUE,
        TransID = NULL,
        TransPath = NULL,
        MDP_Impute = FALSE,
        MDP_CharToFactor = TRUE,
        MDP_RemoveDates = FALSE,
        MDP_MissFactor = "0",
        MDP_MissNum = -1)

      # Remove Model----
      rm(model)

      # Change prediction name to prevent duplicates----
      if(bucket == max(looper)) Val <- paste0('Predictions_', bucket - 1L, '+') else Val <- paste0('Predictions_', bucket)
      if(length(which(names(TestData) == "Predictions")) > 1) {
        zzz <- names(TestData)
        zzz[max(which(names(TestData) == "Predictions"))] <- Val
        colnames(TestData) <- zzz
      } else {
        data.table::setnames(TestData, "Predictions", Val)
      }

    } else {

      # Use single value for predictions in the case of zero variance ----
      if(bucket == max(seq_len(length(Buckets) + 1L))) {
        data.table::setalloccol(DT = TestData, n = 10)
        data.table::set(TestData, j = paste0("Predictions", Buckets[bucket - 1L], "+"), value = Buckets[bucket])
        data.table::setcolorder(TestData, c(ncol(TestData), 1L:(ncol(TestData)-1L)))
      } else {
        data.table::setalloccol(DT = TestData, n = ncol(TestData) + 10)
        data.table::set(TestData, j = paste0("Predictions", Buckets[bucket]), value = Buckets[bucket])
        data.table::setcolorder(TestData, c(ncol(TestData), 1L:(ncol(TestData)-1L)))
      }
    }
  }

  # Rearrange cols ----
  data.table::setcolorder(TestData, c(which(names(TestData) %like% "Predictions"), setdiff(seq_along(TestData), which(names(TestData) %like% "Predictions"))))

  # Final Combination of Predictions ----
  counter <- length(Buckets)
  if(counter > 2L || (counter == 2L && length(Buckets) != 1L)) {
    for(i in rev(looper)) {
      if(i == 1L) {
        TestData[, UpdatedPrediction := TestData[[i]] * TestData[[i + 1L + (length(looper))]]]
      } else {
        TestData[, UpdatedPrediction := UpdatedPrediction + TestData[[i]] * TestData[[i + 1L + length(looper)]]]
      }
    }
  } else {
    if(0 %in% Buckets) {
      TestData[, UpdatedPrediction := TestData[[2L]] * TestData[[4L]]]
    } else {
      TestData[, UpdatedPrediction := TestData[[1L]] * TestData[[3L]] + TestData[[2L]] * TestData[[4L]]]
    }
  }

  # Final column rearrange----
  data.table::setcolorder(TestData, c(ncol(TestData), 1L:(ncol(TestData) - 1L)))

  # Return preds----
  return(TestData)
}
