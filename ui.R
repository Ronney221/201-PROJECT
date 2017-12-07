library('shiny')
library('plotly')
library('DT')


url <- a("Kitsu Anime", href ="https://kitsu.io/explore/anime")

my.ui <- fluidPage(
  
  tabsetPanel(
    tabPanel(
      titlePanel("Home"),
      h1("Anime Analysis- Using KITSU API"),
      h3("By: Ronney Do, Zach Hsiao, Justin Wang, Jeremy Ku"),
      mainPanel(
        
        h2("Purpose: "),
        h3("The goal of our project is to examine and compare different aspects of anime. We want to answer questions and find trends on why certain Animes are so popular or highly ranked. Are popular main stream anime actually more well liked than other animes? What form of anime is most popular? Using the Kitsu API, we hope to answer general questions about anime and help the user understand the data presented."),
        h2(url),
        h3("Kitsu Anime is a website to discover anime. They have a huge database of anime and includes in depth descriptions on each one. Aside from its database of anime, Kitsu also allows users to interact with the website. Some features that it includes are keeping track of finished shows, add to your show list, and allow users to rate and comment on animes. Kitsu offers its own API, allowing us to access data for each anime and see how the community receives each anime."),
        
        h2("Anime Database"),
        DT::dataTableOutput("mytable"))
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
      titlePanel("General Statistics"),
      h1("Satisfaction Levels of Each Anime"),
      sidebarLayout(
        sidebarPanel(
          ##Creates the chioces to filter the animes
          radioButtons("type","Show Type:",
                       choices = c("TV", "movie", "OVA", "special")),
          h3("SCATTERPLOT:"),
          p("This scatterplot will compare the favorite count and viewer counts of the 1000 selected animes. The radio buttons on the sidepanel allow for the scatterplot to be filtered by type of entertainment, because viewer and favorite counts for different types of productions have different numbers."),
          h3("EXPLANATION OF THE GRAPH:"),
          p("This graph represents the actual satisfaction rate for the people who have watched the anime. On the X-axis, we sort the animes by ascending view count, while on the y-axis we sort by the favorite count divided by the viewer count. This allows us to see the percentage of people who watched the anime and genuinely enjoyed it.")
        ),
        
        mainPanel(
          plotlyOutput("scatterplot")
        )
      )
    ),
    
    tabPanel(
      titlePanel("1"),
      sidebarLayout(
        sidebarPanel(
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
          plotlyOutput("pie")
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