library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)

setwd('/Users/amir/Documents/GitHub/dash-sample-apps/apps/dashr-smartforceps')
source("data.R")
source("figs.R")

buildUpperLeftPanel <- function(){
  htmlDiv(
    id = "upper-left",
    className = "six columns",
    children = list(
      htmlH5(
        className = "section-title",
        paste(
          "Choose feature from the list below",
          "and select the task segment from the graph"
        )
      ),
      htmlDiv(
        id = "select-feature-metric",
        children = list(
          htmlDiv(
            id = "feature-select-outer",
            style = list(width = "99%"),
            children = list(
              htmlLabel("Select a Feature"),
              dccDropdown(
                id = 'feature_dropdown',
                options = default_options,
                value = 'DurationForce'
              )
            )
          )
        )
      ),
      
      htmlDiv(
        id = "feature-chart-outer",
        className = "twelve columns",
        children = list(
          htmlP(
            id = "chart-title",
            children =
              htmlH5(
                className = "section-title",
                sprintf(
                  "Feature Distribution Charts"
                  )
              )
          ),
          htmlDiv(
            id = "distribution_plot-loading-outer",
            children = list(
              dccLoading(
                id = "loading",
                children = dccGraph(
                  id = 'distribution_plot',
                  hoverData = list(points = list(list(customdata = '1'))),
                  figure = figs[[default_options[[1]]$value]]
                )
              )
            )
          )
        )
      )
    )
  )
}

app <- Dash$new()

app$layout(
  htmlDiv(
    list(
      htmlDiv(
        id = "banner",
        className = "banner",
        children = list(
          htmlH6("SmartForceps Data Analytics"),
          htmlImg(src = "assets/orb-surgical-logo.png")
        )
      ),
      htmlDiv(
        id = "upper-container",
        className = "row",
        children = list(
          buildUpperLeftPanel(),
          
          htmlDiv(
            id = "feature-time-series-outer",
            className = "six columns",
            children = list(
              htmlP(
                id = "time-series-title",
                children =
                  htmlH5(
                    className = "section-title",
                    sprintf(
                      "Force Time Series of Selected Task Cycle"
                    )
                  )
              ),
              
              htmlDiv(
                id = "lower-top-container",
                children = list(
                  dccLoading(
                    id = "loading-right",
                    children = dccGraph(
                      id = 'right-time-series'
                    )
                  )
                )
              ),
              htmlDiv(
                id = "lower-bottom-container",
                children = list(
                  dccLoading(
                    id = "loading-left",
                    children = dccGraph(
                      id = 'left-time-series'
                    )
                  )
                )
              )
            )
          )
        )
      )
    )
  )
)

app$callback(
  output = list(id='distribution_plot', property='figure'),
  params = list(input(id='feature_dropdown', property='value')),
  function(feature_name) {
    return (figs[[feature_name]])
  }
)

app$callback(
  output = list(id='right-time-series', property='figure'),
  params = list(input(id='distribution_plot', property='hoverData')),
  function(hoverData) {
    segment_num = hoverData$points[[1]]$customdata
    df_processed <- df_processed[df_processed[["SegmentNumOverall"]] %in% segment_num, ]
    df_processed <- df_processed[df_processed[["ProngName"]] %in% "RightForce", ]
    return(plot_ly(df_processed,
                   x = ~Time,
                   y = ~Value,
                   type = 'scatter',
                   mode = 'lines',
                   height = 300) %>%
             layout(title="Force Time Series of Right Prong",
                    xaxis = list(title = "Time (sec)"),
                    yaxis = list(title = "Right Force (N)"),
                    margin = list(t = 50, b = 10, l = 50, r = 50),   
                    plot_bgcolor = "#171b26",
                    paper_bgcolor = "#171b26"))
  }
)

app$callback(
  output = list(id='left-time-series', property='figure'),
  params = list(input(id='distribution_plot', property='hoverData')),
  function(hoverData) {
    segment_num = hoverData$points[[1]]$customdata
    df_processed <- df_processed[df_processed[["SegmentNumOverall"]] %in% segment_num, ]
    df_processed <- df_processed[df_processed[["ProngName"]] %in% "LeftForce", ]
    return(plot_ly(df_processed,
                   x = ~Time,
                   y = ~Value,
                   type = 'scatter',
                   mode = 'lines',
                   height = 300) %>%
             layout(title="Force Time Series of Left Prong",
                    xaxis = list(title = "Time (sec)"),
                    yaxis = list(title = "Left Force (N)"),
                    margin = list(t = 50, b = 10, l = 50, r = 50),   
                    plot_bgcolor = "#171b26",
                    paper_bgcolor = "#171b26"))
  }
)

app$run_server()