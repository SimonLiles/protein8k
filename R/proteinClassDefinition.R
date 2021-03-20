#'Protein Class Definitions
#'Is used to Define Protein Objects of S3 and S4 Types

#* ProteinClass ALPHA V0.0.01 13.03.2021
#*
#* Author: Simon Liles
#*
#* About:
#* This file contains the current build for the protein class
#* Class is designed to be handled as S3 or as S4 type object
#* *#

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

