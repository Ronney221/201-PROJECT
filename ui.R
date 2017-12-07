library('shiny')
library('plotly')


my.ui <- fluidPage(
  
  tabsetPanel(
    tabPanel(
      titlePanel("Home")
    ),
    
    tabPanel(
      titlePanel("Searchbar"),
      h1("Search"),
      sidebarPanel(
        textInput('select', 'Search for an anime')
      ),
      mainPanel(
        textOutput("info"),
        htmlOutput("poster"),
        htmlOutput("cover")
      )
      #TRY TO PUT PICTURES / YOUTUBE TRAILER HERE AFTER SELECTING AN ANIME
    ),
    
    tabPanel(
      titlePanel("Average Ratings"),
      h1("Analysis of the Average Rating Statistic"),
      sidebarLayout(
        sidebarPanel(
          selectInput("anime", "Choose the first anime", 
                      choices = c("Cowboy Bebop", "Naruto", "Spirited Away", "Monster", "One Piece", "Trigun", "Berserk", "Fullmetal Alchemist", "Slam Dunk", "Dragon Ball", "Prince of Tennis", "Trinity Blood"),
                      selected = "Naruto"),
          selectInput("anime2", "Choose a second anime to compare to", 
                      choices = c("Cowboy Bebop", "Naruto", "Spirited Away", "Monster", "One Piece", "Trigun", "Berserk", "Fullmetal Alchemist", "Slam Dunk", "Dragon Ball", "Prince of Tennis", "Trinity Blood"),
                      selected = "Cowboy Bebop"),
          h3("BACKGROUND:"),
          p("In this interactive bar graph, there are dropdown menus that allow for the selection of TWO different anime series to compare between. On the title of the graph, the overall average user rating of the anime is listed for perspective comparison."),
          
          h3("EXPLANATION OF THE GRAPH:"),
          p("This graph is split up into 10 different sections, which represent what users rated the anime as (from 10% to 100%). When you hover over a specific bar, you will be able to see how many users voted for this specific rating. This gives us greater insight on where the Overall Rating Percentage comes from because we can see specifically what ratings contributed to the overall score.") 
        ),
        
        mainPanel(
          plotlyOutput("bargraph")
        )
      )
    ),
    
    tabPanel(
      titlePanel("View Count Comparison"),
      h1("User and Favorite Count Analysis"),
      sidebarLayout(
        sidebarPanel(
          radioButtons("overview", "Choose type of count",
                       choices = c("User Views", "Favorites")),
          selectInput("specificAnime", "Choose a Specific Anime",
                      choices = c("Mobile Suit Gundam", "Neon Genesis Evangelion", 
                                  "Rurouni Kenshin: Meiji Kenkaku Romantan",
                                   "Cowboy Bebop", "El Hazard", "Hunter x Hunter",
                                  "Initial D", "Love Hina"), 
                      selected = "Mobile Suit Gundam"),
          h3("Options Explanation:"),
          p("You have the option of selecting between viewing User counts/views or Favorite counts/votes for the first pie chart. The second pie chart has a dropdown menu of the many anime's with multiple show types."),
          h3("Data Explanation"),
          p("The first chart shows the overall similarity between the total User Views and Favorite Votes when compared in terms of show types. The second pie chart shows the relative number of Views for each anime comparatively to it's follow up shows.")
        ),
        
        mainPanel(
          plotlyOutput("pie1"),
          plotlyOutput("pie2")
        )
      )
    ),
    
    tabPanel(
      titlePanel("Favorited Graph"),
      sidebarLayout(
        sidebarPanel(
          radioButtons("type","Show Type:",
                       choices = c("TV", "movie", "OVA", "special"))
        ),
        
        mainPanel(
          plotlyOutput("scatterplot")
        )
      )
    ),
    
    tabPanel(
      titlePanel("2")
    ),
    
    tabPanel(
      titlePanel("3")
    ),
    
    tabPanel(
      titlePanel("4")
    )
  )
) 

shinyUI(my.ui)