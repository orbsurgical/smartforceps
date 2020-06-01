library(plotly, warn.conflicts = FALSE)

# force_labels <- data.frame(
#   "feature" = c("DurationForce", 
#                 "MeanForce", 
#                 "MaxForce", 
#                 "MinForce", 
#                 "RangeForce", 
#                 "ForcePeaks", 
#                 "DForceSD", 
#                 "nPeriod", 
#                 "Frequency", 
#                 "PeriodLn", 
#                 "Trend", 
#                 "FluctAnal", 
#                 "Linearity", 
#                 "Stability", 
#                 "Lumpiness", 
#                 "Curvature", 
#                 "Entropy", 
#                 "AutocorrFuncE1", 
#                 "AutocorrFuncE10"),
#   "title" = c("Distribution of Force Application Duration",
#               "Distribution of Force Mean",
#               "Distribution of Force Max",
#               "Distribution of Force Min",
#               "Distribution of Force Range",
#               "Distribution of the Average of Force Peaks",
#               "Distribution of Standard Deviation for the First Derivative of the Force Signal",
#               "Distribution of the Number of Force Peaks",
#               "Distribution of Dominant Time-series Harmonics form FFT",
#               "Distribution of the Average Length of Force Cycles",
#               "Distribution of Force Signal Trend",
#               "Distribution of Force Signal Fluctuation Index",
#               "Distribution of Force Signal Linearity Index",
#               "Distribution of Force Signal Stability Index",
#               "Distribution of Force Signal Lumpiness Index",
#               "Distribution of Force Signal Curvature Index",
#               "Distribution of Force Signal Entropy Index",
#               "Distribution of First Autocorrelation Coefficient in Force Signal",
#               "Distribution of Sum of the First 10 Squared Autocorrelation Coefficient in Force Signal"),
#   "x_title" = c("Duration (sec)",
#                 "Force (N)",
#                 "Force (N)",
#                 "Force (N)",
#                 "Force (N)",
#                 "Force (N)",
#                 "Standard Deviation of the First Derivative of Force",
#                 "Number of Force Peaks",
#                 "Frequency (Hz)",
#                 "Cycle Length (sec)",
#                 "Trend",
#                 "Fluctuation Index",
#                 "Linearity Index",
#                 "Stability Index",
#                 "Lumpiness Index",
#                 "Curvature Index",
#                 "Entropy Index",
#                 "Autocorrelation Coefficient",
#                 "Autocorrelation Coefficient")
#     )
# 
# fig_feature <- function(force_seg_info, feature_in) {
#   
#   feature_select <- as.character(force_labels[force_labels$feature == feature_in, ]$feature)
#   title_select <- as.character(force_labels[force_labels$feature == feature_in, ]$title)
#   x_title_select <- as.character(force_labels[force_labels$feature == feature_in, ]$x_title)
#   
#   fig <- plot_ly(type = 'violin')
#   fig <- add_trace( 
#     fig,
#     x = force_seg_info[force_seg_info$User == 'Expert', ]$feature_select, 
#     y = force_seg_info[force_seg_info$User == 'Expert', ]$TaskType, 
#     customdata = force_seg_info[force_seg_info$User == 'Expert', ]$SegmentNumOverall, 
#     orientation = "h",
#     legendgroup = 'Expert',
#     scalegroup = 'Expert',
#     name = 'Expert',
#     side = 'positive',
#     points="all",
#     box = list(
#       visible = T
#     ),
#     meanline = list(
#       visible = T
#     ),
#     color = I("lightseagreen"),
#     marker = list(
#       line = list(
#         width = 1,
#         color = "lightseagreen"
#       ),
#       symbol = 'line-ns'
#     )
#   )
#   
#   fig <- add_trace( 
#     fig,
#     x = force_seg_info[force_seg_info$User == 'Novice', ]$feature_select, 
#     y = force_seg_info[force_seg_info$User == 'Novice', ]$TaskType, 
#     customdata = force_seg_info[force_seg_info$User == 'Novice', ]$SegmentNumOverall, 
#     orientation = "h",
#     legendgroup = 'Novice',
#     scalegroup = 'Novice',
#     name = 'Novice',
#     side = 'negative',
#     points="all",
#     box = list(
#       visible = T
#     ),
#     meanline = list(
#       visible = T
#     ),
#     color = I("mediumpurple"),
#     marker = list(
#       line = list(
#         width = 1,
#         color = "mediumpurple"
#       ),
#       symbol = 'line-ns'
#     )
#   )
#   
#   fig <- layout(
#     fig,
#     title = title_select,
#     xaxis = list(
#       title = x_title_select,
#       showgrid = T
#     ),
#     yaxis = list(
#       title = "Task Type",
#       showgrid = T,
#       zeroline = F
#     ),
#     margin = list(t = 50, b = 10, l = 50, r = 50)
#   )
#   
#   return (fig)
# }


figs <- list()

fig <- plot_ly(type = 'violin')

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Expert', ]$DurationForce,
  y = force_seg_info[force_seg_info$User == 'Expert', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Expert', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Expert',
  scalegroup = 'Expert',
  name = 'Expert',
  side = 'positive',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("lightseagreen"),
  marker = list(
    line = list(
      width = 1,
      color = "lightseagreen"
    ),
    symbol = 'line-ns'
  )
)

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Novice', ]$DurationForce,
  y = force_seg_info[force_seg_info$User == 'Novice', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Novice', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Novice',
  scalegroup = 'Novice',
  name = 'Novice',
  side = 'negative',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("mediumpurple"),
  marker = list(
    line = list(
      width = 1,
      color = "mediumpurple"
    ),
    symbol = 'line-ns'
  )
)

fig <- layout(
  fig,
  title = "Distribution of Force Application Duration",
  xaxis = list(
    title = "Duration (sec)",
    showgrid = T
  ),
  yaxis = list(
    title = "Task Type",
    showgrid = T,
    zeroline = F
  ),
  margin = list(t = 50, b = 10, l = 50, r = 50),   
  plot_bgcolor = "#171b26",
  paper_bgcolor = "#171b26"
)

figs[["DurationForce"]] <- fig

###########################################################################

temp_data <- data.frame("TaskType" = force_seg_info$TaskType, 
                        "User" = force_seg_info$User,
                        "MeanForce" = force_seg_info$MeanForce)

fig <- plot_ly(type = 'violin')

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Expert', ]$MeanForce,
  y = force_seg_info[force_seg_info$User == 'Expert', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Expert', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Expert',
  scalegroup = 'Expert',
  name = 'Expert',
  side = 'positive',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("lightseagreen"),
  marker = list(
    line = list(
      width = 1,
      color = "lightseagreen"
    ),
    symbol = 'line-ns'
  )
)

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Novice', ]$MeanForce,
  y = force_seg_info[force_seg_info$User == 'Novice', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Novice', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Novice',
  scalegroup = 'Novice',
  name = 'Novice',
  side = 'negative',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("mediumpurple"),
  marker = list(
    line = list(
      width = 1,
      color = "mediumpurple"
    ),
    symbol = 'line-ns'
  )
)

fig <- layout(
  fig,
  title = "Distribution of Force Mean",
  xaxis = list(
    title = "Force (N)",
    showgrid = T
  ),
  yaxis = list(
    title = "Task Type",
    showgrid = T,
    zeroline = F
  ),
  margin = list(t = 50, b = 10, l = 50, r = 50),
  plot_bgcolor = "#171b26",
  paper_bgcolor = "#171b26"
)

figs[["MeanForce"]] <- fig

###########################################################################

temp_data <- data.frame("TaskType" = force_seg_info$TaskType, 
                        "User" = force_seg_info$User,
                        "MaxForce" = force_seg_info$MeanForce)

fig <- plot_ly(type = 'violin')

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Expert', ]$MaxForce,
  y = force_seg_info[force_seg_info$User == 'Expert', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Expert', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Expert',
  scalegroup = 'Expert',
  name = 'Expert',
  side = 'positive',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("lightseagreen"),
  marker = list(
    line = list(
      width = 1,
      color = "lightseagreen"
    ),
    symbol = 'line-ns'
  )
)

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Novice', ]$MaxForce,
  y = force_seg_info[force_seg_info$User == 'Novice', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Novice', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Novice',
  scalegroup = 'Novice',
  name = 'Novice',
  side = 'negative',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("mediumpurple"),
  marker = list(
    line = list(
      width = 1,
      color = "mediumpurple"
    ),
    symbol = 'line-ns'
  )
)

fig <- layout(
  fig,
  title = "Distribution of Force Max",
  xaxis = list(
    title = "Force (N)",
    showgrid = T
  ),
  yaxis = list(
    title = "Task Type",
    showgrid = T,
    zeroline = F
  ),
  margin = list(t = 50, b = 10, l = 50, r = 50),
  plot_bgcolor = "#171b26",
  paper_bgcolor = "#171b26"
)

figs[["MaxForce"]] <- fig

###########################################################################

temp_data <- data.frame("TaskType" = force_seg_info$TaskType, 
                        "User" = force_seg_info$User,
                        "MinForce" = force_seg_info$MeanForce)

fig <- plot_ly(type = 'violin')

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Expert', ]$MinForce,
  y = force_seg_info[force_seg_info$User == 'Expert', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Expert', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Expert',
  scalegroup = 'Expert',
  name = 'Expert',
  side = 'positive',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("lightseagreen"),
  marker = list(
    line = list(
      width = 1,
      color = "lightseagreen"
    ),
    symbol = 'line-ns'
  )
)

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Novice', ]$MinForce,
  y = force_seg_info[force_seg_info$User == 'Novice', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Novice', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Novice',
  scalegroup = 'Novice',
  name = 'Novice',
  side = 'negative',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("mediumpurple"),
  marker = list(
    line = list(
      width = 1,
      color = "mediumpurple"
    ),
    symbol = 'line-ns'
  )
)

fig <- layout(
  fig,
  title = "Distribution of Force Min",
  xaxis = list(
    title = "Force (N)",
    showgrid = T
  ),
  yaxis = list(
    title = "Task Type",
    showgrid = T,
    zeroline = F
  ),
  margin = list(t = 50, b = 10, l = 50, r = 50),
  plot_bgcolor = "#171b26",
  paper_bgcolor = "#171b26"
)

figs[["MinForce"]] <- fig

###########################################################################

temp_data <- data.frame("TaskType" = force_seg_info$TaskType, 
                        "User" = force_seg_info$User,
                        "RangeForce" = force_seg_info$MeanForce)

fig <- plot_ly(type = 'violin')

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Expert', ]$RangeForce,
  y = force_seg_info[force_seg_info$User == 'Expert', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Expert', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Expert',
  scalegroup = 'Expert',
  name = 'Expert',
  side = 'positive',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("lightseagreen"),
  marker = list(
    line = list(
      width = 1,
      color = "lightseagreen"
    ),
    symbol = 'line-ns'
  )
)

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Novice', ]$RangeForce,
  y = force_seg_info[force_seg_info$User == 'Novice', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Novice', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Novice',
  scalegroup = 'Novice',
  name = 'Novice',
  side = 'negative',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("mediumpurple"),
  marker = list(
    line = list(
      width = 1,
      color = "mediumpurple"
    ),
    symbol = 'line-ns'
  )
)

fig <- layout(
  fig,
  title = "Distribution of Force Range",
  xaxis = list(
    title = "Force (N)",
    showgrid = T
  ),
  yaxis = list(
    title = "Task Type",
    showgrid = T,
    zeroline = F
  ),
  margin = list(t = 50, b = 10, l = 50, r = 50),
  plot_bgcolor = "#171b26",
  paper_bgcolor = "#171b26"
)

figs[["RangeForce"]] <- fig

###########################################################################

temp_data <- data.frame("TaskType" = force_seg_info$TaskType, 
                        "User" = force_seg_info$User,
                        "ForcePeaks" = force_seg_info$MeanForce)

fig <- plot_ly(type = 'violin')

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Expert', ]$ForcePeaks,
  y = force_seg_info[force_seg_info$User == 'Expert', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Expert', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Expert',
  scalegroup = 'Expert',
  name = 'Expert',
  side = 'positive',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("lightseagreen"),
  marker = list(
    line = list(
      width = 1,
      color = "lightseagreen"
    ),
    symbol = 'line-ns'
  )
)

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Novice', ]$ForcePeaks,
  y = force_seg_info[force_seg_info$User == 'Novice', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Novice', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Novice',
  scalegroup = 'Novice',
  name = 'Novice',
  side = 'negative',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("mediumpurple"),
  marker = list(
    line = list(
      width = 1,
      color = "mediumpurple"
    ),
    symbol = 'line-ns'
  )
)

fig <- layout(
  fig,
  title = "Distribution of the Average of Force Peaks",
  xaxis = list(
    title = "Force (N)",
    showgrid = T
  ),
  yaxis = list(
    title = "Task Type",
    showgrid = T,
    zeroline = F
  ),
  margin = list(t = 50, b = 10, l = 50, r = 50),
  plot_bgcolor = "#171b26",
  paper_bgcolor = "#171b26"
)

figs[["ForcePeaks"]] <- fig

###########################################################################

temp_data <- data.frame("TaskType" = force_seg_info$TaskType, 
                        "User" = force_seg_info$User,
                        "DForceSD" = force_seg_info$MeanForce)

fig <- plot_ly(type = 'violin')

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Expert', ]$DForceSD,
  y = force_seg_info[force_seg_info$User == 'Expert', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Expert', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Expert',
  scalegroup = 'Expert',
  name = 'Expert',
  side = 'positive',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("lightseagreen"),
  marker = list(
    line = list(
      width = 1,
      color = "lightseagreen"
    ),
    symbol = 'line-ns'
  )
)

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Novice', ]$DForceSD,
  y = force_seg_info[force_seg_info$User == 'Novice', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Novice', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Novice',
  scalegroup = 'Novice',
  name = 'Novice',
  side = 'negative',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("mediumpurple"),
  marker = list(
    line = list(
      width = 1,
      color = "mediumpurple"
    ),
    symbol = 'line-ns'
  )
)

fig <- layout(
  fig,
  title = "Distribution of Standard Deviation for the First Derivative of the Force Signal",
  xaxis = list(
    title = "Standard Deviation of the First Derivative of Force",
    showgrid = T
  ),
  yaxis = list(
    title = "Task Type",
    showgrid = T,
    zeroline = F
  ),
  margin = list(t = 50, b = 10, l = 50, r = 50),
  plot_bgcolor = "#171b26",
  paper_bgcolor = "#171b26"
)

figs[["DForceSD"]] <- fig

###########################################################################

temp_data <- data.frame("TaskType" = force_seg_info$TaskType, 
                        "User" = force_seg_info$User,
                        "nPeriod" = force_seg_info$MeanForce)

fig <- plot_ly(type = 'violin')

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Expert', ]$nPeriod,
  y = force_seg_info[force_seg_info$User == 'Expert', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Expert', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Expert',
  scalegroup = 'Expert',
  name = 'Expert',
  side = 'positive',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("lightseagreen"),
  marker = list(
    line = list(
      width = 1,
      color = "lightseagreen"
    ),
    symbol = 'line-ns'
  )
)

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Novice', ]$nPeriod,
  y = force_seg_info[force_seg_info$User == 'Novice', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Novice', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Novice',
  scalegroup = 'Novice',
  name = 'Novice',
  side = 'negative',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("mediumpurple"),
  marker = list(
    line = list(
      width = 1,
      color = "mediumpurple"
    ),
    symbol = 'line-ns'
  )
)

fig <- layout(
  fig,
  title = "Distribution of the Number of Force Peaks",
  xaxis = list(
    title = "Number of Force Peaks",
    showgrid = T
  ),
  yaxis = list(
    title = "Task Type",
    showgrid = T,
    zeroline = F
  ),
  margin = list(t = 50, b = 10, l = 50, r = 50),
  plot_bgcolor = "#171b26",
  paper_bgcolor = "#171b26"
)

figs[["nPeriod"]] <- fig

###########################################################################

temp_data <- data.frame("TaskType" = force_seg_info$TaskType, 
                        "User" = force_seg_info$User,
                        "Frequency" = force_seg_info$MeanForce)

fig <- plot_ly(type = 'violin')

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Expert', ]$Frequency,
  y = force_seg_info[force_seg_info$User == 'Expert', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Expert', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Expert',
  scalegroup = 'Expert',
  name = 'Expert',
  side = 'positive',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("lightseagreen"),
  marker = list(
    line = list(
      width = 1,
      color = "lightseagreen"
    ),
    symbol = 'line-ns'
  )
)

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Novice', ]$Frequency,
  y = force_seg_info[force_seg_info$User == 'Novice', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Novice', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Novice',
  scalegroup = 'Novice',
  name = 'Novice',
  side = 'negative',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("mediumpurple"),
  marker = list(
    line = list(
      width = 1,
      color = "mediumpurple"
    ),
    symbol = 'line-ns'
  )
)

fig <- layout(
  fig,
  title = "Distribution of Dominant Time-series Harmonics form FFT",
  xaxis = list(
    title = "Frequency (Hz)",
    showgrid = T
  ),
  yaxis = list(
    title = "Task Type",
    showgrid = T,
    zeroline = F
  ),
  margin = list(t = 50, b = 10, l = 50, r = 50),
  plot_bgcolor = "#171b26",
  paper_bgcolor = "#171b26"
)

figs[["Frequency"]] <- fig

###########################################################################

temp_data <- data.frame("TaskType" = force_seg_info$TaskType, 
                        "User" = force_seg_info$User,
                        "PeriodLn" = force_seg_info$MeanForce)

fig <- plot_ly(type = 'violin')

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Expert', ]$PeriodLn,
  y = force_seg_info[force_seg_info$User == 'Expert', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Expert', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Expert',
  scalegroup = 'Expert',
  name = 'Expert',
  side = 'positive',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("lightseagreen"),
  marker = list(
    line = list(
      width = 1,
      color = "lightseagreen"
    ),
    symbol = 'line-ns'
  )
)

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Novice', ]$PeriodLn,
  y = force_seg_info[force_seg_info$User == 'Novice', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Novice', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Novice',
  scalegroup = 'Novice',
  name = 'Novice',
  side = 'negative',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("mediumpurple"),
  marker = list(
    line = list(
      width = 1,
      color = "mediumpurple"
    ),
    symbol = 'line-ns'
  )
)

fig <- layout(
  fig,
  title = "Distribution of the Average Length of Force Cycles",
  xaxis = list(
    title = "Cycle Length (sec)",
    showgrid = T
  ),
  yaxis = list(
    title = "Task Type",
    showgrid = T,
    zeroline = F
  ),
  margin = list(t = 50, b = 10, l = 50, r = 50),
  plot_bgcolor = "#171b26",
  paper_bgcolor = "#171b26"
)

figs[["PeriodLn"]] <- fig

###########################################################################

temp_data <- data.frame("TaskType" = force_seg_info$TaskType, 
                        "User" = force_seg_info$User,
                        "Trend" = force_seg_info$MeanForce)

fig <- plot_ly(type = 'violin')

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Expert', ]$Trend,
  y = force_seg_info[force_seg_info$User == 'Expert', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Expert', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Expert',
  scalegroup = 'Expert',
  name = 'Expert',
  side = 'positive',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("lightseagreen"),
  marker = list(
    line = list(
      width = 1,
      color = "lightseagreen"
    ),
    symbol = 'line-ns'
  )
)

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Novice', ]$Trend,
  y = force_seg_info[force_seg_info$User == 'Novice', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Novice', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Novice',
  scalegroup = 'Novice',
  name = 'Novice',
  side = 'negative',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("mediumpurple"),
  marker = list(
    line = list(
      width = 1,
      color = "mediumpurple"
    ),
    symbol = 'line-ns'
  )
)

fig <- layout(
  fig,
  title = "Distribution of Force Signal Trend",
  xaxis = list(
    title = "Trend",
    showgrid = T
  ),
  yaxis = list(
    title = "Task Type",
    showgrid = T,
    zeroline = F
  ),
  margin = list(t = 50, b = 10, l = 50, r = 50),
  plot_bgcolor = "#171b26",
  paper_bgcolor = "#171b26"
)

figs[["Trend"]] <- fig

###########################################################################

temp_data <- data.frame("TaskType" = force_seg_info$TaskType, 
                        "User" = force_seg_info$User,
                        "FluctAnal" = force_seg_info$MeanForce)

fig <- plot_ly(type = 'violin')

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Expert', ]$FluctAnal,
  y = force_seg_info[force_seg_info$User == 'Expert', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Expert', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Expert',
  scalegroup = 'Expert',
  name = 'Expert',
  side = 'positive',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("lightseagreen"),
  marker = list(
    line = list(
      width = 1,
      color = "lightseagreen"
    ),
    symbol = 'line-ns'
  )
)

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Novice', ]$FluctAnal,
  y = force_seg_info[force_seg_info$User == 'Novice', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Novice', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Novice',
  scalegroup = 'Novice',
  name = 'Novice',
  side = 'negative',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("mediumpurple"),
  marker = list(
    line = list(
      width = 1,
      color = "mediumpurple"
    ),
    symbol = 'line-ns'
  )
)

fig <- layout(
  fig,
  title = "Distribution of Force Signal Fluctuation Index",
  xaxis = list(
    title = "Fluctuation Index",
    showgrid = T
  ),
  yaxis = list(
    title = "Task Type",
    showgrid = T,
    zeroline = F
  ),
  margin = list(t = 50, b = 10, l = 50, r = 50),
  plot_bgcolor = "#171b26",
  paper_bgcolor = "#171b26"
)

figs[["FluctAnal"]] <- fig

###########################################################################

temp_data <- data.frame("TaskType" = force_seg_info$TaskType, 
                        "User" = force_seg_info$User,
                        "Linearity" = force_seg_info$MeanForce)

fig <- plot_ly(type = 'violin')

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Expert', ]$Linearity,
  y = force_seg_info[force_seg_info$User == 'Expert', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Expert', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Expert',
  scalegroup = 'Expert',
  name = 'Expert',
  side = 'positive',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("lightseagreen"),
  marker = list(
    line = list(
      width = 1,
      color = "lightseagreen"
    ),
    symbol = 'line-ns'
  )
)

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Novice', ]$Linearity,
  y = force_seg_info[force_seg_info$User == 'Novice', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Novice', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Novice',
  scalegroup = 'Novice',
  name = 'Novice',
  side = 'negative',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("mediumpurple"),
  marker = list(
    line = list(
      width = 1,
      color = "mediumpurple"
    ),
    symbol = 'line-ns'
  )
)

fig <- layout(
  fig,
  title = "Distribution of Force Signal Linearity Index",
  xaxis = list(
    title = "Linearity Index",
    showgrid = T
  ),
  yaxis = list(
    title = "Task Type",
    showgrid = T,
    zeroline = F
  ),
  margin = list(t = 50, b = 10, l = 50, r = 50),
  plot_bgcolor = "#171b26",
  paper_bgcolor = "#171b26"
)

figs[["Linearity"]] <- fig

###########################################################################

temp_data <- data.frame("TaskType" = force_seg_info$TaskType, 
                        "User" = force_seg_info$User,
                        "Stability" = force_seg_info$MeanForce)

fig <- plot_ly(type = 'violin')

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Expert', ]$Stability,
  y = force_seg_info[force_seg_info$User == 'Expert', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Expert', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Expert',
  scalegroup = 'Expert',
  name = 'Expert',
  side = 'positive',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("lightseagreen"),
  marker = list(
    line = list(
      width = 1,
      color = "lightseagreen"
    ),
    symbol = 'line-ns'
  )
)

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Novice', ]$Stability,
  y = force_seg_info[force_seg_info$User == 'Novice', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Novice', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Novice',
  scalegroup = 'Novice',
  name = 'Novice',
  side = 'negative',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("mediumpurple"),
  marker = list(
    line = list(
      width = 1,
      color = "mediumpurple"
    ),
    symbol = 'line-ns'
  )
)

fig <- layout(
  fig,
  title = "Distribution of Force Signal Stability Index",
  xaxis = list(
    title = "Stability Index",
    showgrid = T
  ),
  yaxis = list(
    title = "Task Type",
    showgrid = T,
    zeroline = F
  ),
  margin = list(t = 50, b = 10, l = 50, r = 50),
  plot_bgcolor = "#171b26",
  paper_bgcolor = "#171b26"
)

figs[["Stability"]] <- fig
 
###########################################################################

temp_data <- data.frame("TaskType" = force_seg_info$TaskType, 
                        "User" = force_seg_info$User,
                        "Lumpiness" = force_seg_info$MeanForce)

fig <- plot_ly(type = 'violin')

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Expert', ]$Lumpiness,
  y = force_seg_info[force_seg_info$User == 'Expert', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Expert', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Expert',
  scalegroup = 'Expert',
  name = 'Expert',
  side = 'positive',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("lightseagreen"),
  marker = list(
    line = list(
      width = 1,
      color = "lightseagreen"
    ),
    symbol = 'line-ns'
  )
)

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Novice', ]$Lumpiness,
  y = force_seg_info[force_seg_info$User == 'Novice', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Novice', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Novice',
  scalegroup = 'Novice',
  name = 'Novice',
  side = 'negative',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("mediumpurple"),
  marker = list(
    line = list(
      width = 1,
      color = "mediumpurple"
    ),
    symbol = 'line-ns'
  )
)

fig <- layout(
  fig,
  title = "Distribution of Force Signal Lumpiness Index",
  xaxis = list(
    title = "Lumpiness Index",
    showgrid = T
  ),
  yaxis = list(
    title = "Task Type",
    showgrid = T,
    zeroline = F
  ),
  margin = list(t = 50, b = 10, l = 50, r = 50),
  plot_bgcolor = "#171b26",
  paper_bgcolor = "#171b26"
)

figs[["Lumpiness"]] <- fig

###########################################################################

temp_data <- data.frame("TaskType" = force_seg_info$TaskType, 
                        "User" = force_seg_info$User,
                        "Curvature" = force_seg_info$MeanForce)

fig <- plot_ly(type = 'violin')

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Expert', ]$Curvature,
  y = force_seg_info[force_seg_info$User == 'Expert', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Expert', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Expert',
  scalegroup = 'Expert',
  name = 'Expert',
  side = 'positive',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("lightseagreen"),
  marker = list(
    line = list(
      width = 1,
      color = "lightseagreen"
    ),
    symbol = 'line-ns'
  )
)

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Novice', ]$Curvature,
  y = force_seg_info[force_seg_info$User == 'Novice', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Novice', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Novice',
  scalegroup = 'Novice',
  name = 'Novice',
  side = 'negative',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("mediumpurple"),
  marker = list(
    line = list(
      width = 1,
      color = "mediumpurple"
    ),
    symbol = 'line-ns'
  )
)

fig <- layout(
  fig,
  title = "Distribution of Force Signal Curvature Index",
  xaxis = list(
    title = "Curvature Index",
    showgrid = T
  ),
  yaxis = list(
    title = "Task Type",
    showgrid = T,
    zeroline = F
  ),
  margin = list(t = 50, b = 10, l = 50, r = 50),
  plot_bgcolor = "#171b26",
  paper_bgcolor = "#171b26"
)

figs[["Curvature"]] <- fig

###########################################################################

temp_data <- data.frame("TaskType" = force_seg_info$TaskType, 
                        "User" = force_seg_info$User,
                        "Entropy" = force_seg_info$MeanForce)

fig <- plot_ly(type = 'violin')

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Expert', ]$Entropy,
  y = force_seg_info[force_seg_info$User == 'Expert', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Expert', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Expert',
  scalegroup = 'Expert',
  name = 'Expert',
  side = 'positive',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("lightseagreen"),
  marker = list(
    line = list(
      width = 1,
      color = "lightseagreen"
    ),
    symbol = 'line-ns'
  )
)

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Novice', ]$Entropy,
  y = force_seg_info[force_seg_info$User == 'Novice', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Novice', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Novice',
  scalegroup = 'Novice',
  name = 'Novice',
  side = 'negative',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("mediumpurple"),
  marker = list(
    line = list(
      width = 1,
      color = "mediumpurple"
    ),
    symbol = 'line-ns'
  )
)

fig <- layout(
  fig,
  title = "Distribution of Force Signal Entropy Index",
  xaxis = list(
    title = "Entropy Index",
    showgrid = T
  ),
  yaxis = list(
    title = "Task Type",
    showgrid = T,
    zeroline = F
  ),
  margin = list(t = 50, b = 10, l = 50, r = 50),
  plot_bgcolor = "#171b26",
  paper_bgcolor = "#171b26"
)

figs[["Entropy"]] <- fig

###########################################################################

temp_data <- data.frame("TaskType" = force_seg_info$TaskType, 
                        "User" = force_seg_info$User,
                        "AutocorrFuncE1" = force_seg_info$MeanForce)

fig <- plot_ly(type = 'violin')

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Expert', ]$AutocorrFuncE1,
  y = force_seg_info[force_seg_info$User == 'Expert', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Expert', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Expert',
  scalegroup = 'Expert',
  name = 'Expert',
  side = 'positive',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("lightseagreen"),
  marker = list(
    line = list(
      width = 1,
      color = "lightseagreen"
    ),
    symbol = 'line-ns'
  )
)

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Novice', ]$AutocorrFuncE1,
  y = force_seg_info[force_seg_info$User == 'Novice', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Novice', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Novice',
  scalegroup = 'Novice',
  name = 'Novice',
  side = 'negative',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("mediumpurple"),
  marker = list(
    line = list(
      width = 1,
      color = "mediumpurple"
    ),
    symbol = 'line-ns'
  )
)

fig <- layout(
  fig,
  title = "Distribution of First Autocorrelation Coefficient in Force Signal",
  xaxis = list(
    title = "Autocorrelation Coefficient",
    showgrid = T
  ),
  yaxis = list(
    title = "Task Type",
    showgrid = T,
    zeroline = F
  ),
  margin = list(t = 50, b = 10, l = 50, r = 50),
  plot_bgcolor = "#171b26",
  paper_bgcolor = "#171b26"
)

figs[["AutocorrFuncE1"]] <- fig

###########################################################################

temp_data <- data.frame("TaskType" = force_seg_info$TaskType, 
                        "User" = force_seg_info$User,
                        "AutocorrFuncE10" = force_seg_info$MeanForce)

fig <- plot_ly(type = 'violin')

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Expert', ]$AutocorrFuncE10,
  y = force_seg_info[force_seg_info$User == 'Expert', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Expert', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Expert',
  scalegroup = 'Expert',
  name = 'Expert',
  side = 'positive',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("lightseagreen"),
  marker = list(
    line = list(
      width = 1,
      color = "lightseagreen"
    ),
    symbol = 'line-ns'
  )
)

fig <- add_trace(
  fig,
  x = force_seg_info[force_seg_info$User == 'Novice', ]$AutocorrFuncE10,
  y = force_seg_info[force_seg_info$User == 'Novice', ]$TaskType,
  customdata = force_seg_info[force_seg_info$User == 'Novice', ]$SegmentNumOverall,
  orientation = "h",
  legendgroup = 'Novice',
  scalegroup = 'Novice',
  name = 'Novice',
  side = 'negative',
  points="all",
  box = list(
    visible = T
  ),
  meanline = list(
    visible = T
  ),
  color = I("mediumpurple"),
  marker = list(
    line = list(
      width = 1,
      color = "mediumpurple"
    ),
    symbol = 'line-ns'
  )
)

fig <- layout(
  fig,
  title = "Distribution of Sum of the First 10 Squared Autocorrelation Coefficient in Force Signal",
  xaxis = list(
    title = "Autocorrelation Coefficient",
    showgrid = T
  ),
  yaxis = list(
    title = "Task Type",
    showgrid = T,
    zeroline = F
  ),
  margin = list(t = 50, b = 10, l = 50, r = 50),
  plot_bgcolor = "#171b26",
  paper_bgcolor = "#171b26"
)

figs[["AutocorrFuncE10"]] <- fig

