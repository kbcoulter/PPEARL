# **PPEARL** - Pediatric Pneumonia Etiology Analysis applying an R Latent model

Pediatric community-acquired pneumonia (CAP) leads to 1.8 million healthcare visits in the US every year and is the single largest infectious 
cause of death in children worldwide. Correct microbial diagnosis to determine etiology is fundamental for appropriate treatment and research 
but is currently achieved in under 50% of cases. This is largely due to a lack of non-invasive tests with acceptable sensitivity, compounded 
by the co-occurrence of pathogens in asymptomatic patients.

We present PPEARL, a partial latent class model (pLCM), built on an enriched set of clinical markers from the CARPE DIEM and MEEP datasets as 
a computational approach to determine individual's latent lung infection status based on partial multivariate data. Implemented with 
the R package [BAKER](https://CRAN.R-project.org/package=baker), PPEARL integrates heterogeneous measurements and both latent and observed 
variables, utilizing priors from the [PERCH](https://pubmed.ncbi.nlm.nih.gov/31257127/) model and related research. 

# **Currently:**
Refinement and analysis of additional covariates is ongoing to improve model accuracy (requiring data simulation). 

Further data assessing metabolite presence in patients, related to pathogen etiology in pneumonia, remains to be analyzed.

We aim to provide a thorough description of the methods used to allow for application in broader medical settings and to aid in further pathogen 
identification research for pediatric pneumonia patients.

# If you have questions, comments or inquiries, please reach out!

![Final Poster](https://github.com/user-attachments/assets/3546505b-d8ca-4d36-9682-100fdbc8349c)
