rjags::load.module("glm")

nplcm_4 <- nplcm(
  data_nplcm = data_nplcm,
  model_options = model_options_no_reg,
  mcmc_options = mcmc_options_no_reg
)

