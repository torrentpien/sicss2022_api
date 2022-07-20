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

inflation <- WDI(indicator='FP.CPI.TOTL.ZG', start=1960, end=2020)

#https://www23.statcan.gc.ca/imdb/p3VD.pl?Function=getVD&TVD=141329

eu <- read_xlsx("eu.xlsx")

inflation <- inflation %>%
  filter(iso2c %in% eu$`Alpha-2`)

ggplot(inflation, aes(x = year, y = FP.CPI.TOTL.ZG, group = country)) +
  geom_line(aes(color = country))


