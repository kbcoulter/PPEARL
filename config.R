library(here)
library(baker)
library(tidyverse)
library(readxl)
library(knitr)
library(corrplot)
library(Hmisc)
library(ggplot2)


preprocessing <- "data_preparation/preprocessing.R"
pathogen_data_formatting <- "data_preparation/pathogen_data_formatting.R"
piecharts <- "visualizations/piecharts.R"

source(preprocessing)
source(piecharts)
source(pathogen_data_formatting)
