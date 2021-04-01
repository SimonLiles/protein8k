#'summary.Protein
#'
#'@aliases summary,Protein-method
#'@usage \S4method{summary}{Protein}(object)
#'@aliases summary,Protein,ANY-method
#'@usage \S4method{summary}{Protein,ANY}(object,\dots)
#'@export summary
#'@rdname Protein-summary
#'
#'@param object A Protein object of either S3 or S4 type.
#'@param ... other objects passed to `summary()`. Currently not supported.
#'
#'@details Prints a description of the protein object to the console. The lines
#'    of out put are as follows.
#'    \enumerate{
#'    \item Prints if it is S3 or S4 object type.
#'    \item ID Code of the PDB and the Data it was deposited in the Data Bank.
#'    \item The Classification of the protein.
#'    \item The title of the PDB.
#'    \item The number of rows in the Atomic Record.
#'    }
#'
#'@exportMethod summary

#Implement as S4 generic
setGeneric("summary", valueClass = c("Protein"))
setMethod("summary", signature(object = "Protein"), function(object){
  summary.Protein(object = object)
})
