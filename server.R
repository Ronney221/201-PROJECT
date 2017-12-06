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

Scatter <- function(data, x, y, min, max){
  p <- ggplot(data, aes_string(x = x, y = y)) + geom_point(na.rm = FALSE) + geom_count() + ylim(min, max)
  return(ggplotly(p))
}

my.server <- function(input, output) {
  output$scatterplot <- renderPlotly({ 
    return(Scatter(data, data$averageRating, data$userCount, 70, 90))
  }) 
}

shinyServer(my.server)