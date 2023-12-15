#first draft of code

library(readxl)
library(proBatch)
library(openxlsx)
library(writexl)
library(proBatch)
library(tidyverse)
library(dplyr)


data('example_proteome','example_sample_annotation',
     'example_peptide_annotation', package='proBatch')

#three tables need to be loaded into environment = The package typically 
#requires three datasets: 
#1) measurement (data matrix), 
#2) sample annotation, 
#3)feature annotation (optional)

#1) adding the Measurement dataset 
input_file_amg <- read_excel("/Users/mahdishafiei/Desktop/Amg/Contet-DU-B7-Amg-prosit-July2020-TIC-Contet-DU-Data-Format.xlsx")

feature_id_col = 'peptide_group_label'
measure_col = 'Intensity'
sample_id_col = 'FullRunName'

essential_columns = c(feature_id_col, measure_col, sample_id_col)

#2)sample annotation
batch_col = 'Batch'


#3) Feature (peptide) annotation
#A dataframe, where one row corresponds to one peptide, and
#the columns are names of proteins and corresponding genes.

generated_peptide_annotation <- create_peptide_annotation(example_proteome,
                                                          feature_id_col = 'peptide_group_label',
                                                          protein_col = 'Protein')

#Transforming the data to long or wide format  

example_matrix <- long_to_matrix(example_proteome,
                                 feature_id_col = 'peptide_group_label',
                                 measure_col = 'Intensity',
                                 sample_id_col = 'FullRunName')
#version of our dataset
example_matrix2 <- long_to_matrix(input_file_amg,
                                 feature_id_col = 'PeptideModifiedSequence',
                                 measure_col = 'TotalAreaFragment',
                                 sample_id_col = 'ReplicateName')

#Second way to make example matrix
data=data.frame(input_file_amg$ReplicateName,input_file_amg$PeptideModifiedSequence,input_file_amg$TotalAreaFragment)
names(data) <- c("PeptideModifiedSequence","ReplicateName","TotalAreaFragment")
wide_df <- data %>%
  pivot_wider(names_from = PeptideModifiedSequence, values_from = TotalAreaFragment)
dim(wide_df)
####################
#producing example_sample_annotation:
help('long_to_matrix')

metadata_B7 <- read_excel("/Users/mahdishafiei/Desktop/Contet-DU-Amg-B7-prosit-July2020-TIC-DIA-Contet-Meta.xlsx")
metadata_B8 <- read_excel("/Users/mahdishafiei/Desktop/Contet-DU-Amg-B8-prosit-July2020-TIC-DIA-Contet-Meta.xlsx")

combined_metadata <- rbind(metadata_B7, metadata_B8)
Batch <- c(rep(1, 17), rep(2, 16))
Order <- c(1:33)

example_sample_annotation_2 <- data.frame(combined_metadata$ReplicateName,
                                     Batch,combined_metadata$Mouse,
                                     combined_metadata$Treatment,Order)

colnames(example_sample_annotation_2) <- c("ReplicateName", "Batch", "mouse",
                                      "Treatment","Order")

##############################################
#Defining the color scheme
#Eartag = mouse
#Diet = Treatment
#

color_list_2 <- sample_annotation_to_colors(example_sample_annotation_2,
                                          factor_columns = c('Batch',
                                                             'mouse',
                                                             'Treatment'),
                                          numeric_columns = c('Order'))


color_list <- sample_annotation_to_colors(example_sample_annotation,
                                          factor_columns = c('MS_batch', 'digestion_batch',
                                                             'EarTag', 'Strain',
                                                             'Diet', 'Sex'),
                                          numeric_columns = c('DateTime','order'))
log_transformed_matrix <- log_transform_dm(example_matrix,
                                           log_base = 2, offset = 1)
plot_sample_mean(example_matrix2, example_sample_annotation_2, order_col = 'Order',
                 batch_col = Batch, color_by_batch = TRUE, ylimits = c(12, 16.5),
                 color_scheme = color_list[[batch_col]])


help(proBatch)
help("example_sample_annotation")
batch_col
rownamess_dataframe = wide_df$ReplicateName
wide_df = wide_df[, -1]
rownames(wide_df) = rownamess_dataframe


is.matrix(example_matrix2)
ee=long_to_matrix(input_file_amg,feature_id_col = "PeptideModifiedSequence",measure_col = "TotalAreaFragment",sample_id_col ="ReplicateName" )
long_to_matri

help("example_proteome_matrix")
??df_long


plot_sample_mean(ee, combined_metadata, order_col = 'Order',
                 batch_col = Batch, color_by_batch = TRUE, ylimits = c(12, 16.5),
                 color_scheme = color_list[[Batch]])



log_transformed_matrix <- log_transform_dm(example_matrix2,
                                           log_base = 2, offset = 1)

typeof(example_proteome)
typeof(input_file_amg)

color_list <- sample_annotation_to_colors(example_sample_annotation,
                                          factor_columns = c('MS_batch', 'digestion_batch',
                                                             'EarTag', 'Strain',
                                                             'Diet', 'Sex'),
                                          numeric_columns = c('DateTime','order'))
long_to_matri


View(color_list)











