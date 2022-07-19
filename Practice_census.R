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

election_2020 <- read_csv("--------------")

unemployed_df <- getCensus(name = "acs/acs5", vintage = 2020,
                    key = "fb56ed9550c10c063c8180ecf44d9dffefa6ef36",
                    vars = c("-------", "------", "NAME", "GEO_ID"),
                    region = "county:*")

unemployed_df <- unemployed_df %>%
  mutate(unemployment_rate = --------------)

unemployed_df$----- <- paste0(unemployed_df$----, unemployed_df$----)

unemployed_df <- unemployed_df %>%
  left_join(election_2020, by = ---------)






