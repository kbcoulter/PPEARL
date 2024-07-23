library(baker)
##### Data Sim ~ Unchanged

# Note: the example will only run 100 Gibbs sampling steps to save computing time.
# To produce useful posterior inferences, please modify "mcmc_options" as follows
#                      "n.itermcmc" to 50000
#                      "n.burnin"   to 10000,
#                      "n.thin"     to 40,


working_dir <- tempdir() # <-- create a temporary directory.
#curd = getwd()
#randname = paste(curd, basename(tempfile()), sep="/") # need absolute path
#dir.create(randname)
#working_dir = randname

K.true  <- 5   # no. of latent subclasses in actual simulation. 
# If eta = c(1,0), K.true is effectively 1.
J       <- 21   # no. of pathogens.
N       <- 1436 # no. of cases/controls.

# case subclass weight (five values):
subclass_mix_seq <- c(0,0.25,0.5,0.75,1)


NREP   <- 100
MYGRID <- expand.grid(list(rep   = 1:NREP, # data replication.
                           iter  = seq_along(subclass_mix_seq),# mixing weights.
                           k_fit = c(1,2), # model being fitted: 1 for pLCM; >1 for npLCM.
                           scn   = 3:1)    # index for different truth; see "scn_collection.R".
)

n_seed   <- nrow(unique(MYGRID[,-3]))
seed_seq <- rep(1:n_seed,times=length(unique(MYGRID[,3])))

SEG   <- 1 # The value could be 1 to nrow(MYGRID)=3000; here we just simulate one data set.
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
  ThetaBS_withNA <- cbind(c(0.95,0.95,0.55,0.95,0.95,0.95,0.95,0.95,0.55,0.95,0.95,0.95,0.95,0.95,0.55,0.95,0.95,0.95,0.95,0.95,0.55),#subclass 1.
                          c(0.95,0.55,0.95,0.55,0.55,0.55,0.95,0.55,0.95,0.55,0.55,0.55,0.95,0.55,0.95,0.55,0.55,0.55,0.95,0.55,0.95))#subclass 2.
  PsiBS_withNA   <- cbind(c(0.4,0.4,0.05,0.2,0.2,0.2,0.4,0.4,0.05,0.2,0.2,0.2,0.4,0.4,0.05,0.2,0.2,0.2,0.4,0.4,0.05),     #subclass 1.
                          c(0.05,0.05,0.4,0.05,0.05,0.05,0.05,0.05,0.4,0.05,0.05,0.05,0.05,0.05,0.4,0.05,0.05,0.05,0.05,0.05,0.4)) #subclass 2.
}

if (scn == 2){
  ThetaBS_withNA <- cbind(c(0.95,0.95,0.55,0.95,0.95,0.95,0.95,0.95,0.55,0.95,0.95,0.95,0.95,0.95,0.55,0.95,0.95,0.95,0.95,0.95,0.55),   #subclass 1.
                          c(0.95,0.55,0.95,0.55,0.55,0.55,0.95,0.55,0.95,0.55,0.55,0.55,0.95,0.55,0.95,0.55,0.55,0.55,0.95,0.55,0.95))   #subclass 2.
  PsiBS_withNA   <- cbind(c(0.4,0.4,0.05,0.2,0.2,0.2,0.4,0.4,0.05,0.2,0.2,0.2,0.4,0.4,0.05,0.2,0.2,0.2,0.4,0.4,0.05),    #subclass 1.
                          c(0.05,0.05,0.4,0.05,0.05,0.05,0.05,0.05,0.4,0.05,0.05,0.05,0.05,0.05,0.4,0.05,0.05,0.05,0.05,0.05,0.4))#subclass 2.
}

if (scn == 1){
  ThetaBS_withNA <- cbind(c(0.95,0.95,0.55,0.95,0.95,0.95,0.95,0.95,0.55,0.95,0.95,0.95,0.95,0.95,0.55,0.95,0.95,0.95,0.95,0.95,0.55),#subclass 1.
                          c(0.95,0.55,0.95,0.55,0.55,0.55,0.95,0.55,0.95,0.55,0.55,0.55,0.95,0.55,0.95,0.55,0.55,0.55,0.95,0.55,0.95))#subclass 2.
  PsiBS_withNA   <- cbind(c(0.4,0.4,0.05,0.2,0.2,0.2,0.4,0.4,0.05,0.2,0.2,0.2,0.4,0.4,0.05,0.2,0.2,0.2,0.4,0.4,0.05),#subclass 1.
                          c(0.05,0.05,0.4,0.05,0.05,0.05,0.05,0.05,0.4,0.05,0.05,0.05,0.05,0.05,0.4,0.05,0.05,0.05,0.05,0.05,0.4))    #subclass 2.
}



# the following paramter names are set using names in the 'baker' package:
set_parameter <- list(
  cause_list      = c(LETTERS[1:J]),
  etiology        = c(0.5,0.2,0.15,0.05,0.05,0.05,0.5,0.2,0.15,0.05,0.05,0.05,0.5,0.2,0.15,0.05,0.05,0.05,0.5,0.2,0.15),# same length as cause_list.
  pathogen_BrS    = LETTERS[1:J],
  meas_nm         = list(MBS = c("MBS1")), # a single source of Bronze Standard (BrS) data.
  Lambda          = lambda,              #ctrl mix (subclass weights).
  Eta             = t(replicate(J,eta)), #case mix; # of rows equals length(cause_list).
  PsiBS           = PsiBS_withNA,
  ThetaBS         = ThetaBS_withNA,
  Nu      =     N, # control sample size.
  Nd      =     N  # case sample size.
)

# # visualize pairwise log odds ratios for cases and controls when eta changes 
# # from 0 to 1. In the following simulation, we just use one value: eta=0.
# example("compute_logOR_single_cause")

simu_out   <- simulate_nplcm(set_parameter)
data_nplcm <- simu_out$data_nplcm
data_nplcm
