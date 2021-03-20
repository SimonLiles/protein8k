#'@title Protein Class Definitions
#'@description Protein Class used to Define Protein Objects of S3 and S4 Types.
#'Currently still in development, Integrity checks still need to be added.

#S4 Protein Class Declaration ##################################################
setClass("Protein", representation(
  structure = "data.frame",
  header = "list")
)

#S3 Protein Class Constructor ##################################################
Protein <- function(prtn_strct, hdr) {
  #Integrity checks go here:

  #Put it all together
  newProteinObject <- list(structure = prtn_strct,
                          header = hdr)
  class(newProteinObject) <- "Protein"

  #Return the new object value
  return(newProteinObject)
}

