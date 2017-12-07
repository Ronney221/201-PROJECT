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

data.ratings <- select(combined, canonicalTitle, averageRating, ratingFrequencies.2, ratingFrequencies.3,
                       ratingFrequencies.4, ratingFrequencies.4, ratingFrequencies.5, ratingFrequencies.6,
                       ratingFrequencies.7, ratingFrequencies.8, ratingFrequencies.9, ratingFrequencies.10,
                       ratingFrequencies.11, ratingFrequencies.12, ratingFrequencies.13, ratingFrequencies.14,
                       ratingFrequencies.15, ratingFrequencies.16, ratingFrequencies.17, ratingFrequencies.18,
                       ratingFrequencies.19, ratingFrequencies.20)


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

bar <- function(data1, data2) {
  title1 <- data1$canonicalTitle
  title2 <- data2$canonicalTitle
  dat1 <- data.frame(
    anime = factor(c(title1,title1,title1,title1,title1,title1,title1,title1,title1,title1,title2,title2,title2,title2,title2,title2,title2,title2,title2,title2)),
    rating = factor(c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)),
    voteFrequency = as.numeric(c(data1$ratingFrequencies.2, data1$ratingFrequencies.4, data1$ratingFrequencies.6, data1$ratingFrequencies.8, data1$ratingFrequencies.10, data1$ratingFrequencies.12, data1$ratingFrequencies.14, data1$ratingFrequencies.16, data1$ratingFrequencies.18, data1$ratingFrequencies.20,
                                 data2$ratingFrequencies.2, data2$ratingFrequencies.4, data2$ratingFrequencies.6, data2$ratingFrequencies.8, data2$ratingFrequencies.10, data2$ratingFrequencies.12, data2$ratingFrequencies.14, data2$ratingFrequencies.16, data2$ratingFrequencies.18, data2$ratingFrequencies.20))
  )
  
  p <- ggplot(data=dat1, aes(x=rating, y=voteFrequency, fill=anime)) +
    geom_bar(colour="black", stat="identity",
             position=position_dodge(),
             size=.3) +                        # Thinner lines
    xlab("Rating that users voted for (%)") + ylab("Amount of votes") + # Set axis labels
    ggtitle(paste0(title1, " vs. ", title2, 
                   " Average user rating of (", data1$averageRating, "%) vs (", data2$averageRating, "%)")) +   # Set title
    theme_bw() 
  p <- ggplotly(p)
}


my.server <- function(input, output) {
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
  
  output$scatterplot <- renderPlotly({ 
    data.change <- filter(data, showType == input$type)
    return(Scatter.two(data.change))
  }) 
  
  output$bargraph <- renderPlotly({ 
    new.data <- filter(data.ratings, canonicalTitle == input$anime)
    new.data2 <- filter(data.ratings, canonicalTitle == input$anime2)
    return(bar(new.data, new.data2))
  }) 
}

shinyServer(my.server)