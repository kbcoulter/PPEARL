#Data Preprocessing

#Set File Path, Threshold, columns where 0 fill are needed (NA -> 0)
filepath = "~/Desktop/CoSIBS/NPLCM/Carpe Copy 7:11.csv"
threshold = 0.9
fill_columns = c("virus_1", "virus_2",	"virus_3",	"bacteria_1")

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

