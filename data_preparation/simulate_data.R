library(baker)

##### From Baker Package Vignettes -> KC ~ Added Some Outline Code to Simulate With Covariates: #####

# Note: the example will only run 100 Gibbs sampling steps to save computing time.
# modify "mcmc_options" as follows: "n.itermcmc" -> 50000, "n.burnin" -> 10000, "n.thin" -> 40,


working_dir <- tempdir() # <-- create a temporary directory.
#curd = getwd()
#randname = paste(curd, basename(tempfile()), sep="/") #absolute path
#dir.create(randname)
#working_dir = randname

K.true  <- 2   # no. of latent subclasses in actual simulation. 
# If eta = c(1,0), K.true is effectively 1.
J       <- 6   # no. of pathogens.
N       <- 250 # no. of cases/controls

# case subclass weight (five values):
subclass_mix_seq <- c(0,0.25,0.5,0.75,1)


NREP   <- 100
MYGRID <- expand.grid(list(rep   = 1:NREP, # data replication
                           iter  = seq_along(subclass_mix_seq),# mixing weights.
                           k_fit = c(1),
                           #k_fit = c(1,2), # model being fitted: 1 for pLCM; >1 for npLCM.
                           scn   = (3:1)    # index for different truth; see "scn_collection.R".
)

n_seed   <- nrow(unique(MYGRID[,-3]))
seed_seq <- rep(1:n_seed,times=length(unique(MYGRID[,3])))

SEG   <- 1 # The value could be 1 to nrow(MYGRID)=3000 (1 Dataset)
scn   <- MYGRID$scn[SEG]
k_fit <- 2#MYGRID$k_fit[SEG] 
iter  <- MYGRID$iter[SEG] 
rep   <- MYGRID$rep[SEG] 


# current parameters:
curr_mix <- subclass_mix_seq[iter]
lambda   <- c(0.5,0.5) #c(curr_mix,1-curr_mix)
eta      <- c(curr_mix,1-curr_mix) 

# set fixed simulation sequence:
seed_start <- 20161215  
set.seed(seed_start+seed_seq[SEG])

if (scn == 3){
  ThetaBS_withNA <- cbind(c(0.95,0.95,0.55,0.95,0.95,0.95),#subclass 1.
                          c(0.95,0.55,0.95,0.55,0.55,0.55))#subclass 2.
  PsiBS_withNA   <- cbind(c(0.4,0.4,0.05,0.2,0.2,0.2),     #subclass 1.
                          c(0.05,0.05,0.4,0.05,0.05,0.05)) #subclass 2.
}

if (scn == 2){
  ThetaBS_withNA <- cbind(c(0.95,0.9,0.85,0.9,0.9,0.9),   #subclass 1.
                          c(0.95,0.9,0.95,0.9,0.9,0.9))   #subclass 2.
  PsiBS_withNA   <- cbind(c(0.3,0.3,0.15,0.2,0.2,0.2),    #subclass 1.
                          c(0.15,0.15,0.3,0.05,0.05,0.05))#subclass 2.
}

if (scn == 1){
  ThetaBS_withNA <- cbind(c(0.95,0.9,0.9,0.9,0.9,0.9),#subclass 1.
                          c(0.95,0.9,0.9,0.9,0.9,0.9))#subclass 2.
  PsiBS_withNA   <- cbind(c(0.25,0.25,0.2,0.15,0.15,0.15),#subclass 1.
                          c(0.2,0.2,0.25,0.1,0.1,0.1))    #subclass 2.
}

# TO SIM W/ COVARIATES

N.SITE     <- 2                         #  Covariate SITE has 2 levels (Should be 2-3 For PPEARL)
N          <- N.SITE*(Nd+Nu)            # total number of subjects
                      
# etiology for all sites; true values for each site/pathogen combo:
etiology_allsites <- list(c(0.5,0.2,0.15,0.05,0.05,0.05),
                          c(0.2,0.5,0.15,0.05,0.05,0.05))

out_list <- lapply(1:N.SITE,function(siteID){ # For Each Site: Nd num cases, Nu num controls
  
  set_parameter <- list(
    cause_list   = cause_list,
    etiology     = etiology_allsites[[siteID]], 
    pathogen_BrS = LETTERS[1:J.BrS], 
    SS           = TRUE,    # simulate SS information (DNC)
    pathogen_SS  = LETTERS[1:2], # Pathogens we have SS information for
    meas_nm      = list(MBS = c("MBS1"),MSS=c("MSS1")),
    Lambda       = lambda,  # BrS subclass weight 
    Eta          = t(replicate(J.BrS,eta)),  # BrS case subclass weight
    PsiBS        = PsiBS0,  # FPR bronze-standard 
    PsiSS        = cbind(rep(0,J.BrS),rep(0,J.BrS)), # FPR for silver standard
    ThetaBS      = ThetaBS0, # TPR bronze-standard
    ThetaSS      = cbind(c(0.25,0.10,0.15,0.05,0.15,0.15), # TPRs for MSS1
                         c(0.25,0.10,0.15,0.05,0.15,0.15)),
    Nd = Nd, 
    Nu = Nu 
  )
  
  out     <- simulate_nplcm(set_parameter) 
  res   <- out$data_nplcm 
  res$X <- data.frame(SITE=rep(siteID,(set_parameter$Nd+set_parameter$Nu))) # covariate
  return(res)
})

data_nplcm_unordered  <- combine_data_nplcm(out_list) 
