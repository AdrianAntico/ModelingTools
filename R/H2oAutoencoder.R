#' @title H2OAutoencoder
#'
#' @description H2OAutoencoder for anomaly detection and or dimensionality reduction
#'
#' @author Adrian Antico
#' @family Feature Engineering
#'
#' @param AnomalyDetection Set to TRUE to run anomaly detection
#' @param DimensionReduction Set to TRUE to run dimension reduction
#' @param data The data.table with the columns you wish to have analyzed
#' @param Features NULL Column numbers or column names
#' @param RemoveFeatures Set to TRUE if you want the features you specify in the Features argument to be removed from the data returned
#' @param NThreads max(1L, parallel::detectCores()-2L)
#' @param MaxMem "28G"
#' @param LayerStructure If NULL, layers and sizes will be created for you, using NodeShrinkRate and 7 layers will be created.
#' @param NodeShrinkRate = (sqrt(5) - 1) / 2,
#' @param H2OStart TRUE to start H2O inside the function
#' @param H2OShutdown Setting to TRUE will shutdown H2O when it done being used internally.
#' @param ModelID "TestModel"
#' @param model_path If NULL no model will be saved. If a valid path is supplied the model will be saved there
#' @param ReturnLayer Which layer of the NNet to return. Choose from 1-7 with 4 being the layer with the least amount of nodes
#' @param per_feature Set to TRUE to have per feature anomaly detection generated. Otherwise and overall value will be generated
#' @param Activation Choose from "Tanh", "TanhWithDropout", "Rectifier", "RectifierWithDropout","Maxout", "MaxoutWithDropout"
#' @param Epochs Quantile value to find the cutoff value for classifying outliers
#' @param L2 Specify the amount of memory to allocate to H2O. E.g. "28G"
#' @param ElasticAveraging Specify the number of threads (E.g. cores * 2)
#' @param ElasticAveragingMovingRate Specify the number of decision trees to build
#' @param ElasticAveragingRegularization Specify the row sample rate per tree
#' @examples
#' \dontrun{
#' ############################
#' # Training
#' ############################
#'
#' # Create simulated data
#' data <- RemixAutoML::FakeDataGenerator(
#'   Correlation = 0.70,
#'   N = 1000L,
#'   ID = 2L,
#'   FactorCount = 2L,
#'   AddDate = TRUE,
#'   AddComment = FALSE,
#'   ZIP = 2L,
#'   TimeSeries = FALSE,
#'   ChainLadderData = FALSE,
#'   Classification = FALSE,
#'   MultiClass = FALSE)
#'
#' # Run algo
#' Output <- RemixAutoML::H2OAutoencoder(
#'
#'   # Select the service
#'   AnomalyDetection = TRUE,
#'   DimensionReduction = TRUE,
#'
#'   # Data related args
#'   data = data,
#'   Features = names(data)[2L:(ncol(data)-1L)],
#'   per_feature = FALSE,
#'   RemoveFeatures = FALSE,
#'   ModelID = "TestModel",
#'   model_path = getwd(),
#'
#'   # H2O Environment
#'   NThreads = max(1L, parallel::detectCores()-2L),
#'   MaxMem = "28G",
#'   H2OStart = TRUE,
#'   H2OShutdown = TRUE,
#'
#'   # H2O ML Args
#'   LayerStructure = NULL,
#'   NodeShrinkRate = (sqrt(5) - 1) / 2,
#'   ReturnLayer = 4L,
#'   Activation = "Tanh",
#'   Epochs = 5L,
#'   L2 = 0.10,
#'   ElasticAveraging = TRUE,
#'   ElasticAveragingMovingRate = 0.90,
#'   ElasticAveragingRegularization = 0.001)
#'
#' # Inspect output
#' data <- Output$Data
#' Model <- Output$Model
#'
#' # If ValidationData is not null
#' ValidationData <- Output$ValidationData
#'
#' ############################
#' # Scoring
#' ############################
#'
#' # Create simulated data
#' data <- RemixAutoML::FakeDataGenerator(
#'   Correlation = 0.70,
#'   N = 1000L,
#'   ID = 2L,
#'   FactorCount = 2L,
#'   AddDate = TRUE,
#'   AddComment = FALSE,
#'   ZIP = 2L,
#'   TimeSeries = FALSE,
#'   ChainLadderData = FALSE,
#'   Classification = FALSE,
#'   MultiClass = FALSE)
#'
#' # Run algo
#' data <- RemixAutoML::H2OAutoencoderScoring(
#'
#'   # Select the service
#'   AnomalyDetection = TRUE,
#'   DimensionReduction = TRUE,
#'
#'   # Data related args
#'   data = data,
#'   Features = names(data)[2L:ncol(data)],
#'   RemoveFeatures = TRUE,
#'   per_feature = FALSE,
#'   ModelObject = NULL,
#'   ModelID = "TestModel",
#'   model_path = getwd(),
#'
#'   # H2O args
#'   NThreads = max(1L, parallel::detectCores()-2L),
#'   MaxMem = "28G",
#'   H2OStart = TRUE,
#'   H2OShutdown = TRUE,
#'   ReturnLayer = 4L)
#' }
#' @return A data.table
#' @export
H2OAutoencoder <- function(AnomalyDetection = FALSE,
                           DimensionReduction = TRUE,
                           data,
                           Features = NULL,
                           RemoveFeatures = FALSE,
                           NThreads = max(1L, parallel::detectCores()-2L),
                           MaxMem = "28G",
                           H2OStart = TRUE,
                           H2OShutdown = TRUE,
                           ModelID = "TestModel",
                           model_path = NULL,
                           LayerStructure  = NULL,
                           NodeShrinkRate = (sqrt(5) - 1) / 2,
                           ReturnLayer = 4L,
                           per_feature = TRUE,
                           Activation = "Tanh",
                           Epochs = 5L,
                           L2 = 0.10,
                           ElasticAveraging = TRUE,
                           ElasticAveragingMovingRate = 0.90,
                           ElasticAveragingRegularization = 0.001) {

  # Ensure data.table ----
  if(!data.table::is.data.table(data)) data.table::setDT(data)

  # Return because of mispecified arguments----
  if(!AnomalyDetection && !DimensionReduction) stop("Why are you running this function if you do not want anomaly detection nor dimension reduction?")

  # Constants ----
  F_Length <- length(Features)
  if(is.numeric(Features) || is.integer(Features)) Features <- names(data)[Features]

  # Ensure categoricals are set as factors ----
  temp <- data[, .SD, .SDcols = c(Features)]
  data[, (Features) := NULL]
  temp <- ModelDataPrep(data=temp, Impute=FALSE, CharToFactor=TRUE, FactorToChar=FALSE, IntToNumeric=FALSE, DateToChar=FALSE, RemoveDates=TRUE, MissFactor="0", MissNum=-1, IgnoreCols=NULL)

  # Initialize H2O----
  if(H2OStart) LocalHost <- h2o::h2o.init(nthreads = NThreads, max_mem_size = MaxMem, enable_assertions = FALSE)
  H2O_Data <- h2o::as.h2o(temp)

  # Layer selection - Eventually put in an arg for Type for some alternative pre-set LayerStructure----
  if(is.null(LayerStructure)) LayerStructure <- c(F_Length, ceiling(F_Length * NodeShrinkRate), ceiling(F_Length * NodeShrinkRate ^ 2), ceiling(F_Length * NodeShrinkRate ^ 3), ceiling(F_Length * NodeShrinkRate ^ 2), ceiling(F_Length * NodeShrinkRate), F_Length)

  # Update Features ----
  Features <- Features[Features %chin% names(H2O_Data)]

  # Build Model ----
  Model <- h2o::h2o.deeplearning(
    autoencoder = TRUE,
    model_id = ModelID,
    training_frame = H2O_Data,
    x = Features,
    l2 = L2,
    epochs = Epochs,
    hidden = LayerStructure,
    activation = Activation,
    elastic_averaging = ElasticAveraging,
    elastic_averaging_moving_rate = ElasticAveragingMovingRate,
    elastic_averaging_regularization = ElasticAveragingRegularization)

  # Save Model
  if(!is.null(model_path)) SaveModel <- h2o::h2o.saveModel(object = Model, path = model_path, force = TRUE)

  # Create and Merge features----
  if(AnomalyDetection && DimensionReduction) {
    Data <- cbind(
      data,
      temp,
      data.table::as.data.table(h2o::h2o.deepfeatures(object = Model, data = H2O_Data, layer = ReturnLayer)),
      data.table::as.data.table(h2o::h2o.anomaly(object = Model, data = H2O_Data, per_feature = per_feature)))
  } else if(!AnomalyDetection && DimensionReduction) {
    Data <- cbind(
      data,
      temp,
      data.table::as.data.table(h2o::h2o.deepfeatures(object = Model, data = H2O_Data, layer = ReturnLayer)))
  } else if(AnomalyDetection && !DimensionReduction) {
    Data <- cbind(
      data,
      temp,
      data.table::as.data.table(h2o::h2o.anomaly(object = Model, data = H2O_Data, per_feature = per_feature)))
  }

  # Remove H2O Objects ----
  h2o::h2o.rm(Model, H2O_Data)

  # Shutdown h2o ----
  if(H2OShutdown) h2o::h2o.shutdown(prompt = FALSE)

  # Remove features ----
  if(RemoveFeatures) data.table::set(Data, j = Features, value = NULL)

  # Return output ----
  return(Data)
}

#' @title H2OAutoencoderScoring
#'
#' @description H2OAutoencoderScoring for anomaly detection and or dimensionality reduction
#'
#' @author Adrian Antico
#' @family Feature Engineering
#'
#' @param AnomalyDetection Set to TRUE to run anomaly detection
#' @param DimensionReduction Set to TRUE to run dimension reduction
#' @param data The data.table with the columns you wish to have analyzed
#' @param Features NULL Column numbers or column names
#' @param RemoveFeatures Set to TRUE if you want the features you specify in the Features argument to be removed from the data returned
#' @param ModelObject If NULL then the model will be loaded from file. Otherwise, it will use what is supplied
#' @param NThreads max(1L, parallel::detectCores()-2L)
#' @param MaxMem "28G"
#' @param H2OStart TRUE to start H2O inside the function
#' @param H2OShutdown Setting to TRUE will shutdown H2O when it done being used internally.
#' @param ModelID "TestModel"
#' @param model_path If NULL no model will be saved. If a valid path is supplied the model will be saved there
#' @param ReturnLayer Which layer of the NNet to return. Choose from 1-7 with 4 being the layer with the least amount of nodes
#' @param per_feature Set to TRUE to have per feature anomaly detection generated. Otherwise and overall value will be generated
#' @examples
#' \dontrun{
#' ############################
#' # Training
#' ############################
#'
#' # Create simulated data
#' data <- RemixAutoML::FakeDataGenerator(
#'   Correlation = 0.70,
#'   N = 1000L,
#'   ID = 2L,
#'   FactorCount = 2L,
#'   AddDate = TRUE,
#'   AddComment = FALSE,
#'   ZIP = 2L,
#'   TimeSeries = FALSE,
#'   ChainLadderData = FALSE,
#'   Classification = FALSE,
#'   MultiClass = FALSE)
#'
#' # Run algo
#' data <- RemixAutoML::H2OAutoencoder(
#'
#'   # Select the service
#'   AnomalyDetection = TRUE,
#'   DimensionReduction = TRUE,
#'
#'   # Data related args
#'   data = data,
#'   ValidationData = NULL,
#'   Features = names(data)[2L:(ncol(data)-1L)],
#'   per_feature = FALSE,
#'   RemoveFeatures = TRUE,
#'   ModelID = "TestModel",
#'   model_path = getwd(),
#'
#'   # H2O Environment
#'   NThreads = max(1L, parallel::detectCores()-2L),
#'   MaxMem = "28G",
#'   H2OStart = TRUE,
#'   H2OShutdown = TRUE,
#'
#'   # H2O ML Args
#'   LayerStructure = NULL,
#'   ReturnLayer = 4L,
#'   Activation = "Tanh",
#'   Epochs = 5L,
#'   L2 = 0.10,
#'   ElasticAveraging = TRUE,
#'   ElasticAveragingMovingRate = 0.90,
#'   ElasticAveragingRegularization = 0.001)
#'
#' ############################
#' # Scoring
#' ############################
#'
#' # Create simulated data
#' data <- RemixAutoML::FakeDataGenerator(
#'   Correlation = 0.70,
#'   N = 1000L,
#'   ID = 2L,
#'   FactorCount = 2L,
#'   AddDate = TRUE,
#'   AddComment = FALSE,
#'   ZIP = 2L,
#'   TimeSeries = FALSE,
#'   ChainLadderData = FALSE,
#'   Classification = FALSE,
#'   MultiClass = FALSE)
#'
#' # Run algo
#' data <- RemixAutoML::H2OAutoencoderScoring(
#'
#'   # Select the service
#'   AnomalyDetection = TRUE,
#'   DimensionReduction = TRUE,
#'
#'   # Data related args
#'   data = data,
#'   Features = names(data)[2L:ncol(data)],
#'   RemoveFeatures = TRUE,
#'   per_feature = FALSE,
#'   ModelObject = NULL,
#'   ModelID = "TestModel",
#'   model_path = getwd(),
#'
#'   # H2O args
#'   NThreads = max(1L, parallel::detectCores()-2L),
#'   MaxMem = "28G",
#'   H2OStart = TRUE,
#'   H2OShutdown = TRUE,
#'   ReturnLayer = 4L)
#' }
#' @return A data.table
#' @export
H2OAutoencoderScoring <- function(data,
                                  Features = NULL,
                                  RemoveFeatures = FALSE,
                                  ModelObject = NULL,
                                  AnomalyDetection = TRUE,
                                  DimensionReduction = TRUE,
                                  ReturnLayer = 4L,
                                  per_feature = TRUE,
                                  NThreads = max(1L, parallel::detectCores()-2L),
                                  MaxMem = "28G",
                                  H2OStart = TRUE,
                                  H2OShutdown = TRUE,
                                  ModelID = "TestModel",
                                  model_path = NULL) {

  # Ensure data.table ----
  if(!data.table::is.data.table(data)) data.table::setDT(data)

  # Return because of mispecified arguments ----
  if(!AnomalyDetection && !DimensionReduction) stop("At least one of AnomalyDetection or DimensionReduction must be set to TRUE")

  # Constants ----
  if(is.numeric(Features) || is.integer(Features)) Features <- names(data)[Features]

  # Ensure categoricals are set as factors ----
  temp <- data[, .SD, .SDcols = c(Features)]
  data[, (Features) := NULL]
  temp <- ModelDataPrep(data=temp, Impute=FALSE, CharToFactor=TRUE, FactorToChar=FALSE, IntToNumeric=FALSE, DateToChar=FALSE, RemoveDates=TRUE, MissFactor="0", MissNum=-1, IgnoreCols=NULL)

  # Initialize H2O ----
  if(H2OStart) h2o::h2o.init(nthreads = NThreads, max_mem_size = MaxMem, enable_assertions = FALSE)
  H2O_Data <- h2o::as.h2o(temp)
  if(is.null(ModelObject)) ModelObject <- h2o::h2o.loadModel(path = file.path(model_path, ModelID))

  # Create and Merge features ----
  if(AnomalyDetection && DimensionReduction) {
    Data <- cbind(
      data,
      temp,
      data.table::as.data.table(h2o::h2o.deepfeatures(object = ModelObject, data = H2O_Data, layer = ReturnLayer)),
      data.table::as.data.table(h2o::h2o.anomaly(object = ModelObject, data = H2O_Data, per_feature = per_feature)))
  } else if(!AnomalyDetection && DimensionReduction) {
    Data <- cbind(
      data,
      temp,
      data.table::as.data.table(h2o::h2o.deepfeatures(object = ModelObject, data = H2O_Data, layer = ReturnLayer)))
  } else if(AnomalyDetection && !DimensionReduction) {
    Data <- cbind(
      data,
      temp,
      data.table::as.data.table(h2o::h2o.anomaly(object = ModelObject, data = H2O_Data, per_feature = per_feature)))
  }

  # Remove H2O Objects ----
  h2o::h2o.rm(ModelObject, H2O_Data)

  # Shutdown h2o ----
  if(H2OShutdown) h2o::h2o.shutdown(prompt = FALSE)

  # Remove features ----
  if(RemoveFeatures) data.table::set(Data, j = Features, value = NULL)

  # Return output ----
  return(Data)
}
