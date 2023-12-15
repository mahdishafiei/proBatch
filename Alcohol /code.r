library(readxl)
library(proBatch)
library(openxlsx)
library(writexl)
library(tidyverse)
library(dplyr)



feature_id_col = 'PeptideModifiedSequence'
measure_col = 'TotalAreaFragment'
sample_id_col = 'ReplicateName'
essential_columns = c(feature_id_col, measure_col, sample_id_col)

#1) adding the Measurement dataset 

input_file_amg <- read_excel("/Users/mahdishafiei/Desktop/Amg/Contet-DU-B7-Amg-prosit-July2020-TIC-Contet-DU-Data-Format.xlsx")
input_file_amg_B8 <- read_excel("/Users/mahdishafiei/Desktop/Amg/Contet-DU-B8-Amg-prosit-July2020-TIC-Contet-DU-Data-Format.xlsx")
input_file_amg_bothBatch <- rbind(input_file_amg, input_file_amg_B8)

###finding out the peptides with zero amount for "TotalAreaFragment"
zero_area_rows <- input_file_amg_B8$TotalAreaFragment == 0

# Display the corresponding peptides
peptides_with_zero_area <- input_file_amg_B8$PeptideModifiedSequence[zero_area_rows]
view(peptides_with_zero_area)
length(peptides_with_zero_area)

########################################################

# Filter out rows with PeptideModifiedSequence in peptides_with_zero_area
filtered_dataset <- input_file_amg_B8 %>%
  filter(!PeptideModifiedSequence %in% peptides_with_zero_area)
########################################################

# removing the"NormalizedArea" and "TicArea" in my filtered dataset
filtered_dataset_2 <- filtered_dataset %>%
  select(-NormalizedArea, -TicArea)

#####see if we have zero amount in TotalAreaFragment col
has_zero <- any(filtered_dataset_2$TotalAreaFragment == 0)

# Print the result
if (has_zero) {
  cat("The 'TotalAreaFragment' column contains at least one value equal to 0.\n")
} else {
  cat("The 'TotalAreaFragment' column does not contain any value equal to 0.\n")
}
########################################################
#Just first 1800 rows
filtered_dataset_3 <- filtered_dataset_2[1:1755, ]
########################################################

jj1 <- filtered_dataset_2 %>%
  group_by(PeptideModifiedSequence) %>%
  mutate(row_number = row_number()) %>%
  filter(row_number <= 17) %>%
  select(-row_number) %>%
  ungroup()
########################################################

jj2 <- filtered_dataset_2 %>%
  group_by(PeptideModifiedSequence) %>%
  mutate(row_number = row_number()) %>%
  filter(row_number <= 16) %>%
  select(-row_number) %>%
  ungroup()

########################################################
# Assuming 'jj1' and 'jj2' are your datasets
comvined_j <- rbind(jj1, jj2)
########################################################


help('long_to_matrix')
example_matrix_filteredata <- long_to_matrix(jj1,
                                 feature_id_col = 'PeptideModifiedSequence',
                                 measure_col = 'TotalAreaFragment',
                                 sample_id_col = 'ReplicateName')
########################################################
imputed_j <- example_matrix_filteredata %>%
  mutate_all(~ ifelse(is.na(.), mean(., na.rm = TRUE), .))
########################################################

log_transformed_matrix_filteredata <- log_transform_dm(example_matrix_filteredata,
                                           log_base = 2, offset = 1)

########################################################
#producing sample annotation 

metadata_B7 <- read_excel("/Users/mahdishafiei/Desktop/Contet-DU-Amg-B7-prosit-July2020-TIC-DIA-Contet-Meta.xlsx")
metadata_B8 <- read_excel("/Users/mahdishafiei/Desktop/Contet-DU-Amg-B8-prosit-July2020-TIC-DIA-Contet-Meta.xlsx")

combined_metadata <- rbind(metadata_B7, metadata_B8)
# Remove the "AnalyteConcentration" column
combined_metadata <- combined_metadata %>%
  select(-AnalyteConcentration)
#adding Order to dataset

combined_metadata <- combined_metadata %>%
  mutate(order = 1:33)
# Add a new column named "batch" with specified pattern
combined_metadata <- combined_metadata %>%
  mutate(batch = rep(c(1, 2), times = c(17, 16)))

####
batch_col = 'batch'
#######
combined_metadata_justbatch1 <- head(combined_metadata, 17)

color_list_filteredata <- sample_annotation_to_colors(combined_metadata_justbatch1,
                                          factor_columns = c('batch',
                                                             'Treatment'),
                                          numeric_columns = c('order'))

########################################################
# Rename the "ReplicateName" column to "FullRunName"
combined_metadata_filtered <- combined_metadata_justbatch1 %>%
  rename(FullRunName = ReplicateName)

########################################################
########################################################
#Just B7
# Remove the "AnalyteConcentration" column
metadata_B7 <- metadata_B7 %>%
  select(-AnalyteConcentration)
#adding Order to dataset

metadata_B7 <- metadata_B7 %>%
  mutate(order = 1:17)
# Add a new column named "batch" with specified pattern
metadata_B7 <- metadata_B7 %>%
  mutate(batch = rep(c(1), times = c(17)))

# Rename the "ReplicateName" column to "FullRunName"
metadata_B7 <- metadata_B7 %>%
  rename(FullRunName = ReplicateName)
########################################################
########################################################

color_list_metadataB7 <- sample_annotation_to_colors(metadata_B7,
                                                      factor_columns = c('batch',
                                                                         'Treatment'),
                                                      numeric_columns = c('order'))




plot_sample_mean(log_transformed_matrix_filteredata, metadata_B7, order_col = 'order',
                 batch_col = batch_col, color_by_batch = TRUE, ylimits = c(0, 100),
                 color_scheme = color_list_metadataB7[[batch_col]])




library(openxlsx)


file_path <- "jj2.xlsx"

# Write the dataframe to an Excel file
write.xlsx(jj2, file_path)






library(dplyr)

# Assuming 'your_dataset' is your dataframe and 'name_column' is the column with names
jj <- filtered_dataset_2 %>%
  group_by(PeptideModifiedSequence) %>%
  mutate(row_number = row_number()) %>%
  filter(row_number <= 17) %>%
  select(-row_number) %>%
  ungroup()





help('plot_sample_mean')

View(data_ma)
dim(log_transformed_matrix_filteredata)



