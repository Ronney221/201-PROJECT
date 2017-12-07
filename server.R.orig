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

data <- select(combined, canonicalTitle, showType, synopsis, averageRating, userCount, favoritesCount, startDate,
               endDate, popularityRank, ratingRank, ageRating, ageRatingGuide, subtype, status, episodeCount, 
               youtubeVideoId, 
               posterImage.original, coverImage.original)




Scatter.two <- function(d){
  p <- ggplot(d, aes( x = userCount, 
                      y = (favoritesCount/userCount), 
                      color = ageRating, 
                      text = paste("Title:", canonicalTitle))) + 
    geom_point() + 
    labs(title = "Satisfaction Rate of Anime", 
         x = "View Count", 
         y = "Percent Favorited")
  
  return(ggplotly(p))
}


my.server <- function(input, output) {
<<<<<<< HEAD
  output$scatterplot <- renderPlotly({
    print(input$ageR)
    data.change <- filter(data, ageRating == input$ageR)
    return(Scatter.two(data.change, data.change$userCount, data.change$favoritesCount))
  })
  
  output$pie <- renderPlotly({
    types.of.show <- select(data, showType, userCount) %>% 
      group_by(showType) %>% 
      summarize(userCount = sum(userCount, na.rm=TRUE))
    if(input$showTypes == 'Overview') {
      p <- plot_ly(types.of.show, labels = ~showType, values = ~userCount, type = 'pie') %>%
          layout(title = 'User counts by show type',
                 xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                 yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
        return(p);
    } else {
      choice <- data[grep(input$specificAnime, data$canonicalTitle), ]
      p <- plot_ly(choice, labels = ~canonicalTitle, values = ~userCount, type = 'pie') %>%
        layout(title = "Ratio of Users for show types",
               xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
               yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
      return(p);
    }
  })
=======
  output$scatterplot <- renderPlotly({ 
    data.change <- filter(data, showType == input$type)
    return(Scatter.two(data.change))
  }) 
>>>>>>> 14762a5c1bd429cc96e4e8671054af406531fa4e
}

shinyServer(my.server)