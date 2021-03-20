#'getStructure
#'
#'Retrieves Protein Structure from Protein Object
#'
#'@param protein input for a a protein object

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
