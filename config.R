##### TODO: Add the rest... XD
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
barcharts <- "visualizations/BarCharts.R"

source(preprocessing)
source(barcharts)
source(pathogen_data_formatting)
