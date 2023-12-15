##supplementary code during the work 


library(tidyr)

# Example long data frame
long_data <- data.frame(
  ID = rep(1:3, each = 2),
  Feature = rep(c("A", "B"), times = 3),
  TotalAreaFragment = c(10, 20, 30, 40, 50, 60),
  OtherColumn1 = c(1, 2, 3, 4, 5, 6),
  OtherColumn2 = c("X", "Y", "Z", "W", "U", "V")
)

# Spread the data to create a wide matrix using 'TotalAreaFragment' as values
wide_matrix <- spread(filtered_dataset_2, key = ReplicateName, value = TotalAreaFragment)

# Print the wide matrix
print(wide_matrix)
dim(wide_matrix)



# Assuming 'long_data' is your long data frame
library(tidyr)

# Example long data frame
long_data <- data.frame(
  ID = rep(1:3, each = 2),
  Feature = rep(c("A", "B"), times = 3),
  TotalAreaFragment = c(10, 20, 30, 40, 50, 60),
  OtherColumn1 = c(1, 2, 3, 4, 5, 6),
  OtherColumn2 = c("X", "Y", "Z", "W", "U", "V")
)

# Spread the data to create a wide matrix using 'TotalAreaFragment' as values
wide_matrix <- spread(long_data, key = Feature, value = TotalAreaFragment)

# Print the wide matrix
print(wide_matrix)
print(long_data)












# Set a seed for reproducibility
set.seed(42)

# Number of rows in the dataframe
num_rows <- 10000

# Generate random ReplicateName (character)
replicate_names <- sample(letters, num_rows, replace = TRUE)

# Generate random TotalAreaFragment (numeric)
total_area <- runif(num_rows, min = 0, max = 1000)

# Generate random PeptideModifiedSequence (character)
peptide_sequence <- replicate(num_rows, paste0(sample(LETTERS, size = 5, replace = TRUE), collapse = ""))

# Create the dataframe
random_dataframe <- data.frame(
  ReplicateName = replicate_names,
  TotalAreaFragment = total_area,
  PeptideModifiedSequence = peptide_sequence
)

# Display the first few rows of the dataframe
head(random_dataframe)
view(random_dataframe)

# Extract the first 10000 rows of 'PeptideModifiedSequence' column
peptide_sequence_subset <- filtered_dataset_2$PeptideModifiedSequence[1:10000]

# Add the extracted column to the 'haha' dataset
random_dataframe <- cbind(random_dataframe, PeptideModifiedSequence = peptide_sequence_subset)

random_dataframe <- subset(random_dataframe, select = -PeptideModifiedSequence)
random_dataframe <- random_dataframe %>%
  rename(PeptideModifiedSequence = PeptideModifiedSequence.1)


####
#####
####
# Assuming 'your_dataset' is your dataset
random_dataframe <- data.frame(ExistingColumn = rnorm(236 * 40))  # Example data, replace with your actual data

# Create a vector with 236 unique characters each repeated 40 times
unique_characters <- rep(letters, each = 40)

# Add a new column to the dataset with the unique character pattern
random_dataframe$NewColumn <- rep(unique_characters, length.out = nrow(random_dataframe))

# Display the first few rows of the updated dataset
head(your_dataset)




# Assuming 'your_dataset' is your dataset
random_dataframe$NewColumn <- rep(rep(letters, each = 40), length.out = nrow(random_dataframe))
dim(random_dataframe)

# Extract the first 10000 rows of 'PeptideModifiedSequence' column
peptide_sequence_subset <- filtered_dataset_2$ReplicateName[1:10000]

# Add the extracted column to the 'haha' dataset
random_dataframe <- cbind(random_dataframe, ReplicateName = peptide_sequence_subset)

random_dataframe <- subset(random_dataframe, select = -PeptideModifiedSequence)
random_dataframe <- random_dataframe %>%
  rename(PeptideModifiedSequence = PeptideModifiedSequence.1)



# Assuming 'your_dataframe' is your dataframe
random_dataframe <- random_dataframe[, -1]



