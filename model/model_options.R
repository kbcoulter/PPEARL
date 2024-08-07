# Bronze
bronze_causes <- c(
  "Rhinovirus",
  "Virus",
  "MycoPCR"
)

# Silver
silver_causes <- c("STAPH")

# Pass causes as list
cause_list <- c(bronze_causes, silver_causes)

J.BrS_1 <- 3
J.BrS_2 <- 1
J.SS <- 1

model_options_no_reg <- list(
  likelihood   = list(
    cause_list = cause_list,
    k_subclass = c(1), # No subclasses (1) -> No longer Nested
    #k_subclass = c(5,5), # <- Chosen
    Eti_formula = ~ -1,
    # no covariate for the etiology regression
    # no covariate for the subclass weight regression
    FPR_formula = list(MBS1 =   ~ -1) #MBS2 = ~ -1)
  ),
  use_measurements = c("BrS", "SS"),
  # Use bronze-standard data ONLY for model estimation.
  prior = list(
    Eti_prior = overall_uniform(1, cause_list),
    # Prior for the etiology -> Dirichlet(1,...,1) 
    TPR_prior  = list(
        BrS = list(
          info  = "informative",
      # Informative prior for TPRs
          input = "match_range",
      # Specify informative prior for TPRs (plausible range)
          val = list(
            MBS1 = list(up =  list(rep(0.99, J.BrS_1)), 
                        # upper ranges: matched to 97.5% quantile of a Beta prior
                        # lower ranges: matched to 2.5% quantile of a Beta prior
                    low = list(rep(0.55, J.BrS_1))))) 
            #MBS2 = list(up =  list(rep(0.99, J.BrS_2)),
                    # low = list(rep(0.55, J.BrS_2))))
        ,
      
        SS = list(
          info  = "informative",
          # Informative prior for TPRs
          input = "match_range",
          # Specify informative prior for TPRs (plausible range)
          val = list(
            MSS1 = list(up =  list(rep(0.99, J.SS)),
                    low = list(rep(0.55, J.SS))))
          
        )
    
    ))
  )
    
