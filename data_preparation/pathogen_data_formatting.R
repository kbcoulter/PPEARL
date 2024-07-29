##### Input chosen covariates
selected_columns = c('age_yr', 'severity2', 'season')

carpe_data <- carpe_clean
meep <- meep_clean
# merged <- read_csv("merged_data.csv")
merged <- merged_clean

carp_pathogens <- carpe_data |>
  select(virus_1, virus_2, virus_3, viraltestrun, bacteria_1, bacterialtestrun) |>
  mutate(v1 = case_when(virus_1 == 1 |
                          virus_2 == 1 | virus_3 == 1 ~ 1, .default = 0)) |> 
  mutate(v2 = case_when(virus_1 == 2 |
                          virus_2 == 2 | virus_3 == 2 ~ 1, .default = 0)) |> 
  mutate(v3 = case_when(virus_1 == 3 |
                          virus_2 == 3 | virus_3 == 3 ~ 1, .default = 0)) |> 
  mutate(v4 = case_when(virus_1 == 4 |
                          virus_2 == 4 | virus_3 == 4 ~ 1, .default = 0)) |>
  mutate(v5 = case_when(virus_1 == 5 |
                          virus_2 == 5 | virus_3 == 5 ~ 1, .default = 0)) |> 
  mutate(v6 = case_when(virus_1 == 6 |
                          virus_2 == 6 | virus_3 == 6 ~ 1, .default = 0)) |> 
  mutate(v7 = case_when(virus_1 == 7 |
                          virus_2 == 7 | virus_3 == 7 ~ 1, .default = 0)) |>
  mutate(v8 = case_when(virus_1 == 8 |
                          virus_2 == 8 | virus_3 == 8 ~ 1, .default = 0)) |> 
  mutate(v9 = case_when(virus_1 == 9 |
                          virus_2 == 9 | virus_3 == 9 ~ 1, .default = 0)) |> 
  mutate(v10 = case_when(virus_1 == 10 |
                          virus_2 == 10 | virus_3 == 10 ~ 1, .default = 0)) |> 
  mutate(v11 = case_when(virus_1 == 11 |
                          virus_2 == 11 | virus_3 == 11 ~ 1, .default = 0)) |> 
  mutate(v12 = case_when(virus_1 == 12 |
                           virus_2 == 12 | virus_3 == 12 ~ 1, .default = 0)) |>
  mutate(v1 = case_when(is.na(viraltestrun) ~ NA, .default = v1) ) |> 
  mutate(v2 = case_when(is.na(viraltestrun) ~ NA, .default = v2) ) |> 
  mutate(v3 = case_when(is.na(viraltestrun) ~ NA, .default = v3) ) |> 
  mutate(v4 = case_when(is.na(viraltestrun) ~ NA, .default = v4) ) |> 
  mutate(v5 = case_when(is.na(viraltestrun) ~ NA, .default = v5) ) |> 
  mutate(v6 = case_when(is.na(viraltestrun) ~ NA, .default = v6) ) |> 
  mutate(v7 = case_when(is.na(viraltestrun) ~ NA, .default = v7) ) |> 
  mutate(v8 = case_when(is.na(viraltestrun) ~ NA, .default = v8) ) |> 
  mutate(v9 = case_when(is.na(viraltestrun) ~ NA, .default = v9) ) |> 
  mutate(v10 = case_when(is.na(viraltestrun) ~ NA, .default = v10) ) |> 
  mutate(v11 = case_when(is.na(viraltestrun) ~ NA, .default = v11) ) |> 
  mutate(v12 = case_when(is.na(viraltestrun) ~ NA, .default = v12) ) |> 
  mutate(b1 = case_when(bacteria_1 == 1 ~ 1, .default = 0)) |> 
  mutate(b2 = case_when(bacteria_1 == 2 ~ 1, .default = 0)) |> 
  mutate(b3 = case_when(bacteria_1 == 3 ~ 1, .default = 0)) |> 
  mutate(b4 = case_when(bacteria_1 == 4 ~ 1, .default = 0)) |> 
  mutate(b5 = case_when(bacteria_1 == 5 ~ 1, .default = 0)) |> 
  mutate(b6 = case_when(bacteria_1 == 6 ~ 1, .default = 0)) |> 
  mutate(b7 = case_when(bacteria_1 == 7 ~ 1, .default = 0)) |> 
  mutate(b8 = case_when(bacteria_1 == 8 ~ 1, .default = 0)) |> 
  mutate(b9 = case_when(bacteria_1 == 9 ~ 1, .default = 0)) |> 
  mutate(b1 = case_when(is.na(bacterialtestrun) ~ NA, .default = b1) ) |> 
  mutate(b2 = case_when(is.na(bacterialtestrun) ~ NA, .default = b2) ) |> 
  mutate(b3 = case_when(is.na(bacterialtestrun) ~ NA, .default = b3) ) |> 
  mutate(b4 = case_when(is.na(bacterialtestrun) ~ NA, .default = b4) ) |> 
  mutate(b5 = case_when(is.na(bacterialtestrun) ~ NA, .default = b5) ) |> 
  mutate(b6 = case_when(is.na(bacterialtestrun) ~ NA, .default = b6) ) |> 
  mutate(b7 = case_when(is.na(bacterialtestrun) ~ NA, .default = b7) ) |> 
  mutate(b8 = case_when(is.na(bacterialtestrun) ~ NA, .default = b8) ) |> 
  mutate(b9 = case_when(is.na(bacterialtestrun) ~ NA, .default = b9) ) |> 
  select(v1:b9) |> 
  rename(
    FLUA = v1,
    FLUB = v2,
    RSV = v6,
    Coronavirus = v10,
    HMPV = v7,
    HRV_Entero = v8,
    Adenovirus = v9,
    PARAFLU1 = v3,
    PARAFLU2 = v4,
    PARAFLU3 = v5,
    PARAFLU4 = v12,
    Bocavirus = v11,
    S_PNEU = b1,
    MycoPCR = b2,
    CHLAM = b3,
    LEGI = b4,
    HAEM = b5,
    STAPH = b6,
    S_PYOG = b7,
    KLEB = b8,
    PERT = b9
  ) 
  
meep_pathogens <- meep |>
  select(FLUA:MycoPCR) |>
  mutate(
    S_PNEU = NA,
    CHLAM = NA,
    LEGI = NA,
    HAEM = NA,
    STAPH = NA,
    S_PYOG = NA,
    KLEB = NA,
    PERT = NA
  ) 
 


 
pathogen_data <- bind_rows(carp_pathogens, meep_pathogens)

pathogen_data_trimmed <- pathogen_data |> 
  select(!PARAFLU2) |> 
  select(!c(S_PNEU, CHLAM, LEGI, HAEM, S_PYOG, KLEB, PERT))

pathogen_data_grouped <- pathogen_data_trimmed |>
  mutate(
    Virus = case_when(
      FLUA + FLUB + PARAFLU1 + PARAFLU3 + PARAFLU4 + RSV + HMPV + Adenovirus + Coronavirus + Bocavirus > 0 ~ 1,
      .default = 0
    )
  ) |> 
  rename(Rhinovirus = HRV_Entero) |> 
  select(!c(FLUA:HMPV, Adenovirus:PARAFLU4))


write.csv(pathogen_data_grouped, "pathogen_data_grouped.csv", row.names = FALSE) 

# COVARIATE DATA PREP ----------------------------------------------------------

##### Process (Ignore)
selected_columns_sid = c(selected_columns,'study_id')

corr_df = cbind(merged[selected_columns],pathogen_data_grouped) 
corr_df <- mutate_all(corr_df, function(x) as.numeric(as.character(x)))
write.csv(corr_df, "corr_df.csv", row.names = FALSE) 

pd_w_covar = cbind(merged[selected_columns_sid],pathogen_data_grouped) 
write.csv(pd_w_covar, "pd_w_covar.csv", row.names = FALSE) 
# -----------------------------------------------------------------------------                      

Y <- c(rep(1,dim(carp_pathogens)[1]), rep(0,dim(meep_pathogens)[1]))

#########

bronze <- pathogen_data_grouped |> 
  select(Rhinovirus, MycoPCR, Virus)

silver <- pathogen_data_grouped |> 
  select(STAPH)

MBS <- list(MBS1 = bronze) #MBS2 = MBS_B)

MSS <- list(MSS1 = silver)

Mobs <- list(MBS=MBS,MSS=MSS,MGS=NULL)

data_nplcm <- list(Mobs = Mobs, Y = Y, X = NULL)





