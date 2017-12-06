library('shiny')
library('plotly')


my.ui <- fluidPage(
  
  titlePanel("Kitsu Anime"),
    
    mainPanel(
      # prints plot on UI
      plotlyOutput("scatterplot")
    )
) 

shinyUI(my.ui)