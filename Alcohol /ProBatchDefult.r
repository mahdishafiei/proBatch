feature_id_col = 'peptide_group_label'
measure_col = 'Intensity'
sample_id_col = 'FullRunName'
essential_columns = c(feature_id_col, measure_col, sample_id_col)
technical_factors = c('MS_batch', 'digestion_batch')
biological_factors = c('Strain', 'Diet', 'Sex')
biospecimen_id_col = 'EarTag'
batch_col = 'MS_batch'
View(example_proteome)
example_matrix <- long_to_matrix(example_proteome,
                                 feature_id_col = 'peptide_group_label',
                                 measure_col = 'Intensity',
                                 sample_id_col = 'FullRunName')


log_transformed_matrix <- log_transform_dm(example_matrix,
                                           log_base = 2, offset = 1)
View(example_sample_annotation)
color_list <- sample_annotation_to_colors(example_sample_annotation,
                                          factor_columns = c('MS_batch', 'digestion_batch',
                                                             'EarTag', 'Strain',
                                                             'Diet', 'Sex'),
                                          numeric_columns = c('DateTime','order'))

plot_sample_mean(log_transformed_matrix, example_sample_annotation, order_col = 'order',
                 batch_col = batch_col, color_by_batch = TRUE, ylimits = c(12, 16.5),
                 color_scheme = color_list[[batch_col]])

#other stff for training not related to defualt code


help("long_to_matrix")
view(exam)
view(example_sample_annotation)
# Assuming 'example_proteome' is your dataset
unique_fullrunnames <- unique(example_proteome$FullRunName)

# Calculate the number of unique items
num_unique_items <- length(unique_fullrunnames)

# Print the result
cat("The 'fullrunname' column has", num_unique_items, "unique items.\n")

hahaha <- rbind(input_file_amg, input_file_amg_B8)
dim(hahaha)
browseVignettes(package = "proBatch")


