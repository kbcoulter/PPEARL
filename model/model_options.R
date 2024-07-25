bronze_causes <- c(
  "FLUA",
  "FLUB",
  "RSV",
  "Coronavirus",
  "HMPV",
  "HRV_Entero",
  "Adenovirus",
  "PARAFLU1",
  "PARAFLU2",
  "PARAFLU3",
  "PARAFLU4",
  "Bocavirus",
  "MycoPCR"
)

silver_causes <- c("S_PNEU",
                   "CHLAM",
                   "LEGI",
                   "HAEM",
                   "STAPH",
                   "S_PYOG",
                   "KLEB",
                   "PERT")
cause_list <- c(bronze_causes, silver_causes)

J.BrS_1 <- 13
J.BrS_2 <- 1

J.SS <- 8

model_options_no_reg <- list(
  likelihood   = list(
    cause_list = cause_list,
    k_subclass = c(5),
    #k_subclass = c(5,5), # Chosen
    Eti_formula = ~ -1,
    # no covariate for the etiology regression
    FPR_formula = list(MBS1 =   ~ -1) #MBS2 = ~ -1)    # no covariate for the subclass weight regression
  ),
  use_measurements = c("BrS", "SS"),
  # use bronze-standard data only for model estimation.
  prior = list(
    Eti_prior = overall_uniform(1, cause_list),
    # Dirichlet(1,...,1) prior for the etiology.
    TPR_prior  = list(
        BrS = list(
          info  = "informative",
      # informative prior for TPRs
          input = "match_range",
      # specify the informative prior for TPRs by specifying a plausible range.
          val = list(
            MBS1 = list(up =  list(rep(0.99, J.BrS_1)), # upper ranges: matched to 97.5% quantile of a Beta prior
                    low = list(rep(0.55, J.BrS_1))))) #MBS2 = list(up =  list(rep(0.99, J.BrS_2)), # upper ranges: matched to 97.5% quantile of a Beta prior
        #low = list(rep(0.55, J.BrS_2))))
        # lower ranges: matched to 2.5% quantile of a Beta prior
        ,
      
        SS = list(
          info  = "informative",
          # informative prior for TPRs
          input = "match_range",
          # specify the informative prior for TPRs by specifying a plausible range.
          val = list(
            MSS1 = list(up =  list(rep(0.99, J.SS)), # upper ranges: matched to 97.5% quantile of a Beta prior
                    low = list(rep(0.55, J.SS))))
          
        )
    
    ))
  )
    
