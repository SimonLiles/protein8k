#'@name p53_tetramerization
#'@docType data
#'@aliases p53_tetramerization
#'@title P53 Tetramerization Domain Crystal Structure
#'
#'@description Formal class protein representing data from a PDB, code 1AIE, p53
#'  tetramerization Domain Crystal Structure. This is a small and simple R object
#'  of example data for users to play with and is used in example vignettes.
#'
#'@format A Protein S4 object. List comprised of several sublists and dataframes
#'\itemize{
#'  \item{header: }{List of 2, Header Line and Title \itemize{
#'    \item{header_line: }{List of 3, Classification, depDate, and idCode \itemize{
#'      \item{classifiation: }{Classification of the Protein in the PDB}
#'      \item{depDat: }{Date the PDB was deposited or created}
#'      \item{idCode: }{4 digit identifier for the PDB. Always unique.}
#'      }}
#'    \item{title: }{The title of the PDB.}
#'    }}
#'  \item{structure: }{Dataframe of 16 variables \enumerate{
#'    \item{record_type:}{Type of record in this section. Generally ATOM or HETATM}
#'    \item{serial_num: }{The serial number for the position of the atom in the sequence}
#'    \item{atom_name: }{A name to identify the atom in a structure}
#'    \item{alt_location_id: }{}
#'    \item{residue_name: }{3 character identifier for a residue}
#'    \item{chain_id: }{}
#'    \item{residue_seq_num: }{Number representing where in the sequence a residue is. }
#'    \item{insert_residue_code: }{}
#'    \item{x_ortho_coord: }{X coordinate in Ångstroms on an orthogonal plane}
#'    \item{y_ortho_coord: }{Y coordinate in Ångstroms on an orthogonal plane}
#'    \item{z_ortho_coord: }{Z coordinate in Ångstroms on an orthogonal plane}
#'    \item{occupancy: }{}
#'    \item{temp_factor: }{The amount of overall error in the measurement of an atom.}
#'    \item{segment_id: }{}
#'    \item{element_symbol: }{Periodic symbol representing an atom.}
#'    \item{charge: }{Charge of the given atom. Can be +, -, or none at all}
#'  }}
#'}
#'@keywords datasets
"p53_tetramerization"

#Uncomment these lines, run, then comment them out again to update the dataset.
#p53_tetramerization <- read.pdb("1aieH")
#usethis::use_data(p53_tetramerization)
