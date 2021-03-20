#' summary.protein
#'

#Summarize the object data
summary.Protein <- function(object) {
  #UseMethod("summary", "Protein")

  #Break protein object down for simpler decoding and summary

  #Break down from S4
  if(pryr::otype(object) == "S4") {
    structure <- object@structure
    header <- object@header
    cat("S4 Object of class Protein\n")
  }

  #Break down from S#
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

#Implement as S4 generic
setGeneric("summary", valueClass = "Protein")
setMethod("summary", signature(object = "Protein"), function(object){
  summary.Protein(object = object)
})

#Implement as S3 generic
UseMethod("summary", "Protein")
