##### Correlation Vis

# Functions ------------------------------------------------

##### Function: flat_corr_matrix -> flatten A Correlation Matrix
flat_corr_matrix <- function(corr, p) {
  ut = upper.tri(corr)
  data.frame(
    variable1 = rownames(corr)[row(corr)[ut]],
    variable2 = colnames(corr)[col(corr)[ut]],
    correlation = corr[ut],
    p_value = p[ut]
  )
}

##### Function: list_corr_matrix -> return a List of Unique Correlations
list_corr_matrix <- function(df) {
  res = rcorr(as.matrix(df))
  
  result = flat_corr_matrix(res$r, res$P)
  
  result_unique <- result %>%
    group_by(variable1, variable2) %>%
    filter(n() == 1) %>%
    ungroup()
  
  return(result_unique)
}

plot_corr_matrix <- function(df) {
  res = rcorr(as.matrix(df))
  cor_matrix <- res$r
  cor_plot = corrplot(cor_matrix, method = "circle", col = colorRampPalette(c("blue", "purple", "red"))(200),
                      tl.cex = 1,
                      cl.cex = 0.8,
                      tl.col = "black")
  return(cor_plot)
}

# Use -------------------------------------------------------------------------
##### Process (Ignore)
corr_df <- read_csv("corr_df.csv")

# Listed and Plotted Correlations
listed = list_corr_matrix(corr_df)

#new_labels = c('Age (Year)', 'Severity', 'Season', 'Rhinovirus','MycoPCR','STAPH','Virus')
#plot = plot_corr_matrix(corr_df, new_labels)
plot = plot_corr_matrix(corr_df)
plot
