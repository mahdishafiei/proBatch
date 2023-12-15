##code second draft

df3= as.vector(peptides_with_zero_area)
view(peptides_with_zero_area)
install.packages("stringdist")
library(stringdist)


hahadata <- read_excel("/Users/mahdishafiei/Desktop/Book1.xlsx")
example_haha <- long_to_matrix(hahadata,
                                  feature_id_col = 'PeptideModifiedSequence',
                                  measure_col = 'TotalAreaFragment',
                                  sample_id_col = 'ReplicateName')


###finding out the peptides with zero amount for "TotalAreaFragment"
zero_area_rows <- input_file_amg$TotalAreaFragment == 0

# Display the corresponding peptides
peptides_with_zero_area <- input_file_amg$PeptideModifiedSequence[zero_area_rows]
view(peptides_with_zero_area)
length(peptides_with_zero_area)
##################

typeof(peptides_with_zero_area)

########################################################

# Filter out rows with PeptideModifiedSequence in peptides_with_zero_area
filtered_dataset <- input_file_amg %>%
  filter(!PeptideModifiedSequence %in% peptides_with_zero_area)
########################################################
#removing the decimals
filtered_dataset <- filtered_dataset %>%
  mutate(TotalAreaFragment = as.integer(TotalAreaFragment))
########################################################

# Remove the first 15 rows
filtered_dataset <- filtered_dataset %>%
  slice(-(1:15))
####

# Remove the last column
filtered_dataset <- filtered_dataset %>%
  select(-ncol(.))

# Remove the column named "TicArea"
filtered_dataset <- filtered_dataset %>%
  select(-TicArea)
#########
filtered_dataset <- filtered_dataset %>%
  slice(-(1:3))
####
# Calculate the midpoint to split the dataset into two halves
midpoint <- nrow(filtered_dataset) %/% 2

# Split the dataset into two halves
first_half <- filtered_dataset %>%
  slice(1:midpoint)

second_half <- your_dataset %>%
  slice((midpoint + 1):nrow(your_dataset))


# Extract the first 50 rows into a new dataset
new_dataset <- head(first_half, 150)


example_matrix_hahahah <- long_to_matrix(new_dataset,
                                 feature_id_col = 'PeptideModifiedSequence',
                                 measure_col = 'TotalAreaFragment',
                                 sample_id_col = 'ReplicateName')
head(example_matrix_hahahah)


log_transformed_matrix_hahaha <- log_transform_dm(example_matrix_hahahah,
                                           log_base = 2, offset = 1)

color_list <- sample_annotation_to_colors(example_sample_annotation,
                                          factor_columns = c('MS_batch', 'digestion_batch',
                                                             'EarTag', 'Strain',
                                                             'Diet', 'Sex'),
                                          numeric_columns = c('DateTime','order'))

feature_id_col = 'PeptideModifiedSequence'
measure_col = 'TotalAreaFragment'
sample_id_col = 'FullRunName'
essential_columns = c(feature_id_col, measure_col, sample_id_col)
batch_col = 'Batch'


plot_sample_mean(example_matrix_hahahah, example_sample_annotation_2, order_col = 'Order',
                 batch_col = batch_col, color_by_batch = TRUE, ylimits = c(0, 120000),
                 color_scheme = color_list_2[[batch_col]])

help('example_sample_annotation')

view(example_sample_annotation)

view(example_proteome)

colnames(example_sample_annotation_2) <- c("FullRunName", "Batch", "mouse", "Treatment", "Order")

example_sample_annotation_2

