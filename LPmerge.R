# Load the LPmerge package for consensus map construction
library(LPmerge)

# Import mapping data from CSV files for different populations
ha <- read.csv("HA.csv")
ho <- read.csv("HO.csv")
mb <- read.csv("MB.csv")
mh <- read.csv("MH.csv")
owbh <- read.csv("OWBH.csv")
sm1 <- read.csv("SM1.csv")

# Define names for the mapping datasets
map_names <- c("HA", "HO", "MB", "OWBH", "SM1", "MH")

# Initialize a list to store chromosome-specific mapping data
maps <- list()

# Loop through each dataset, read the data, and extract chromosome 4H
# information
for (i in 1:6) {
  filename <- paste(map_names[i], ".csv", sep = "")
  input <- read.csv(filename,
    header = TRUE, as.is = TRUE,
    check.names = FALSE
  )
  maps[[i]] <- input[which(input$chr == "4H"), c(1, 3)]
}

# Name the list elements based on dataset names
names(maps) <- map_names

# Display the structure of the maps list to understand the data
str(maps)

# Calculate and print the maximum linkage map lengths for chromosome 4H
# across datasets
print(link_map_lengths <- unlist(lapply(maps, function(x) {
  max(x$cM)
})))
mean(link_map_lengths)

# Construct an unweighted consensus linkage map
unweighted <- LPmerge(maps, max.interval = 1:4)
head(unweighted[[2]])

# Define population sizes for weighted consensus map construction
pop_size <- c(54, 94, 93, 82, 92, 91)

# Construct a weighted consensus linkage map considering population sizes
weighted <- LPmerge(maps, max.interval = 1:4, weights = pop_size)
