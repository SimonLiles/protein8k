#'fromJSONL
#'
#'@param filepath A character string indicating the filepath from the working
#'    directory to the desired file.
#'
#'@returns a large list, each element containg the contents of a JSON file after
#'    being converted.
#'
#'@export fromJSONL

fromJSONL <- function(filepath) {
  #Read each line from the json file
  json_list <- readLines(filepath)

  #Convert each line into a list element using fromJSON
  json_list <- lapply(json_list, rjson::fromJSON)

  return(json_list)
}
