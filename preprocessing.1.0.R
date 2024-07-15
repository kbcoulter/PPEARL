#Data Preprocessing

#Set File Path, Threshold, columns where 0 fill are needed (NA -> 0)
filepath = "~/Desktop/CoSIBS/NPLCM/Carpe Copy 7:11.csv"
threshold = 0.9
fill_columns = c("virus_1", "virus_2",	"virus_3",	"bacteria_1")

meep <- read_csv("C:\\Users\\robvo\\OneDrive\\Desktop\\CoSibs_Project\\Copy of MEEPData.csv") ##Kaden Change this##
carpe = read.csv(filepath)
rows = nrow(carpe)

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

#Differentiating Study ID's
#Unique Study ID's for carpe by adding "c" in every study ID value
stringsAsFactors = FALSE 
carpe_clean$study_id <- as.character(carpe_clean$study_id)
carpe_clean$study_id <- sapply(carpe_clean$study_id, function(x) paste0("c", x))
#head(carpe_clean)

#Unique Study ID's for meep by adding "m" in every study ID value
#### MEEP NOT CLEANED BELOW###
stringsAsFactors = FALSE
meep$study_id <- as.character(meep$study_id)
meep$study_id <- sapply(meep$study_id, function(x) paste0("m", x))
#head(meep)
