#'getAtomicRecord
#'
#'@description Retrieve the Atomic Record from a Protein Object
#'
#'@param protein input for a a protein object
#'
#'@details This is an accessor function for retrieving the Atomic Record from a
#'  Protein object.
#'
#'@returns Returns a dataframe containing the atomic record. There are 16 variables
#'  in this data frame.
#'
#'@format Dataframe with 16 columns:
#'\enumerate{
#'  \item{record_type:}{Type of record in this section. Generally ATOM or HETATM}
#'  \item{serial_num: }{The serial number for the position of the atom in the sequence}
#'  \item{atom_name: }{A name to identify the atom in a structure}
#'  \item{alt_location_id: }{}
#'  \item{residue_name: }{3 character identifier for a residue}
#'  \item{chain_id: }{}
#'  \item{residue_seq_num: }{Number representing where in the sequence a residue is. }
#'  \item{insert_residue_code: }{}
#'  \item{x_ortho_coord: }{X coordinate in Ångstroms on an orthogonal plane}
#'  \item{y_ortho_coord: }{Y coordinate in Ångstroms on an orthogonal plane}
#'  \item{z_ortho_coord: }{Z coordinate in Ångstroms on an orthogonal plane}
#'  \item{occupancy: }{}
#'  \item{temp_factor: }{The amount of overall error in the measurement of an atom.}
#'  \item{segment_id: }{}
#'  \item{element_symbol: }{Periodic symbol representing an atom.}
#'  \item{charge: }{Charge of the given atom. Can be +, -, or none at all}
#'}
#'
#'@export getAtomicRecord

#Get protein Structure
getAtomicRecord <- function(protein) {
  #Return structure from an S4 Protein object
  if(pryr::otype(protein) == "S4") {
    return(protein@structure)
  }

  #Return structure from an S3 Protein object
  if(pryr::otype(protein) == "S3") {
    return(protein$structure)
  }
}
