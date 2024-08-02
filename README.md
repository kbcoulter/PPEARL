# **PPEARL** - **P** ediatric **P** neumonia **E** tiology **A** nalysis applying an **R** **L** atent model

Pediatric community-acquired pneumonia (CAP) leads to 1.8 million healthcare visits in the US every year and is the single largest infectious 
cause of death in children worldwide. Correct microbial diagnosis to determine etiology is fundamental for appropriate treatment and research 
but is currently achieved in under 50% of cases. This is largely due to a lack of non-invasive tests with acceptable sensitivity, compounded 
by the co-occurrence of pathogens in asymptomatic patients.

We present PPEARL, a partial latent class model (pLCM), built on an enriched set of clinical markers from the CARPE DIEM1 and MEEP2 datasets as 
a computational approach to determine pathogen etiology.

To determine an individual’s latent lung infection status based on partial knowledge from multivariates, heterogeneous measurements, and discrete 
latent and observed variables are fitted with a Partial Latent Class Model utilizing the R package [BAKER](https://CRAN.R-project.org/package=baker), and priors from a previous model and research study, [PERCH]([10.1016/S0140-6736(19)30721-4](https://pubmed.ncbi.nlm.nih.gov/31257127/)).

# **Currently:**
Refinement and analysis of additional covariates are ongoing to improve the model's accuracy. 

Further data assessing metabolite presence in patients, which is related to pathogen etiology in pneumonia, remains to be analyzed.

We aim to provide a thorough description of the methods used to allow for application in broader medical settings to aid in further pathogen identification research for 
pediatric pneumonia patients.

# If you have questions, comments or inquiries, please reach out!
