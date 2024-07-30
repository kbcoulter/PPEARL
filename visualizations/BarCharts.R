##### Bar Charts
  
library(tidyverse)
library(ggplot2)
library(ggstats)

##### Loading Data
# Use Preprocessing "carpe_clean" and "meep_clean"

data_carp = carpe_clean
data_meep = meep_clean
# head(data_carp)
# head(data_meep)

##### Count of Carpe Viruses Including multiple occurrences
virus1 = replace_na(data_carp$virus_1, 0)
virus2 = na_if(data_carp$virus_2, 0)
virus3 = na_if(data_carp$virus_3, 0)
total_virus = c(virus1,virus2,virus3)
Virus_Pathogen_ID_Carpe = total_virus

Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 0, "00_No Virus" , Virus_Pathogen_ID_Carpe)
Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 1, "01_Influenza A" , Virus_Pathogen_ID_Carpe)
Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 2, "02_Influenza B" , Virus_Pathogen_ID_Carpe)
Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 3, "03_Parainfluenza 1" , Virus_Pathogen_ID_Carpe)
Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 4, "04_Parainfluenza 2" , Virus_Pathogen_ID_Carpe)
Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 5, "05_Parainfluenza 3" , Virus_Pathogen_ID_Carpe)
Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 6, "06_RSV" , Virus_Pathogen_ID_Carpe)
Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 7, "07_Human Metapneumovirus" , Virus_Pathogen_ID_Carpe)
Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 8, "08_Enterovirus/Rhinovirus" , Virus_Pathogen_ID_Carpe)
Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 9, "09_Adenovirus" , Virus_Pathogen_ID_Carpe)
Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 10, "10_Coronavirus" , Virus_Pathogen_ID_Carpe)
Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 11, "11_Human Bocavirus" , Virus_Pathogen_ID_Carpe)

virus_counts = table(Virus_Pathogen_ID_Carpe)
virus_counts = data.frame(virus_counts)
virus_counts = mutate(virus_counts, Freq)

p = ggplot(
  virus_counts,
  aes(x = Virus_Pathogen_ID_Carpe, y = Freq, fill = Virus_Pathogen_ID_Carpe)
) + geom_col(position = "stack")  + theme(axis.text.x = element_blank()) + labs(y = "Count") + scale_fill_viridis_d() +  theme(
  legend.position = c('11_Human Bocavirus', 300),
  legend.justification = c(0.7, 1),
  axis.title = element_text(size = 16),
  # Increase size of axis text
  axis.text = element_text(size = 18),
  # Increase size of legend title
  legend.title = element_text(size = 18),
  # Increase size of legend text
  legend.text = element_text(size = 17),
  # Increase size of plot title
  plot.title = element_text(size = 20)
)  # x and y positions

p
png("barchart1.png", width = 800, height = 800)
print(p)
dev.off()
##### Carpe Bacteria Count


Bacteria_ID_Carpe = replace_na(data_carp$bacteria_1, 0)

Bacteria_ID_Carpe <- ifelse(Bacteria_ID_Carpe == 0, "00_No Bacteria" , Bacteria_ID_Carpe)
Bacteria_ID_Carpe <- ifelse(Bacteria_ID_Carpe == 2, "02_Mycoplasma Pneumoniae" , Bacteria_ID_Carpe)
Bacteria_ID_Carpe <- ifelse(Bacteria_ID_Carpe == 6, "06_Staphylococcus Aureus" , Bacteria_ID_Carpe)

bact_count = data.frame(table(Bacteria_ID_Carpe))
bact_count = mutate(bact_count, Freq)

q = ggplot(bact_count, aes(x = Bacteria_ID_Carpe, y = Freq , fill = Bacteria_ID_Carpe)) + geom_col(position = "stack" )  + theme(axis.text.x = element_blank()) + labs(y = "Count") + scale_fill_viridis_d() + theme(
  legend.position = c('06_Staphylococcus Aureus', 500),
  legend.justification = c(0.7, 1),
  axis.title = element_text(size = 16),
  # Increase size of axis text
  axis.text = element_text(size = 18),
  # Increase size of legend title
  legend.title = element_text(size = 18),
  # Increase size of legend text
  legend.text = element_text(size = 17),
  # Increase size of plot title
  plot.title = element_text(size = 20)
)  # x and y positions

q
png("barchart2.png", width = 800, height = 800)
print(q)
dev.off()

##### Count of Meep Viruses



Virus_Pathogen_ID_Meep = replace_na(data_meep$virus_1,0)

Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 0, "00_No Virus" , Virus_Pathogen_ID_Meep)
Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 1, "01_Influenza A" , Virus_Pathogen_ID_Meep)
Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 2, "02_Influenza B" , Virus_Pathogen_ID_Meep)
Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 3, "03_Parainfluenza 1" , Virus_Pathogen_ID_Meep)
Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 4, "04_Parainfluenza 2" , Virus_Pathogen_ID_Meep)
Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 5, "05_Parainfluenza 3" , Virus_Pathogen_ID_Meep)
Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 6, "06_RSV" , Virus_Pathogen_ID_Meep)
Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 7, "07_Human Metapneumovirus" , Virus_Pathogen_ID_Meep)
Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 8, "08_Enterovirus/Rhinovirus" , Virus_Pathogen_ID_Meep)
Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 9, "09_Adenovirus" , Virus_Pathogen_ID_Meep)
Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 10, "10_Coronavirus" , Virus_Pathogen_ID_Meep)
Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 11, "11_Human Bocavirus" , Virus_Pathogen_ID_Meep)

virus_counts = table(Virus_Pathogen_ID_Meep)
virus_counts = data.frame(virus_counts)
virus_counts = mutate(virus_counts, Freq)
r = ggplot(virus_counts, aes(x = Virus_Pathogen_ID_Meep, y = Freq, fill = Virus_Pathogen_ID_Meep )) + geom_col(position = "stack")  + theme(axis.text.x = element_blank()) + labs(y = "Count") + scale_fill_viridis_d() +theme(
  legend.position = c('03_Parainfluenza 1', 100),
  legend.justification = c(0.7, 1),
  axis.title = element_text(size = 16),
  # Increase size of axis text
  axis.text = element_text(size = 18),
  # Increase size of legend title
  legend.title = element_text(size = 18),
  # Increase size of legend text
  legend.text = element_text(size = 17),
  # Increase size of plot title
  plot.title = element_text(size = 20)
)  # x and y positions

r

png("barchart3.png", width = 800, height = 800)
print(r)
dev.off()
