#'summary.Protein
#'
#'@method summary Protein
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
#'@returns Does not return a value.
#'
#'@export summary.Protein
#'@exportMethod summary
#'@rawNamespace S3method(summary, Protein)


#Summarize the object data
summary.Protein <- function(object, ...) {
  #UseMethod("summary", "Protein")

  #Break protein object down for simpler decoding and summary

  #Break down from S4
  if(pryr::otype(object) == "S4") {
    structure <- object@structure
    header <- object@header
    cat("S4 Object of class Protein\n")
  }

  #Break down from S3
  if(pryr::otype(object) == "S3") {
    structure <- object$structure
    header <- object$header
    cat("S3 Object of class Protein\n")
  }

  #Print summary
  cat("ID Code:", header$header_line$idCode,
      "    Deposition Date:", as.character(header$header_line$depDate), "\n")
  cat("Classification:", header$header_line$classification, "\n")
  cat("Title:", header$title, "\n")
  cat("Atomic Record Contains", nrow(structure), "rows\n")

}

#Implement as S3 generic
UseMethod("summary", "Protein")
