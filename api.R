library(jsonlite)
library(WDI)
library(censusapi)
library(plyr)
library(dplyr)
library(tidyr)
library(stringr)
library(readr)
library(readxl)
library(writexl)
library(ggplot2)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


#dcard

forum <- fromJSON("https://www.dcard.tw/service/api/v2/forums")

nccu <- fromJSON("https://www.dcard.tw/service/api/v2/forums/nccu/posts")


for (i in 1:2) {
  
  Sys.sleep(45)
  
  last_post <- nccu$id[nrow(nccu)]
  
  before_nccu <- jsonlite::fromJSON(paste0("https://www.dcard.tw/service/api/v2/forums/nccu/posts?limit=100", "&before=", last_post))
  
  nccu <- bind_rows(nccu, before_nccu)
  
}


comments <- fromJSON("https://www.dcard.tw/service/api/v2/posts/239421303/comments")

comments <- data.frame(postId = comments$postId, time = comments$createdAt, 
                       content = comments$content, like = comments$likeCount)


comments <- data.frame()

for (x in 1:nrow(nccu)) {
  
  Sys.sleep(45)
  
  if(nccu$commentCount[x] > 0) {
    
    temp_comm <- fromJSON(paste0("https://www.dcard.tw/service/api/v2/posts/", nccu$id[x], "/comments"))
    
    temp_comm <- data.frame(postId = temp_comm$postId, time = temp_comm$createdAt, 
                           content = temp_comm$content, like = temp_comm$likeCount)
    
  }
  
  comments <- bind_rows(comments, temp_comm)
  
}



#World Bank

#search key words

ws_gini <- WDIsearch("gini")

gini <- WDI(indicator='SI.POV.GINI', start=1960, end=2012)

#Specific countries’ data

gini_country <- WDI(indicator = 'SI.POV.GINI', country = c('TR', 'TH'), start=1960, end=2012)

#or

gini_country <- gini %>%
  filter(iso2c %in% c('TR', 'TH'))

ggplot(gini_country, aes(x = year, y = SI.POV.GINI, group = country)) +
  geom_line(aes(color = country))


#Merge US, UK, Japan, Germany's population, GDP, and GINI data from 2010-2020 in one table.

four_country <-  WDI(indicator = c("SP.POP.TOTL", "SI.POV.GINI", "NY.GDP.MKTP.CD"), country = c('US', 'GB', 'JP', 'DE'), start = 2010, end = 2020)

colnames(four_country)[4:6] <- c("popu", "gini", "gdp")


#US Census Bureau

apis <- listCensusApis()

#Get a database’s variable list

vars_list <- listCensusMetadata(
  name = "acs/acs5", 
  vintage = 2020,
  type = "variables")


asc_df <- getCensus(name = "acs/acs5", vintage = 2020,
                    key = "fb56ed9550c10c063c8180ecf44d9dffefa6ef36",
                    vars = c("B01001_001E", "NAME", "B01002_001E", "B19013_001E", "GEO_ID"),
                    region = "county:*", regionin = "state:06")


#Read vaccination rate county level csv file
vac <- read.csv("COVID-19_Vaccinations_in_the_United_States_County.csv")

#Select the data from 01/20/2021 and 01/19/2022
vac <- vac %>%
  filter(Date %in% c("01/20/2021", "01/19/2022")) %>%
  select(1:6)

#Transform long table to wide table
vac_sp <- vac[,-3] %>%
  spread(Date, Completeness_pct)

#Calculate the change from 01/20/2021 to 01/19/2022
vac_sp <- vac_sp %>%
  mutate(one_year = `01/19/2022` - `01/20/2021`)

asc_df <- getCensus(name = "acs/acs5", vintage = 2020,
                    key = "fb56ed9550c10c063c8180ecf44d9dffefa6ef36",
                    vars = c("B01001_001E", "NAME", "B01002_001E", "B19013_001E", "GEO_ID"),
                    region = "county:*")

asc_df$FIPS <- paste0(asc_df$state, asc_df$county)

asc_df <- asc_df %>%
  left_join(vac_sp, by = "FIPS")


