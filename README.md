# protein8k
V0.0.0.9000

Author: Simon Liles

Maintainer: Simon Liles

This is a package that can be used for the visual analysis of proteins. 

This package is still in early Alpha. Expect significant and continuous changes for a while.

This README will also be updated with more information as the package evolves. 

# Download and Installation
The easiest way to download and install this package into your R session is to use the devtool function `install_github()`.

You can copy and paste this code into your console and it should work. If there are any issues, please contact the package maintainer. 

```{r}
devtools::install_github("SimonLiles/protein8k")
```

# How to use the package
Within this package there are many functions that allow for the creation of new Protein Objects, functions for inspecting the contents of the object, and dedicated functions for visualizing and modeling the protein. 

Here a brief over view of the different functions included in this package are included. For more detailed explanation of these functions, see their respective help pages. 

## Reading in a new PDB file
### `read.pdb(fileName, createAsS4 = TRUE)`
This function is used for the importing of Protein Data Bank files (PDB) into the R environment. After running this function it will create a new object of class Protein. The `fileName` argument is used to specify the file path from the working directory to the PDB file. The `createAsS4` argument can be used to indicate whether or not to create the new Protein object as S4 or S3. If you want an S3 object, set this argument to `FALSE`. 

Currently the parsing is not complete, the returned object will contain only structure data, and a couple of lines from the header. More parsing of the header and remarks sections will be added in the future. 

This function relies of the PDB format, which is very specific. For more information on their structure of these files see this [link](https://www.cgl.ucsf.edu/chimera/docs/UsersGuide/tutorials/pdbintro.html) which provides an overview. For more information see the World Wide Protein Data Bank website [here](https://www.wwpdb.org/documentation/file-format).

## Getting a summary of the Protein Object
### `summary(protein)`
This function will print out a summary of PDB data. Currently this will return the object type, PDB ID Code, Deposition Date, Classification, Title, and the number of atomic Rows. Considering that read.pdb is still incomplete, this will likely include more information as `read.pdb()` is updated. 

For example, here is output for the PDB for P53 Tetramerization, imported as an S4 Protein Object:

```{plaintext}
S4 Object of class Protein
ID Code: 1AIE     Deposition Date: 1997-04-17 
Classification: P53 TETRAMERIZATION                      
Title: P53 TETRAMERIZATION DOMAIN CRYSTAL STRUCTURE 
Atomic Record Contains 590 rows
```

## Visualizing the Protein

### Creating 3D plots of the protein Atomic Record
#### `plotProtein3D(protein, animated = FALSE, groups = NULL)`
This function is still in development. More will be added later, the `groups` parameter is currently still unsupported. 

It is a wrapper function for plotting the protein structure in 3D using the lattice package. Setting `animated` to `TRUE` will create a short animation of the protein spinning. 

### Creating 2D Models of the Protein Atomic Record
#### `plotModels(protein, separate = FALSE)`
This function is still in development. Setting `separate` to `TRUE` is not currently supported. More features and support will be added in the future. 

Uses ggplot2 to create 3 plots of the atomic coordinates on the 3 orthogonal planes. It then generates a smoothing line using `geom_smooth()` to find patterns in the protein structure. Currently it will only plot all three in the same visualization. 

## Accessing parts of the Protein Objects

### Retrieve the Atomic Record of the Protein
#### `getAtomicRecord(protein)`
This will return the entire atomic record describing the structure of the protein as a data frame. It is recommended that this function is used instead of accessing the structure through slots or $ syntax because this function will work regardless of whether the Protein Object is S3 or S4. 

### Retrieve the Title Section from the Protein Object
#### `getTitleSection(protein)`
Retrieves the title section of a PDB file and returns it as a list of elements. Currently the title sections has the header line and title records. In the header line one can find Deposition Date, ID Code, and Classification. Function is compatible with Protein Objects of S3 and S4 types.
