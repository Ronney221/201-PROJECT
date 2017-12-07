library('shiny')
library('plotly')


my.ui <- fluidPage(
  
  titlePanel("Kitsu Anime"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons("ageR","Age Rating:",
                   choices = c("R", "PG", "G"),
                   selected = "PG")
    ),

    mainPanel(
      plotlyOutput("scatterplot")
    )
  )
) 

shinyUI(my.ui)