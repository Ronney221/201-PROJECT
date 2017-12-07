library('shiny')
library('plotly')


my.ui <- fluidPage(
  
  titlePanel("Kitsu Anime"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons("type","Show Type:",
                   choices = c("TV", "movie", "OVA", "special"))
    ),

    mainPanel(
      plotlyOutput("scatterplot")
    )
  )
) 

shinyUI(my.ui)