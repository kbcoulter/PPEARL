##### library imports
library(here)
library(baker)
library(tidyverse)
library(readxl)
library(knitr)
library(corrplot)
library(Hmisc)
library(ggplot2)

##### filepaths
preprocessing <- "data_preparation/preprocessing.R"
pathogen_data_formatting <- "data_preparation/pathogen_data_formatting.R"
barcharts <- "visualizations/BarCharts.R"
covariates <- "visualizations/correlations_covariates.R"
model_options <- "model/model_options.R"
mcmc_options <- "model/mcmc_options.R"
run_model <- "model/run_model.R"
mcmc_analysis <- "model/mcmc_analysis.R"

##### run files
source(preprocessing)
source(barcharts)
source(pathogen_data_formatting)
#source(covariates)
source(model_options)
source(mcmc_options)
source(run_model)
source(mcmc_analysis)

