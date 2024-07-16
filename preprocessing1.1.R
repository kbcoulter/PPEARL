#Data Preprocessing

# Imports
library(dplyr)
library(tidyverse)
library(readxl)

# Set Carpe File Path, Threshold, columns where 0 fill are needed (NA -> 0), and columns to omit
c_filepath = "copy of CarpeData.csv"
m_filepath = "Copy of MEEPData.xlsx"
l_filepath = "LilliamKAwardDatasetSpecifications.xlsx"

threshold = 0.9

fill_columns = c("virus_1", "virus_2",	"virus_3",	"bacteria_1")
columns_to_cut = c('transed', 'sx19_oth1', 'sxdays19_1', 'sx19_oth2', 'sx19_oth3', 'fuwhere1', 'fuwhere_oth1', 
                   'fuabxchgoth1', 'sx19_oth4', 'indeathdat', 'sx19_oth5', 'immun_ageno', 'edurinmeth', 'edcxrint_oth', 'immun_age', 
                   'immun_ageu', 'abx_name_oth', 'concern_about', 'zipcode', 'edurinvol', 'edurindat', 'edurintm', 'edurinno', 'edurinno_oth', 
                   'edsampfrig_dat2', 'edsampfrig_tm2', 'indx13dat', 'indeathdat', 'inurinvol', 'inurindat', 'inurintm', 'inurinno_oth', 
                   'insampfrig_urin_dat', 'insampfrig_urin_tm', 'readdat1', 'readtim1', 'rexfericuwhy_oth1', 'redx13dat2', 'rexfericudat2',
                   'rexfericuwhy_oth2', 'readdat3', 'readtim3', 'readdiag13', 'redx13dat3', 'rexfericuwhy_oth3', 'fusx_oth', 'fuabxnottk_oth', 
                   'fuqol', 'fuwhere_oth1', 'fuabxchgoth1', 'bnbionbr', 'race___1', 'race___', 'race___3', 'race___4', 'race___5', 'race___6', 
                   'race___99', 'race_oth', 'ethnicity', 'sch_mother')

meep = read_excel(m_filepath)
carpe = read.csv(c_filepath)
lilliam = read_excel(l_filepath)

# Drop specified columns from the Dataframe
carpe_inter <- carpe[, !(names(carpe) %in% columns_to_cut)]

# Replace NA with 0 in the specified columns
carpe[fill_columns] = lapply(carpe[fill_columns], function(x) {
  x[is.na(x)] = 0
  return(x)
})

# Replace all values of 99 with NA in the data frame (99 = Unknown)
carpe[] = lapply(carpe, function(x) {
  x[x == 99] = NA
  return(x)
})

# Dropping Data Below Specified Missing Threshold ("Drop" Holds All Dropped Columns)
thresh = threshold * nrow(carpe)
missing = sapply(carpe, function(x) sum(is.na(x)))
drop = names(missing[missing > thresh])
carpe_clean = carpe[, !(names(carpe) %in% drop)]
#ncol(carpe_clean)

# Differentiating Study ID's
# carpe -> "c"
stringsAsFactors = FALSE 
carpe_clean$study_id <- as.character(carpe_clean$study_id)
carpe_clean$study_id <- sapply(carpe_clean$study_id, function(x) paste0("c", x))

# meep -> "m" 
stringsAsFactors = FALSE
meep$study_id <- as.character(meep$study_id)
meep$study_id <- sapply(meep$study_id, function(x) paste0("m", x))

# Function: get_description -> see descriptions of columns in df
lil_desc = select(lilliam, `Variable Name`, `Variable Description`)
get_description <- function(df) {
  left_trans <- df %>%
    t() %>%
    as.data.frame() %>%
    rownames_to_column(var = "Variable Name") %>%
    select(`Variable Name`)
  
  result <- inner_join(left_trans, lil_desc, by = "Variable Name")
  return(result)
}

# See Descriptions for current carpe df
carpe_clean_desc = get_description(carpe_clean)

