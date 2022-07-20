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

election_2020 <- read_csv("2020_US_County_Level_Presidential_Results.csv")

#https://www.census.gov/content/dam/Census/library/publications/2020/acs/acs_researchers_handbook_2020_ch05.pdf

unemployed_df <- getCensus(name = "acs/acs5", vintage = 2020,
                    key = "fb56ed9550c10c063c8180ecf44d9dffefa6ef36",
                    vars = c("B23025_003E", "B23025_005E", "NAME", "GEO_ID"),
                    region = "county:*")

unemployed_df <- unemployed_df %>%
  mutate(unemployment_rate = B23025_005E / B23025_003E)

unemployed_df$FIPS <- paste0(unemployed_df$state, unemployed_df$county)

unemployed_df <- unemployed_df %>%
  left_join(election_2020, by = c("FIPS" = "county_fips"))





