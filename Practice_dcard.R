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

politics <- fromJSON("https://www.dcard.tw/service/api/v2/----------")


for (i in 1:---) {
  
  Sys.sleep(---)
  
  last_post <- politics$id[-------]
  
  before_pol <- fromJSON(paste0("https://www.dcard.tw/service/api/v2/--------?limit=----", "&before=", -----))
  
  politics <- bind_rows(-----, -----)
  
}


politics_comments <- data.frame()

for (x in 1:----) {
  
  Sys.sleep(--)
  
  if(politicscommentCount[x] > 0) {
    
    temp_comm <- fromJSON(paste0("https://www.dcard.tw/service/api/v2/-----", -----, "-----"))
    
    temp_comm <- data.frame(postId = temp_comm$-----, time = temp_comm$-----, 
                            content = temp_comm$-----, like = temp_comm$-----)
    
  }
  
  politics_comments <- bind_rows(-----_comments, -----)
  
}


