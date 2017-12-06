library(jsonlite)
library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)

#API limits one pull to 20 
data1 <- fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=0")
data2 <- fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=20")
data3 <- fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=40")


data.twenty <- flatten(data1$data$attributes)

data <- select(data.twenty, synopsis, averageRating, userCount, favoritesCount, startDate, endDate, popularityRank, ratingRank, ageRating, episodeCount, youtubeVideoId, posterImage.original, coverImage.original)

Scatter <- function(d, x, y){
  p <- plot_ly(
    data = data, x = ~x, y = ~y, type = "scatter", mode = "markers", 
    marker = list(size = 10,
                  color = 'rgba(255, 182, 193, .9)',
                  line = list(color = 'rgba(152, 0, 0, .8)',
                              width = 2))
  )
}

my.server <- function(input, output) {
  output$scatterplot <- renderPlotly({ 
    return(Scatter(data, data$userCount, data$favoritesCount))
  }) 
}

shinyServer(my.server)