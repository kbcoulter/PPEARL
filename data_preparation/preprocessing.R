##### Data Preprocessing

##### TODO: Create cleaned dataframe from merged -> only the additional variables considered for model ( n < 16 )

# Imports ----------------------------------------------------------------------
library(dplyr)
library(tidyverse)
library(readxl)
library(corrplot)
library(Hmisc)

# Data Collection / Organization------------------------------------------------
##### Set File Path, threshold, columns needing NA -> 0, columns to omit
c_filepath = "copy of CarpeData.csv"
m_filepath = "Copy of MEEPData.xlsx"
l_filepath = "LilliamKAwardDatasetSpecifications.xlsx"

threshold = 0.9

fill_columns = c("virus_1", "virus_2",	"virus_3",	"bacteria_1")
columns_to_cut = c(
  'transed',
  'sx19_oth1',
  'sxdays19_1',
  'sx19_oth2',
  'sx19_oth3',
  'fuwhere1',
  'fuwhere_oth1',
  'fuabxchgoth1',
  'sx19_oth4',
  'indeathdat',
  'sx19_oth5',
  'immun_ageno',
  'edurinmeth',
  'edcxrint_oth',
  'immun_age',
  'immun_ageu',
  'abx_name_oth',
  'concern_about',
  'zipcode',
  'edurinvol',
  'edurindat',
  'edurintm',
  'edurinno',
  'edurinno_oth',
  'edsampfrig_dat2',
  'edsampfrig_tm2',
  'indx13dat',
  'indeathdat',
  'inurinvol',
  'inurindat',
  'inurintm',
  'inurinno_oth',
  'insampfrig_urin_dat',
  'insampfrig_urin_tm',
  'readdat1',
  'readtim1',
  'rexfericuwhy_oth1',
  'redx13dat2',
  'rexfericudat2',
  'rexfericuwhy_oth2',
  'readdat3',
  'readtim3',
  'readdiag13',
  'redx13dat3',
  'rexfericuwhy_oth3',
  'fusx_oth',
  'fuabxnottk_oth',
  'fuqol',
  'fuwhere_oth1',
  'fuabxchgoth1',
  'bnbionbr',
  'race___1',
  'race___2',
  'race___3',
  'race___4',
  'race___5',
  'race___6',
  'race___99',
  'race_oth',
  'ethnicity',
  'sch_mother',
  'dxpneu',
  'premie',
  'fluvac',
  'sx___1',
  'sx___2',
  'sx___3',
  'sx___4',
  'sx___5',
  'sx___6',
  'sx___7',
  'sx___8',
  'sx___9',
  'sx___10',
  'sx___11',
  'sx___12',
  'sx___13',
  'sx___14',
  'sx___15',
  'sx___16',
  'sx___17',
  'sx2q1',
  'abx',
  'abx_start',
  'cort_start',
  'smokers',
  'edcxrint___1',
  'edcxrint___2',
  'edcxrint___3',
  'edcxrint___4',
  'edcxrint___5',
  'edcxrint___6',
  'edcxrint___7',
  'edcxrint___8',
  'edcxrint___9',
  'edcxrint___10',
  'edcxrint___11',
  'edcxrint___12',
  'edcxrint___13',
  'edcxrint___14',
  'edcxrint___15',
  'edcxrint___16',
  'edcxrint___17',
  'edcxrint___18',
  'edcxrint___19',
  'edcxrint___98',
  'edcxrint___99',
  'indx13',
  'indeath',
  'bnrslt',
  'abxb4ed',
  'abxedrx',
  'virus_only',
  'bacteria_only',
  'virus_bacteria',
  'STGG_lytA_Ct',
  'STGG_lytA_Copies',
  'WBC1',
  'CRP1',
  'radreviews'
)
#length(columns_to_cut)

meep = read_excel(m_filepath)
carpe = read.csv(c_filepath)
lilliam = read_excel(l_filepath)
lil_desc = select(lilliam, `Variable Name`, `Variable Description`)

##### Differentiating Study ID's
# carpe -> "c"
stringsAsFactors = FALSE 
carpe$study_id <- as.character(carpe$study_id)
carpe$study_id <- sapply(carpe$study_id, function(x) paste0("c", x))

# meep -> "m" 
stringsAsFactors = FALSE
meep$study_id <- as.character(meep$study_id)
meep$study_id <- sapply(meep$study_id, function(x) paste0("m", x))
##### General Meep Transformations
# Drop When Meep Lmnx SampleID was not run. 
meep <- meep[!is.na(meep$Lmnx_SampleID), ]
# Add 0s for severity 2 in meep (As Control, All severity = 0)
meep$severity2 <- 0

##### Merging Data
all_columns <- union(names(carpe), names(meep))

# Missing columns to carpe w/ NA
missing_cols_carpe <- setdiff(all_columns, names(carpe))
for (col in missing_cols_carpe) {
  carpe[[col]] <- NA
}

# Missing columns to meep w/ NA
missing_cols_meep <- setdiff(all_columns, names(meep))
for (col in missing_cols_meep) {
  meep[[col]] <- NA
}

##### Drop rows where viral or bacterial tests were not run 
# For Merged, Carpe, NOT MEEP
carpe <- carpe %>%
  filter(!is.na(viraltestrun) & !is.na(bacterialtestrun))

##### Drop rows where BOTH viral and bacterial tests were not run 
#carpe <- carpe %>%
#  filter(!(is.na(viraltestrun) & is.na(bacterialtestrun)))

merged <- merge(carpe, meep, by = intersect(names(carpe), names(meep)), all = TRUE)

# Functions --------------------------------------------------------------------
##### Function: get_description -> see descriptions of columns in df
get_description <- function(df) {
  left_trans <- df %>%
    t() %>%
    as.data.frame() %>%
    rownames_to_column(var = "Variable Name") %>%
    select(`Variable Name`)
  
  result <- inner_join(left_trans, lil_desc, by = "Variable Name")
  return(result)
}

# Merged Work ------------------------------------------------------------------

##### Replace NA with 0 in the specified columns
merged[fill_columns] = lapply(merged[fill_columns], function(x) {
  x[is.na(x)] = 0
  return(x)
})

##### Drop specified columns from the Dataframe
merged <- merged[, !(names(merged) %in% columns_to_cut)]

##### Replace all values of 99 with NA in the data frame (99 = Unknown)
merged[] = lapply(merged, function(x) {
  x[x == 99] = NA
  return(x)
})

merged[] = lapply(merged, function(x) {
  x[x == '99'] = NA
  return(x)
})

##### Dropping Data Below Specified Missing Threshold ("Drop" Holds All Dropped Columns)
thresh = threshold * nrow(merged)
missing = sapply(merged, function(x) sum(is.na(x)))
drop = names(missing[missing > thresh])
merged_clean = merged[, !(names(merged) %in% drop)]
#ncol(merged_clean)

# Binary Transformation  -------------------------------------------------------
merged_clean$severity2 <- ifelse(merged_clean$severity2 > 2, 1, 0)
merged_clean$season <- ifelse(merged_clean$season == 1 | merged_clean$season == 4, 1, 0)
merged_clean$age_yr <- ifelse(merged_clean$age_yr > 1, 1, 0)

# write.csv(merged, "merged_data.csv", row.names = FALSE) #For no threshold drop
write.csv(merged_clean, "merged_data.csv", row.names = FALSE)

#Carpe Work ------------------------------------------------------------------
#Can Comment Out Later if N/A

##### Replace NA with 0 in the specified columns
carpe[fill_columns] = lapply(carpe[fill_columns], function(x) {
  x[is.na(x)] = 0
  return(x)
})

##### Drop specified columns from the Dataframe
carpe <- carpe[, !(names(carpe) %in% columns_to_cut)]

##### Replace all values of 99 with NA in the data frame (99 = Unknown)
carpe[] = lapply(carpe, function(x) {
  x[x == 99] = NA
  return(x)
})

carpe[] = lapply(carpe, function(x) {
  x[x == '99'] = NA
  return(x)
})

##### Dropping Data Below Specified Missing Threshold ("Drop" Holds All Dropped Columns)
thresh = threshold * nrow(carpe)
missing = sapply(carpe, function(x) sum(is.na(x)))
drop = names(missing[missing > thresh])
carpe_clean = carpe[, !(names(carpe) %in% drop)]
#ncol(carpe_clean)

write.csv(carpe_clean, "carpe_clean.csv", row.names = FALSE)

# Meep Work --------------------------------------------------------------------
#Can Comment Out Later if N/A

##### Replace NA with 0 in the specified columns
meep[fill_columns] = lapply(meep[fill_columns], function(x) {
  x[is.na(x)] = 0
  return(x)
})

##### Drop specified columns from the Dataframe
meep <- meep[, !(names(meep) %in% columns_to_cut)]

##### Replace all values of 99 with NA in the data frame (99 = Unknown)
meep[] = lapply(meep, function(x) {
  x[x == 99] = NA
  return(x)
})

meep[] = lapply(meep, function(x) {
  x[x == '99'] = NA
  return(x)
})

##### Dropping Data Below Specified Missing Threshold ("Drop" Holds All Dropped Columns)
thresh = threshold * nrow(meep)
missing = sapply(meep, function(x) sum(is.na(x)))
drop = names(missing[missing > thresh])
meep_clean = meep[, !(names(meep) %in% drop)]
#ncol(meep_clean)

write.csv(meep_clean, "meep_clean.csv", row.names = FALSE)

# COVARIATE DATA PREP ----------------------------------------------------------
##### Input chosen covariates
selected_columns = c('age_yr', 'severity2', 'season')

##### Process (Ignore)
selected_columns_sid = c(selected_columns,'study_id')

merged <- read_csv("merged_data.csv")
pd <- read_csv("pathogen_data_grouped.csv")

corr_df = cbind(merged[selected_columns],pd) 
corr_df <- mutate_all(corr_df, function(x) as.numeric(as.character(x)))
write.csv(corr_df, "corr_df.csv", row.names = FALSE) 

pd_w_covar = cbind(merged[selected_columns_sid],pd) 
write.csv(pd_w_covar, "pd_w_covar.csv", row.names = FALSE) 

