# Load the LPmerge package for consensus map construction
library(LPmerge)

# Import mapping data from CSV files for different populations
HA <- read.csv("HA.csv")
HO <- read.csv("HO.csv")
MB <- read.csv("MB.csv")
MH <- read.csv("MH.csv")
OWBH <- read.csv("OWBH.csv")
SM1 <- read.csv("SM1.csv")

# Define names for the mapping datasets
map.names <- c("HA","HO","MB","OWBH","SM1","MH")

# Initialize a list to store chromosome-specific mapping data
Maps <- list()

# Loop through each dataset, read the data, and extract chromosome 4H information
for (i in 1:6) {
  filename <- paste(map.names[i], ".csv", sep = "")
  input <- read.csv(filename, header = TRUE, as.is = TRUE, check.names = FALSE)
  Maps[[i]] <- input[which(input$chr == "4H"), c(1, 3)]
}

# Name the list elements based on dataset names
names(Maps) <- map.names

# Display the structure of the Maps list to understand the data
str(Maps)

# Calculate and print the maximum linkage map lengths for chromosome 4H across datasets
print(link.map.lengths <- unlist(lapply(Maps, function(x) { max(x$cM) })))
mean(link.map.lengths)

# Construct an unweighted consensus linkage map
unweighted <- LPmerge(Maps, max.interval = 1:4)
head(unweighted[[2]])

# Define population sizes for weighted consensus map construction
pop.size <- c(54, 94, 93, 82, 92, 91)

# Construct a weighted consensus linkage map considering population sizes
weighted <- LPmerge(Maps, max.interval = 1:4, weights = pop.size)

