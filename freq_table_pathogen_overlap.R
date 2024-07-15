################################################################################
# Frequency table of pathogen overlap
################################################################################

# Load data
meep <- read_xlsx("Copy of MEEPData.xlsx")
carpe_data <- read_csv("copy of CarpeData.csv")

# Select pathogen columns
carpe_virus_dat <- carpe_data |> 
  select(virus_1, virus_2, virus_3, bacteria_1, virus_only, bacteria_only)

# Convert to binary
vb_nums <- carpe_virus_dat |> 
  mutate(virus_1_bin = case_when(is.na(virus_1) == T ~ 0, .default = 1), .after = virus_1) |> 
  mutate(virus_2_bin = case_when(is.na(virus_2) == T ~ 0, .default = 1), .after = virus_2) |> 
  mutate(virus_3_bin = case_when(is.na(virus_3) == T ~ 0, .default = 1), .after = virus_3) |> 
  mutate(bacteria_1_bin = case_when(is.na(bacteria_1) == T ~ 0, .default = 1), .after = bacteria_1) |> 
  mutate(virus_n = virus_1_bin + virus_2_bin +virus_3_bin) |> 
  mutate(virus_status = case_when(virus_n == 0 ~ "No virus", virus_n == 1 ~ "1 virus", virus_n == 2 ~ "2 viruses", virus_n == 3 ~ "3 viruses")) |> 
  mutate(bacteria_status = case_when(bacteria_1_bin == 0 ~ "No bacteria", bacteria_1_bin == 1 ~ "1 bacteria"))

# Store as two-way table
data <- table(vb_nums$virus_status, vb_nums$bacteria_status)

# View table
data

