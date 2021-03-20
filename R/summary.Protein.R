#' summary.protein
#'

#Summarize the object data
summary.Protein <- function(protein) {
  #Break protein object down for simpler decoding and summary

  #Break down from S4
  if(pryr::otype(protein) == "S4") {
    structure <- protein@structure
    header <- protein@header
    cat("S4 Object of class Protein\n")
  }

  #Break down from S#
  if(pryr::otype(protein) == "S3") {
    structure <- protein$structure
    header <- protein$header
    cat("S3 Object of class Protein\n")
  }

  #Print summary
  cat("ID Code:", header$header_line$idCode,
      "    Deposition Date:", as.character(header$header_line$depDate), "\n")
  cat("Classification:", header$header_line$classification, "\n")
  cat("Title:", header$title, "\n")
  cat("Atomic Record Contains", nrow(structure), "rows\n")

}

#Implement as S4 generic
setMethod("summary", "Protein", summary.Protein)

#Implement as S3 generic
UseMethod("summary", "Protein")
