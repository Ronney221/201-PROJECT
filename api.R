library(jsonlite)
library(plyr) 
library(dplyr)
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

data <- select(combined, canonicalTitle, synopsis, averageRating, userCount, favoritesCount, startDate, endDate, popularityRank, ratingRank, ageRating, episodeCount, youtubeVideoId, posterImage.original, coverImage.original)


data.ratings <- select(data.twenty, canonicalTitle, averageRating, ratingFrequencies.2, ratingFrequencies.3,
                       ratingFrequencies.4, ratingFrequencies.4, ratingFrequencies.5, ratingFrequencies.6,
                       ratingFrequencies.7, ratingFrequencies.8, ratingFrequencies.9, ratingFrequencies.10,
                       ratingFrequencies.11, ratingFrequencies.12, ratingFrequencies.13, ratingFrequencies.14,
                       ratingFrequencies.15, ratingFrequencies.16, ratingFrequencies.17, ratingFrequencies.18,
                       ratingFrequencies.19, ratingFrequencies.20)
