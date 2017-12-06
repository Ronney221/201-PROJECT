library(jsonlite)
library(dplyr)
#API limits one pull to 20 
data1 <- fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=0")
data2 <- fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=20")
data3 <- fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=40")


data.twenty <- flatten((data1$data))

data <- select(data.twenty, canonicalTitle, synopsis, averageRating, userCount, favoritesCount, startDate, endDate, popularityRank, ratingRank, ageRating, episodeCount, youtubeVideoId, posterImage.original, coverImage.original)
