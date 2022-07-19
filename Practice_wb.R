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

inflation <- WDI(indicator='-------', start=1960, end=2020)

inflation <- inflation %>%
  filter(iso2c %in% -------)

ggplot(inflation, aes(x = year, y = ------, group = -----)) +
  geom_line(--------)


