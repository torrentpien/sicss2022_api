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

options(warn = -1)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

politics <- fromJSON("https://www.dcard.tw/service/api/v2/forums/trending/posts")


for (i in 1:2) {
  
  #Sys.sleep(45)
  
  last_post <- politics$id[nrow(politics)]
  
  before_pol <- fromJSON(paste0("https://www.dcard.tw/service/api/v2/forums/trending/posts?limit=100", "&before=", last_post))
  
  politics <- bind_rows(politics, before_pol)
  
}


politics_comments <- data.frame()

for (x in 1:nrow(politics)) {
  
  Sys.sleep(45)
  
  if(politicscommentCount[x] > 0) {
    
    temp_comm <- fromJSON(paste0("https://www.dcard.tw/service/api/v2/posts/", politics$id[x], "/comments"))
    
    temp_comm <- data.frame(postId = temp_comm$postId, time = temp_comm$createdAt, 
                            content = temp_comm$content, like = temp_comm$likeCount)
    
  }
  
  politics_comments <- bind_rows(politics_comments, temp_comm)
  
}


