#' write_viz
#'
#' Wrapper function for writing images to the disk. This function comes from the
#' magick package under the same name.
#'
#' @param image magick image object or trellis object.
#' @param path a file path starting from the working directory
#' @param format file type to save the image as. Can be "png", "jpeg", "gif", "rgb",
#'   or "rgba".
#'
#'@export write_viz

write_viz <- function(image, path = "my_image", format = "png") {
  #need to add a check for format parameter

  #If it is a trellis object, save it using regular methods
  if(class(image) == "trellis") {
    lattice::trellis.device(device = format,
                            filename = paste(getwd(), "/", path, ".", format, sep = ""))
    print(image)
    dev.off()
  }

  #If it is a magick object, save it using magick image_write function
  if(class(image) == "magick-image") {
    magick::image_write(image, paste(path, ".", format, sep = ""), format)
  }
}
