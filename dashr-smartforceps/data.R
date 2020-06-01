library(reshape2, warn.conflicts = FALSE)
library(foreach, warn.conflicts = FALSE)
library(glue, warn.conflicts = FALSE)
library(dplyr, warn.conflicts = FALSE)

load("data/SmartForcepsDataFeature.RData")
load("data/SmartForcepsDataProcessed.RData")
load("data/SmartForcepsDataSummary.RData")

df_feature <- melt(data = force_seg_info, 
                   id.vars = c("CaseNum", "SegmentNum", "SegmentNumOverall", "TaskType", "User"), 
                   measure.vars = c("DurationForce", "MeanForce", "MaxForce", "MinForce", "RangeForce", 
                                    "ForcePeaks", "DForceSD", "nPeriod", "Frequency", "PeriodLn", "Trend", 
                                    "FluctAnal", "Linearity", "Stability", "Lumpiness", "Curvature", "Entropy",
                                    "AutocorrFuncE1", "AutocorrFuncE10"),
                   variable.name = "FeatureName",
                   value.name = "Value")
df_feature <- data.frame(lapply(df_feature, as.character), stringsAsFactors=FALSE)

df_processed <- melt(data = force_seg_data, 
                     id.vars = c("CaseNum", "SegmentNum", "SegmentNumTask", "SegmentNumOverall", "TaskType", "Time"), 
                     measure.vars = c("LeftForce", "RightForce"),
                     variable.name = "ProngName",
                     value.name = "Value")

df_summary <- force_summary

returnOptions <- function(feature_data){ 
  features <- feature_data$FeatureName %>% unique(.)
  foreach(i=features) %do% list('label'=glue('feature: {i}'), 'value'=i)
}

default_featureid <- "DurationForce"
default_feature_input <- df_feature[df_feature$FeatureName==default_featureid, ]
default_options <- returnOptions(df_feature)