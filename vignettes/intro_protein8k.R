## ----eval = TRUE, echo = FALSE------------------------------------------------
library(protein8k)
my_Protein <- p53_tetramerization

## ----eval = FALSE-------------------------------------------------------------
#  my_protein <- read.pdb("myProtein.pdb")

## ---- message=FALSE-----------------------------------------------------------
summary(p53_tetramerization)

## -----------------------------------------------------------------------------
#Simple call to plot3D with p53_tetramerization data
plot3D(p53_tetramerization)

## -----------------------------------------------------------------------------
#Animate the protein structure spinning
#plot3D(p53_tetramerization, animated = TRUE)

## ----message=FALSE,error=FALSE,warning=FALSE----------------------------------
#Generate a model of each plane of the protein structure
plotModels(p53_tetramerization)

