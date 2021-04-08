#'fromJSONL
#'
#'Decode a JSON List into an R List Object.
#'
#'@usage fromJSONL(filepath)
#'
#'@param filepath A character string indicating the filepath from the working
#'    directory to the desired file.
#'
#'@returns a large list, each element containg the contents of a JSON file after
#'    being converted.
#'
#'@export fromJSONL

fromJSONL <- function(filepath) {
  #Status message regarding process
  cat("Reading in JSONL data\n")

  #Read each line from the json file
  file_v <- readLines(filepath)

  #Create an empty list to store new elements
  report <- list()

  #Set Counter
  counter <- 1
  for(element in file_v) {
    #Progress report for very large data sets
    prcnt_prgrs <- (counter / length(file_v)) * 100
    cat(sprintf("Progress: %.2f%% \r", prcnt_prgrs))

    report[[length(report) + 1]] <- rjson::fromJSON(element)

    counter <- counter + 1
  }

  #Inform that process is complete
  cat("\nFinished reading JSONL data\n\n")

  return(report)
}
