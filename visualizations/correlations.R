#Correlation Funcitons/Use
#! Not complete, not importing carpe currently

# Function: vis_corr_matrix -> create a Visual Correlation Matrix
vis_corr_matrix <- function(df) {
  df = subset(df, select = -c(study_id))
  M = cor(df)
  return(corrplot(M, method="circle"))
}

# Function: flat_corr_matrix -> flatten A Correlation Matrix
flat_corr_matrix <- function(corr, p) {
  ut = upper.tri(corr)
  data.frame(
    variable1 = rownames(corr)[row(corr)[ut]],
    variable2 = colnames(corr)[col(corr)[ut]],
    correlation = corr[ut],
    p_value = p[ut]
  )
}

# Function: list_corr_matrix -> return a List of Unique Correlations
list_corr_matrix <- function(df) {
  df = subset(df, select = -c(study_id))
  res = rcorr(as.matrix(df))
  
  result = flat_corr_matrix(res$r, res$P)
  
  result_unique <- result %>%
    group_by(variable1, variable2) %>%
    filter(n() == 1) %>%
    ungroup()
  
  return(result_unique)
}

# correlations: correlations from carpe_clean_filtered
correlations = list_corr_matrix(carpe_clean_filtered)
