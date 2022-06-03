library(tidyverse)
source("R/profiles_w_count_process.R")
set.seed(110812)


## Kingdom Relative Abundance
df_kingdom <- as.data.frame(raw_taxa_abundance) %>%
  dplyr::filter(!grepl("p__|c__|o__|f__|g__|s__", clade_name))
colnames(df_kingdom)[1] <- "Kingdom"

for ( i in df_kingdom$Kingdom) { df_kingdom$Kingdom <- sub(".*\\|", "", df_kingdom$Kingdom) }
df_kingdom <- df_kingdom %>%
  distinct(Kingdom, .keep_all = T)

kingdom_shared <- df_kingdom %>%
  mutate(OTU = paste("OTU", seq(1:length(rownames(df_kingdom))), sep = "_"), .before = Kingdom)

write_csv(df_kingdom, "RDataRDS/df_kingdom.csv" )
write_csv(kingdom_shared, "RDataRDS/kingdom_shared.csv" )
saveRDS(df_kingdom, "RDataRDS/df_kingdom.rds" )


## Phylum Relative Abundance
df_phylum <- as.data.frame(raw_taxa_abundance) %>%
  dplyr::filter(!grepl("c__|o__|f__|g__|s__", clade_name))
colnames(df_phylum)[1] <- "Phylum"
for ( i in df_phylum$Phylum) { df_phylum$Phylum <- sub(".*\\|", "", df_phylum$Phylum) }
df_phylum <- df_phylum %>%
  distinct(Phylum, .keep_all = T) %>%
  dplyr::filter(!grepl("k__", Phylum))

phylum_shared <- df_phylum %>%
  mutate(OTU = paste("OTU", seq(1:length(rownames(df_phylum))), sep = "_"), .before = Phylum)

write_csv(df_phylum, "RDataRDS/df_phylum.csv" )
write_csv(phylum_shared, "RDataRDS/phylum_shared.csv" )
saveRDS(df_phylum, "RDataRDS/df_phylum.rds" )

## Class Relative Abundance

df_class <- as.data.frame(raw_taxa_abundance) %>%
  dplyr::filter(!grepl("o__|f__|g__|s__", clade_name))

colnames(df_class)[1] <- "Class"
for ( i in df_class$Class) { df_class$Class <- sub(".*\\|", "", df_class$Class) }

df_class <- df_class <- df_class %>%
  distinct(Class, .keep_all = T) %>%
  dplyr::filter(!grepl("k__|p__", Class))

class_shared <- df_class %>%
  mutate(OTU = paste("OTU", seq(1:length(rownames(df_class))), sep = "_"), .before = Class)

write_csv(df_class, "RDataRDS/df_class.csv" )
write_csv(class_shared, "RDataRDS/class_shared.csv" )
saveRDS(df_class, "RDataRDS/df_class.rds" )

## Order Relative Abundance

df_order <- as.data.frame(raw_taxa_abundance) %>%
  dplyr::filter(!grepl("f__|g__|s__", clade_name))

colnames(df_order)[1] <- "Order"
for ( i in df_order$Order) { df_order$Order <- sub(".*\\|", "", df_order$Order) }

df_order <- df_order <- df_order %>%
  distinct(Order, .keep_all = T) %>%
  dplyr::filter(!grepl("k__|p__|c__", Order))

order_shared <- df_order %>%
  mutate(OTU = paste("OTU", seq(1:length(rownames(df_order))), sep = "_"), .before = Order)

write_csv(df_order, "RDataRDS/df_order.csv" )
write_csv(order_shared, "RDataRDS/order_shared.csv" )
saveRDS(df_order, "RDataRDS/df_order.rds" )

## Family Relative Abundance

df_family <- as.data.frame(raw_taxa_abundance) %>%
  dplyr::filter(!grepl("g__|s__", clade_name))

colnames(df_family)[1] <- "Family"
for ( i in df_family$Family) { df_family$Family <- sub(".*\\|", "", df_family$Family) }

df_family <- df_family <- df_family %>%
  distinct(Family, .keep_all = T) %>%
  dplyr::filter(!grepl("k__|p__|c__|o__", Family))

family_shared <- df_family %>%
  mutate(OTU = paste("OTU", seq(1:length(rownames(df_family))), sep = "_"), .before = Family)

write_csv(df_family, "RDataRDS/df_family.csv" )
write_csv(family_shared, "RDataRDS/family_shared.csv" )
saveRDS(df_family, "RDataRDS/df_family.rds" )

## Genus Relative Abundance

df_genus <- as.data.frame(raw_taxa_abundance) %>%
  dplyr::filter(!grepl("s__", clade_name))

colnames(df_genus)[1] <- "Genus"
for ( i in df_genus$Genus) { df_genus$Genus <- sub(".*\\|", "", df_genus$Genus) }

df_genus <- df_genus %>%
  distinct(Genus, .keep_all = T) %>%
  dplyr::filter(!grepl("k__|p__|c__|o__|f__", Genus))

genus_shared <- df_genus %>%
  mutate(OTU = paste("OTU", seq(1:length(rownames(df_genus))), sep = "_"), .before = Genus)

write_csv(df_genus, "RDataRDS/df_genus.csv" )
write_csv(genus_shared, "RDataRDS/genus_shared.csv" )
saveRDS(df_genus, "RDataRDS/df_genus.rds" )

## Species Relative Abundance

df_species <- as.data.frame(raw_taxa_abundance) %>%
  dplyr::filter(grepl("s__", clade_name))

colnames(df_species)[1] <- "Species"
for ( i in df_species$Species) { df_species$Species <- sub(".*\\|", "", df_species$Species) }

df_species <-df_species %>%
  distinct(Species, .keep_all = T) %>%
  dplyr::filter(!grepl("k__|p__|c__|o__|f__|__g", Species))

species_shared <- df_species %>%
  mutate(OTU = paste("OTU", seq(1:length(rownames(df_species))), sep = "_"), .before = Species)

write_csv(df_species, "RDataRDS/df_species.csv" )
write_csv(species_shared, "RDataRDS/species_shared.csv" )
saveRDS(df_species, "RDataRDS/df_species.rds" )

# Save abundance Objects

save(
  df_kingdom,
  df_phylum,
  df_class,
  df_order,
  df_family,
  df_genus,
  df_species,
  
  # With OTU column
  kingdom_shared,
  phylum_shared,
  class_shared,
  order_shared,
  family_shared,
  genus_shared,
  species_shared,
  file = "RDataRDS/taxa_abund_tables.RData"
)

# Confirm
# load("RDataRDS/taxa_abund_tables.RData", verbose = T)