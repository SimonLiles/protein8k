#' image_write
#'
#' Wrapper function for writing images to the disk. This function comes from the
#' magick package under the same name.
#'
#' @param image magick image object.
#' @param path a file, url, or raster object or bitmap array
#' @param format output format such as "png", "jpeg", "gif", "rgb" or "rgba".
#' @param quality number between 0 and 100 for jpeg quality. Defaults to 75.
#' @param depth color depth (either 8 or 16)
#' @param density resolution to render pdf or svg
#' @param comment text string added to the image metadata for supported formats.
#' @param flatten should image be flattened before writing? This also replaces transparency with background color.
#' @param defines a named character vector with extra options to control reading. These are the  -define key{=value} settings in the command line tool. Use an empty string for value-less defines, and NA to unset a define.
#'
#'
#'@export image_write

image_write <- function(image, path = NULL, format = NULL, quality = NULL,
                        depth = NULL, density = NULL, comment = NULL,
                        flatten = FALSE, defines = NULL) {

  magick::image_write(image, path, format, quality, depth, density, comment,
                      flatten, defines)
}
