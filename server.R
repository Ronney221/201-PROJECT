source("api.R")

#main data frame that has the useful data selected from our api pull
data <- select(combined, canonicalTitle, showType, synopsis, averageRating, userCount, favoritesCount, startDate,
               endDate, popularityRank, ratingRank, ageRating, ageRatingGuide, subtype, status, episodeCount, 
               youtubeVideoId, 
               posterImage.original, coverImage.original)

#separate data frame used for rating comparison in the bar graph
data.ratings <- select(combined, canonicalTitle, averageRating, ratingFrequencies.2, ratingFrequencies.3,
                       ratingFrequencies.4, ratingFrequencies.4, ratingFrequencies.5, ratingFrequencies.6,
                       ratingFrequencies.7, ratingFrequencies.8, ratingFrequencies.9, ratingFrequencies.10,
                       ratingFrequencies.11, ratingFrequencies.12, ratingFrequencies.13, ratingFrequencies.14,
                       ratingFrequencies.15, ratingFrequencies.16, ratingFrequencies.17, ratingFrequencies.18,
                       ratingFrequencies.19, ratingFrequencies.20)

#separate data frame used for synopsis and image display in the search tab
data.rating <- select(combined, canonicalTitle, averageRating, popularityRank, ratingRank, subtype, startDate, endDate, episodeCount, status)

##creates a scatterplot for the passed in data for view count and favorites count
Scatter <- function(d){
  p <- ggplot(d, aes( x = userCount, 
                      y = (favoritesCount/userCount), 
                      color = ageRating, 
                      text = paste("Title:", canonicalTitle))) + 
    geom_point() + 
    labs(x = "View Count", 
         y = "Percent Favorited")
  
  return(ggplotly(p))
}

#creates a bar graph using two passed in data frames that compare values to each other
#specifically the rating frequencies used between 10% to 100% ratings
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

#server function used to connect to ui.R
my.server <- function(input, output) {
  # Reactive function that returns the choice for select
  selection <- reactive({input$select})
  
  # Outputs synopsis of chosen anime
  output$info <- renderText({
    return(c(filter(data, canonicalTitle == selection())$synopsis, "\n"))
  })
  
  # Outputs poster image of chosen anime
  output$poster<-renderText({c('<img src="',filter(data, canonicalTitle == selection())$posterImage.original,'"style="width: 35% ; height: 35%">')})
  
  # Outputs cover image of chosen anime
  output$cover<-renderText({c('<img src="',filter(data, canonicalTitle == selection())$coverImage.original,'"style="width: 35% ; height: 35%">')})
  
  output$mytable = DT::renderDataTable({
    data.rating
  })
  
  # Outputs a pie chart comparing the totals of whatever choice is selected 
  output$pie1 <- renderPlotly({
    if (input$overview == 'User Views') {
      types.of.show <- select(data, showType, userCount) %>% 
        group_by(showType) %>%
        summarize(userCount = sum(userCount, na.rm=TRUE))
      p <- plot_ly(types.of.show, labels = ~showType, values = ~userCount, type = 'pie') %>%
        layout(title = 'Overview of User Views for each Show Type',
               xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
               yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
      return(p)
    } else {
      types.of.show <- select(data, showType, favoritesCount) %>% 
        group_by(showType) %>% 
        summarize(favoritesCount = sum(favoritesCount, na.rm=TRUE))
      p <- plot_ly(types.of.show, labels = ~showType, values = ~favoritesCount, type = 'pie') %>%
        layout(title = 'Overview of Favorites Count for each Show Type',
               xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
               yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
      return(p)
    }
  })
  
  # Outputs a pie chart that shows a usercount comparison for the selected animes
  output$pie2 <- renderPlotly({
    choice <- data[grep(input$specificAnime, data$canonicalTitle), ]
    p <- plot_ly(choice, labels = ~canonicalTitle, values = ~userCount, type = 'pie') %>%
      layout(title = input$specificAnime,
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    return(p);
  })
  
  ##Output for the scatterplot, with renderplotly, updated live feedback
  output$scatterplot <- renderPlotly({ 
    ##Filters the datafram by type of anime
    data.change <- filter(data, showType == input$type)
    return(Scatter(data.change))
  }) 
  
  #Outputs for the average user rating bar graph
  #takes in two anime titles as input
  output$bargraph <- renderPlotly({ 
    new.data <- filter(data.ratings, canonicalTitle == input$anime)
    new.data2 <- filter(data.ratings, canonicalTitle == input$anime2)
    return(bar(new.data, new.data2))
  }) 
}

shinyServer(my.server)