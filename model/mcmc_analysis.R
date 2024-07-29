library(coda)
library(ggmcmc)


res_nplcm_noreg <- coda::read.coda(
  file.path(nplcm_4$DIR_NPLCM, "CODAchain1.txt"),
  file.path(nplcm_4$DIR_NPLCM, "CODAindex.txt"),
  quiet = TRUE
)

get_res <- function(x,res) res[,grep(x,colnames(res))]
res <- get_res("pEti",res_nplcm_noreg)

coda::raftery.diag(mcmc.list(res))

ggmcmc::ggs_traceplot(ggmcmc::ggs(res))

plot(nplcm_4,slice=list(MBS=2,MSS=1))

plot_check_pairwise_SLORD(nplcm_4$DIR_NPLCM,slice = 1)

get_individual_data(1:10,nplcm_4)

predictions = get_individual_prediction(nplcm_4)


