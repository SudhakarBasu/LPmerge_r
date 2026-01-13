# LPmerge: Consensus Linkage Map Construction

A comprehensive R script for constructing consensus linkage maps from multiple genetic mapping populations using the LPmerge package. This project focuses on chromosome 4H analysis across six barley mapping populations.

## Overview

This project uses the LPmerge package to integrate genetic mapping data from multiple populations into a unified consensus linkage map. The approach allows for both weighted and unweighted consensus map construction, providing flexibility in how different population sizes are considered.

## Features

- **Multi-population integration**: Combines data from 6 different mapping populations (HA, HO, MB, MH, OWBH, SM1)
- **Chromosome-specific analysis**: Focuses on chromosome 4H
- **Dual consensus approaches**:
  - Unweighted consensus map
  - Weighted consensus map (accounting for population sizes)
- **Statistical summaries**: Calculates and displays linkage map lengths across populations

## Requirements

### R Version
- R >= 3.5.0 (recommended)

### Required Packages
```r
install.packages("LPmerge")
```

## Input Data Format

The script expects CSV files for each mapping population with the following structure:

- **Column 1**: `marker` - Marker name
- **Column 2**: `chr` - Chromosome identifier (e.g., "4H")
- **Column 3**: `cM` - Genetic distance in centiMorgans
- **Remaining columns**: Genotype calls for individual samples (coded as A/B or a/b)

### Example CSV Structure
```
marker,chr,cM,Sample1,Sample2,Sample3,...
2_0502,1H,0,a,b,b,...
1_0460,1H,0,A,B,B,...
2_0145,4H,0,A,A,B,...
```

## Usage

### Basic Execution

1. Place your CSV files in the same directory as `LPmerge.R`:
   - `HA.csv`
   - `HO.csv`
   - `MB.csv`
   - `MH.csv`
   - `OWBH.csv`
   - `SM1.csv`

2. Run the script in R:
```r
source("LPmerge.R")
```

### Script Workflow

The script performs the following steps:

1. **Load Package**: Imports the LPmerge library
2. **Data Import**: Reads all six CSV files
3. **Data Extraction**: Filters chromosome 4H data from each population
4. **Statistical Analysis**: Calculates maximum linkage map lengths
5. **Unweighted Consensus**: Creates consensus map without population weighting
6. **Weighted Consensus**: Creates consensus map weighted by population sizes

### Population Sizes

The script uses the following population sizes for weighted analysis:
- HA: 54 individuals
- HO: 94 individuals
- MB: 93 individuals
- OWBH: 82 individuals
- SM1: 92 individuals
- MH: 91 individuals

## Output

### Console Output
- Structure of the Maps list
- Maximum linkage map lengths for each population
- Mean linkage map length
- Preview of unweighted consensus map (first 6 rows)

### Variables Created
- `Maps`: List containing chromosome 4H data for all populations
- `unweighted`: Unweighted consensus linkage map
- `weighted`: Weighted consensus linkage map

## Customization

### Analyzing Different Chromosomes

To analyze a different chromosome, modify line 22:
```r
# Change "4H" to your target chromosome
Maps[[i]] <- input[which(input$chr == "4H"), c(1, 3)]
```

### Adjusting Max Interval Parameter

The `max.interval` parameter controls the maximum interval size. Modify lines 36 and 43:
```r
# Current setting tests intervals 1-4
unweighted <- LPmerge(Maps, max.interval = 1:4)
weighted <- LPmerge(Maps, max.interval = 1:4, weights = pop.size)
```

### Adding More Populations

To include additional populations:

1. Add the CSV file to the directory
2. Update the `map.names` vector (line 13)
3. Update the loop range (line 19)
4. Add the population size to `pop.size` vector (line 40)

## Project Structure

```
LPmerge/
├── LPmerge.R           # Main analysis script
├── HA.csv              # HA population data
├── HO.csv              # HO population data
├── MB.csv              # MB population data
├── MH.csv              # MH population data
├── OWBH.csv            # OWBH population data
├── SM1.csv             # SM1 population data
├── consensus.xlsx      # Output consensus map (if generated)
└── README.md           # This file
```

## References

### LPmerge Package
- **Citation**: Endelman, J.B. and Plomion, C. (2014). LPmerge: An R package for merging genetic maps by linear programming. *Bioinformatics*, 30(11), 1623-1624.
- **CRAN**: https://CRAN.R-project.org/package=LPmerge

## Troubleshooting

### Common Issues

**Error: "cannot open file 'XX.csv'"**
- Ensure all CSV files are in the same directory as the R script
- Check file names match exactly (case-sensitive)

**Error: "object 'LPmerge' not found"**
- Install the LPmerge package: `install.packages("LPmerge")`

**Warning: "NAs introduced by coercion"**
- Check that genetic distances (cM column) are numeric
- Verify genotype data is properly formatted

## License

This project is provided as-is for research and educational purposes.

## Contact

For questions or issues, please open an issue on the GitHub repository.

---

**Last Updated**: January 2026
