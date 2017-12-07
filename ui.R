library('shiny')
library('plotly')


my.ui <- fluidPage(
  
  titlePanel("Kitsu Anime"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons("ageR","Age Rating:",
                   choices = c("R", "PG", "G"),
                   selected = "PG"),
      radioButtons("showTypes", "Overview of Showtypes or Specific Anime",
                          choices = c("Overview", "Specific")),
      selectInput("specificAnime", "Choose an Anime",
                    choices = c("Neon Genesis Evangelion", 
                                "Rurouni Kenshin: Meiji Kenkaku Romantan",
                                "Mobile Suit Gundam", "Cowboy Bebop",
                                "El Hazard", "Hunter x Hunter",
                                "Initial D", "Love Hina"), 
                  selected = "Neon Genesis Evangelion")
    ),

    mainPanel(
      plotlyOutput("scatterplot"),
      plotlyOutput("pie")
    )
  )
) 

shinyUI(my.ui)