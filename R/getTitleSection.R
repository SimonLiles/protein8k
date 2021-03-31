#'getTitleSection
#'
#'@description Retrieve the title section from a Protein Object
#'
#'@param protein input for a a protein object
#'
#'@details This is an accessor function for retrieving the title section from a
#'  Protein object.
#'
#'@returns Returns a list containing elements from the title section.
#'
#'@export getTitleSection

getTitleSection <- function(protein) {
  #Return title section from an S4 Protein object
  if(pryr::otype(protein) == "S4") {
    return(protein@header)
  }

  #Return title section from an S3 Protein object
  if(pryr::otype(protein) == "S3") {
    return(protein$header)
  }
}
