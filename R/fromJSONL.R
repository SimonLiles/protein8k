#'fromJSONL
#'
#'Decode a JSON List into an R List Object.
#'
#'@param filepath A character string indicating the filepath from the working
#'    directory to the desired file.
#'
#'@param maxLines An integer representing the max number of lines to read. Negative
#'    values indicate that one should read up to the end of input on the connection.
#'
#'@returns a large list, each element containg the contents of a JSON file after
#'    being converted.
#'
#'@export fromJSONL

fromJSONL <- function(filepath, maxLines = -1) {
  #Status message regarding process
  message("Reading in JSONL data\n", appendLF = FALSE)

  #Read each line from the json file
  file_v <- readLines(filepath, n = maxLines)

  #Create an empty list to store new elements
  report <- list()

  #Set Counter
  counter <- 1
  for(element in file_v) {
    #Progress report for very large data sets
    prcnt_prgrs <- (counter / length(file_v)) * 100
    message(sprintf("Progress: %.2f%% \r", prcnt_prgrs), appendLF = FALSE)

    report[[length(report) + 1]] <- rjson::fromJSON(element)

    counter <- counter + 1
  }

  #Inform that process is complete
  message("\nFinished reading JSONL data\n\n")

  return(report)
}
