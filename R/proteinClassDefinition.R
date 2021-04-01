#'@title Protein Class Definitions
#'
#'@aliases Protein-class
#'
#'@description Protein Class used to Define Protein Objects of S3 and S4 Types.
#'Currently still in development, Integrity checks still need to be added.

#S4 Protein Class Declaration ##################################################
setClass("Protein", representation(
  header = "list",
  structure = "data.frame")
)

#S3 Protein Class Constructor ##################################################
Protein <- function(hdr, prtn_strct) {
  #Integrity checks go here:

  #Put it all together
  newProteinObject <- list(header = hdr,
                           structure = prtn_strct)
  class(newProteinObject) <- "Protein"

  #Return the new object value
  return(newProteinObject)
}

