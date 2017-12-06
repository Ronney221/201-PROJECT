library(jsonlite)
library(plyr)
library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)

#API limits one pull to 20 data values
data1 <- flatten(fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=0")$data$attributes)
data2 <- flatten(fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=20")$data$attributes)
data3 <- flatten(fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=40")$data$attributes)
data4 <- flatten(fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=60")$data$attributes)
data5 <- flatten(fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=80")$data$attributes)
data6 <- flatten(fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=100")$data$attributes)
data7 <- flatten(fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=120")$data$attributes)
data8 <- flatten(fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=140")$data$attributes)
data9 <- flatten(fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=160")$data$attributes)
data10 <- flatten(fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=180")$data$attributes)

#combines the 10 dataframes into one data frame w/ 200 values
combined <- rbind.fill(list(data1, data2, data3, data4, data5, data6, data7, data8, data9, data10))

data <- select(combined, canonicalTitle, synopsis, averageRating, userCount, favoritesCount, startDate,
               endDate, popularityRank, ratingRank, ageRating, episodeCount, youtubeVideoId, 
               posterImage.original, coverImage.original)




Scatter.one <- function(d, x, y){
  p <- plot_ly(
    data = data, x = ~x, y = ~y, type = "scatter", mode = "markers", 
    marker = list(size = 10,
                  color = 'rgba(139, 72, 246, .9)',
                  line = list(color = 'rgba(166, 111, 236, .8)',
                              width = 2)))
}

Scatter.two <- function(d, x, y){
  p <- ggplot(d, aes_string( x = x, y = y)) + geom_point() +  geom_count(color = "rgba(139, 72, 246, .9") + 
    ggtitle("Viewer Count vs Favorite Count") + xlab("User Count") + ylab("Favorite Count")
  
  return(ggplotly(p))
}

my.server <- function(input, output) {
  output$scatterplot <- renderPlotly({ 
    print(input$ageR)
    data.change <- filter(data, ageRating == input$ageR)
    return(Scatter.two(data.change, data.change$userCount, data.change$favoritesCount))
  }) 
}

shinyServer(my.server)