library(coda)
library(ggmcmc)


res_nplcm_noreg <- coda::read.coda(
  file.path(nplcm_5$DIR_NPLCM, "CODAchain1.txt"),
  file.path(nplcm_5$DIR_NPLCM, "CODAindex.txt"),
  quiet = TRUE
)

get_res <- function(x,res) res[,grep(x,colnames(res))]
res <- get_res("pEti",res_nplcm_noreg)

coda::raftery.diag(mcmc.list(res))

ggmcmc::ggs_traceplot(ggmcmc::ggs(res))


