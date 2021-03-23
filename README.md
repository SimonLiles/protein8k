# protein8k
Author: Simon Liles

Maintainer: Simon Liles

This is a package that can be used for the visual analysis of proteins. 

This package is still in early Alpha, current version V0.0.9000. Expect significant and continuous changes for a while. 

This README will also be updated with more information as the package evolves. 

# How to use the package
Within this package there are many functions that allow for the creation of new Protein Objects, functions for inspecting the contents of the object, and dedicated functions for visualizing and modeling the protein. 

## `read.pdb(fileName, createAsS4 = TRUE)`
This function is used for the importing of Protein Data Bank files (PDB) into the R environment. After running this function it will create a new object of class Protein. The `fileName` argument is used to specify the file path from the working directory to the PDB file. The `createAsS4` argument can be used to indicate whether or not to create the new Protein object as S4 or S3. If you want an S3 object, set this argument to `FALSE`. 

This function relies of the PDB format, which is very specific. For more information on ther structure of these files see this [link](https://www.cgl.ucsf.edu/chimera/docs/UsersGuide/tutorials/pdbintro.html) which provides an overview. For more information see the World Wide Protein Data Bank website [here](https://www.wwpdb.org/documentation/file-format).

## `summary(protein)`


## `getStructure(protein)`


## `plotProtein3D(protein, animated = FALSE, groups = NULL)`



