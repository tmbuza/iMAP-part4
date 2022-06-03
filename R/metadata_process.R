library(tidyverse)

set.seed(110912)

source("R/taxon_level_abundance_tables.R")

metadata <- data.frame(SampleID = names(genus_shared)[-c(1:2)]) 

metadata <- metadata %>%
  mutate(Direction = ifelse(SampleID %like% "_R1", "Foward", "Reverse"),
         HiSeq = ifelse(SampleID %like% "hiseq", "HiSeq", ""),
         MiSeq = ifelse(SampleID %like% "miseq", "MiSeq", ""),
         NovaSeq = ifelse(SampleID %like% "novaseq", "NovaSeq", ""),
         Group = ifelse(seq_along(rownames(metadata)) %% 2 != 0, "Group1", "Group2")) %>%
  mutate(Platform = paste(HiSeq, MiSeq, NovaSeq)) %>%
  select(-HiSeq, -MiSeq, -NovaSeq)

head(metadata)

write_csv(metadata, "RDataRDS/metadata.csv")
saveRDS(metadata, "RDataRDS/metadata.rds")
