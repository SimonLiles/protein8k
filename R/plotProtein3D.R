#'plot3D
#'
#'@description plot the protein structure in 3D
#'
#'@param protein Protein object to be plotted
#'@param animated logical indicating whether the object is to be animated in the
#'  viewer. Will spin on the Z axis.
#'@param type character indicating the type of cloud plot.
#'@param groups indicate which groups to color. Pass the name of the column from
#'  the Atomic Coordinate section, and it will color the points.
#'@param screen list of x, y, and z angles to orientate the plot.
#'
#'@details This function uses lattice and magick to create the 3D plot and animate
#'  it.
#'
#'@details Currently this function is incomplete and will change dramatically as
#'  new features and documentation are added.
#'
#'@returns An object to be plotted. If not assigned to a variable, it will plot
#'  directly in the viewer.
#'
#'@export plot3D
#'@import grDevices

#Create a 3d plot of the protein
plot3D <- function(protein, animated = FALSE, type = "p", groups = NULL,
                   screen = list(x = -60, z = 0, y = 0)) {

  #Retrieve protein structure for plotting
  structure <- getAtomicRecord(protein)

  #Animate the plot by spinning
  if(animated == TRUE) {
    #Create a series of .png images
    png(filename = "plot%03d.png", width = 480, height = 480)
    for (i in seq(0, 350 ,10)){
      print(lattice::cloud(z_ortho_coord ~ x_ortho_coord * y_ortho_coord, data = structure,
                           type = type,
                           groups = rlang::enquo(groups),
                           screen = list(z = i, x = screen$x, y = screen$y)))
    }
    dev.off()

    #Read the .png images into a vector
    img <- magick::image_read("plot001.png")
    for (i in 1:36) {
      frameFileName <- sprintf("plot%03d.png", i)
      nextFrame <- magick::image_read(frameFileName)
      img <- c(img, nextFrame)
    }

    #Create the animation
    animation <- magick::image_animate(img, fps = 10)

    #Clean up the workspace
    file.remove(list.files(pattern=".png"))

    return(animation)

  } else {
    #If animated is FALSE, create static 3d plot
    lattice::cloud(z_ortho_coord ~ x_ortho_coord * y_ortho_coord, data = structure,
                   type = type,
                   groups = rlang::enquo(groups),
                   screen = screen)
  }
}
