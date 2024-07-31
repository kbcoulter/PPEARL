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

Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 0, "No Virus" , Virus_Pathogen_ID_Carpe)
Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 1, "Influenza A" , Virus_Pathogen_ID_Carpe)
Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 2, "Influenza B" , Virus_Pathogen_ID_Carpe)
Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 3, "Parainfluenza 1" , Virus_Pathogen_ID_Carpe)
Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 4, "Parainfluenza 2" , Virus_Pathogen_ID_Carpe)
Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 5, "Parainfluenza 3" , Virus_Pathogen_ID_Carpe)
Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 6, "RSV" , Virus_Pathogen_ID_Carpe)
Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 7, "Human Metapneumovirus" , Virus_Pathogen_ID_Carpe)
Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 8, "Rhinovirus/Enterovirus" , Virus_Pathogen_ID_Carpe)
Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 9, "Adenovirus" , Virus_Pathogen_ID_Carpe)
Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 10, "Coronavirus" , Virus_Pathogen_ID_Carpe)
Virus_Pathogen_ID_Carpe <- ifelse(Virus_Pathogen_ID_Carpe == 11, "Human Bocavirus" , Virus_Pathogen_ID_Carpe)

virus_counts = table(Virus_Pathogen_ID_Carpe)
virus_counts = data.frame(virus_counts)
virus_counts = mutate(virus_counts, Freq)

p = ggplot(
  virus_counts,
  aes(x = reorder(Virus_Pathogen_ID_Carpe, -Freq), y = Freq, fill = Virus_Pathogen_ID_Carpe)) +
  geom_col(position = "stack")  + theme(axis.text.x = element_blank(),legend.title = element_blank()) + scale_y_continuous(limits = c(0,NA), expand = expansion(mult = 0,add = 0))+ labs(y = "Count") + labs(x = "Viruses in Cases" ) + scale_fill_viridis_d(breaks = c("No Virus", "Rhinovirus/Enterovirus", "RSV","Human Metapneumovirus", "Influenza A", "Coronavirus", "Human Bocavirus", "Parainfluenza 3","Parainfluenza 1", "Influenza B", "Adenovirus" )) +  theme(
  legend.position = c('11_Human Bocavirus', 300),
  legend.justification = c(0.7, 1),
  axis.title = element_text(size = 30),
  # Increase size of axis text
  axis.text = element_text(size = 20),
  # Increase size of legend title
  legend.title = element_text(size = 26),
  # Increase size of legend text
  legend.text = element_text(size = 35),
  # Increase size of plot title
  plot.title = element_text(size = 20)
) + theme(legend.title = element_blank()) # x and y positions

p
png("barchart1.png", width = 800, height = 800)
print(p)
dev.off()
##### Carpe Bacteria Count


Bacteria_ID_Carpe = replace_na(data_carp$bacteria_1, 0)

Bacteria_ID_Carpe <- ifelse(Bacteria_ID_Carpe == 0, "No Bacteria" , Bacteria_ID_Carpe)
Bacteria_ID_Carpe <- ifelse(Bacteria_ID_Carpe == 2, "Mycoplasma Pneumoniae" , Bacteria_ID_Carpe)
Bacteria_ID_Carpe <- ifelse(Bacteria_ID_Carpe == 6, "Staphylococcus Aureus" , Bacteria_ID_Carpe)

bact_count = data.frame(table(Bacteria_ID_Carpe))
bact_count = mutate(bact_count, Freq)

q = ggplot(bact_count, aes(x = reorder(Bacteria_ID_Carpe, -Freq), y = Freq , fill = Bacteria_ID_Carpe)) + geom_col(position = "stack" )  +scale_y_continuous(limits = c(0,NA), expand = expansion(mult = 0,add = 0))+ theme(axis.text.x = element_blank(),legend.title = element_blank()) + labs(y = "Count") + labs(x = "Bacteria in Cases" ) + scale_fill_viridis_d(breaks = c("No Bacteria", "Mycoplasma Pneumoniae", "Staphylococcus Aureus")) + theme(
  legend.position = c('06_Staphylococcus Aureus', 500),
  legend.justification = c(0.9, 1),
  axis.title = element_text(size = 30),
  # Increase size of axis text
  axis.text = element_text(size = 20),
  # Increase size of legend title
  legend.title = element_text(size = 29),
  # Increase size of legend text
  legend.text = element_text(size = 35),
  # Increase size of plot title
  plot.title = element_text(size = 20)
) + theme(legend.title = element_blank())  # x and y positions

q
png("barchart2.png", width = 800, height = 800)
print(q)
dev.off()

##### Count of Meep Viruses



Virus_Pathogen_ID_Meep = replace_na(data_meep$virus_1,0)

Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 0, "No Virus" , Virus_Pathogen_ID_Meep)
Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 1, "Influenza A" , Virus_Pathogen_ID_Meep)
Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 2, "Influenza B" , Virus_Pathogen_ID_Meep)
Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 3, "Parainfluenza 1" , Virus_Pathogen_ID_Meep)
Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 4, "Parainfluenza 2" , Virus_Pathogen_ID_Meep)
Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 5, "Parainfluenza 3" , Virus_Pathogen_ID_Meep)
Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 6, "RSV" , Virus_Pathogen_ID_Meep)
Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 7, "Human Metapneumovirus" , Virus_Pathogen_ID_Meep)
Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 8, "Rhinovirus/Enterovirus" , Virus_Pathogen_ID_Meep)
Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 9, "Adenovirus" , Virus_Pathogen_ID_Meep)
Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 10, "Coronavirus" , Virus_Pathogen_ID_Meep)
Virus_Pathogen_ID_Meep <- ifelse(Virus_Pathogen_ID_Meep == 11, "Human Bocavirus" , Virus_Pathogen_ID_Meep)

virus_counts = table(Virus_Pathogen_ID_Meep)
virus_counts = data.frame(virus_counts)
virus_counts = mutate(virus_counts, Freq)
r = ggplot(virus_counts, aes(x = reorder(Virus_Pathogen_ID_Meep, -Freq), y = Freq, fill = Virus_Pathogen_ID_Meep )) + geom_col(position = "stack")  + theme(axis.text.x = element_blank()) +scale_y_continuous(limits = c(0,NA), expand = expansion(mult = 0,add = 0))+ labs(y = "Count") + labs(x = "Viruses in Controls" ) + scale_fill_viridis_d(breaks = c("No Virus", "Rhinovirus/Enterovirus", "Influenza A","Parainfluenza 1", "Human Metapneumovirus")) +theme(
  legend.position = c('03_Parainfluenza 1', 100),
  legend.justification = c(0.7, 1),
  axis.title = element_text(size = 30),
  # Increase size of axis text
  axis.text = element_text(size = 20),
  # Increase size of legend title
  legend.title = element_text(size = 29),
  # Increase size of legend text
  legend.text = element_text(size = 35),
  # Increase size of plot title
  plot.title = element_text(size = 20)
) + theme(legend.title = element_blank()) # x and y positions

r

png("barchart3.png", width = 800, height = 800)
print(r)
dev.off()
