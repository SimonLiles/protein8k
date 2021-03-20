#'getStructure
#'
#'@description Retrieve the Atomic Record from a Protein Object
#'
#'@param protein input for a a protein object
#'
#'@details This is an accessor function for retrieving the Atomic Record from a
#'  Protein object.
#'
#'@returns Returns a dataframe containing the atomic record. There are 15 variables
#'  in this data frame.
#'
#'@export getStructure

#Get protein Structure
getStructure <- function(protein) {
  #Return structure from an S4 Protein object
  if(pryr::otype(protein) == "S4") {
    return(protein@structure)
  }

  #Return structure from an S3 Protein object
  if(pryr::otype(protein) == "S3") {
    return(protein$structure)
  }
}
