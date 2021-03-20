#'plotProtein3D
#'

#Create a 3d plot of the protein
plotProtein3D <- function(protein, animated = FALSE, groups = NULL) {

  #Retrieve protein structure for plotting
  structure <- getStructure(protein)

  #Animate the plot by spinning
  if(animated == TRUE) {
    #Create a series of .png images
    png(file="plot%03d.png", width=480, height=480)
    for (i in seq(0, 350 ,10)){
      print(lattice::cloud(z_ortho_coord ~ x_ortho_coord * y_ortho_coord, data = structure,
                           screen = list(z = i, x = -60), groups = residue_name))
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
    lattice::cloud(z_ortho_coord ~ x_ortho_coord * y_ortho_coord, data = structure, groups = groups)
  }
}
