set.seed(1)
thedir    <- paste0(tempdir(), "_no_reg")

# create folders to store the model results
dir.create(thedir, showWarnings = FALSE)
result_folder_no_reg <- file.path(thedir, paste("results", collapse = "_"))
thedir <- result_folder_no_reg
dir.create(thedir, showWarnings = FALSE)

mcmc_options_no_reg <- list(
  debugstatus = TRUE,
  n.chains = 1,
  n.itermcmc = as.integer(1000),
  n.burnin = as.integer(200),
  n.thin = 1,
  individual.pred = TRUE,
  # <- must set to TRUE! <------- NOTE!
  ppd = TRUE,
  result.folder = thedir,
  bugsmodel.dir = thedir
)

BrS_object_1 <- make_meas_object(
  patho = c("Rhinovirus","Virus"),
  specimen = "MBS",
  test = "1",
  quality = "BrS",
  cause_list = cause_list
)

BrS_object_2 <- make_meas_object(
  patho = c("MycoPCR"),
  specimen = "MBS",
  test = "2",
  quality = "BrS",
  cause_list = cause_list
)

SS_object_1 <- make_meas_object(
  patho = silver_causes,
  specimen = "MSS",
  test = "1",
  quality = "SS",
  cause_list = cause_list
)

clean_options <- list(BrS_objects = make_list(BrS_object_1,BrS_object_2),
                      SS_objects = make_list(SS_object_1))

# place the nplcm data and cleaning options into the results folder
dput(data_nplcm, file.path(thedir, "data_nplcm.txt"))
dput(clean_options, file.path(thedir, "data_clean_options.txt"))
