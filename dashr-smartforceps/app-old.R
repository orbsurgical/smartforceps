library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)

setwd('/Users/amir/Documents/GitHub/dash-sample-apps/apps/dashr-smartforceps')
source("data.R")
source("figs.R")

app <- Dash$new()

app$layout(
  htmlDiv(
    id = "top",
    className = "twelve columns",
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
        
        id = "dropdown_top",
        className = "twelve columns",
        
        children = list(
          
          htmlH5(
            className = "feature_dropdown",
            "Select a Feature",
            style = list(width = '99%', 
                         flaot = 'display', 
                         display = 'inline-block')
          ),

          dccDropdown(
            id = 'feature_dropdown',
            options = default_options,
            value = 'DurationForce'
          )
          
        )
        
      )
      
      
      # htmlDiv(list(
      #   dccDropdown(
      #     id = 'feature_dropdown',
      #     options = default_options,
      #     value = 'DurationForce'
      #   )
      # ), style = list(width = '99%', flaot = 'display', display = 'inline-block'))
      
      
    ), style = list(
      borderBottom = 'thin lightgrey solid',
      backgroundColor = 'rgb(250, 250, 250)',
      padding = '10px 5px')
    ),
    
    htmlDiv(list(
      dccGraph(
        id = 'distribution_plot',
        hoverData = list(points = list(list(customdata = '1'))),
        figure = figs[[default_options[[1]]$value]]
        )), style = list(
          width ='99%',
          display = 'inline-block',
          padding = '0 20')
      ),

    htmlDiv(list(
      dccGraph(
        id='right-time-series'
        ),
      dccGraph(
        id='left-time-series'
        )), style = list(
          display = 'inline-block', 
          width = '99%'))
  ))
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
                   mode = 'lines') %>%
             layout(xaxis = list(title = "Time (sec)"),
                    yaxis = list (title = "Right Force")))
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
                   mode = 'lines') %>%
             layout(xaxis = list(title = "Time (sec)"),
                    yaxis = list (title = "Left Force")))
  }
)

app$run_server()