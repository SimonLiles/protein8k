#'plotModels
#'
#'Create a plot of each plane and model the shape of the protein.
#'
#'@description plot models of the protein structure using ggplot.
#'
#'@param protein Protein object to be plotted
#'@param separate indicate wether to plot each plane separately or as one visual.
#'
#'@details This function uses ggplot and grid to create 3 plots, one for each plane,
#'  of the protein model, and then create a smoothing model.
#'
#'@details Currently this function is incomplete and will change dramatically as
#'  new features and documentation are added.
#'
#'@returns An object to be plotted. If not assigned to a variable, it will plot
#'  directly in the viewer.
#'
#'@export plotModels

plotModels <- function(protein, separate = FALSE) {
  #Retrieve atomic record for plotting
  atom_rcrd <- getAtomicRecord(protein)

  #Make the 3 plots
  #XY plot
  xy_plot <- ggplot2::ggplot(atom_rcrd, ggplot2::aes(atom_rcrd$x_ortho_coord,
                                                     atom_rcrd$y_ortho_coord,
                                            color = atom_rcrd$z_ortho_coord)) +
    ggplot2::geom_point() +
    ggplot2::geom_smooth(color = "red") +
    ggplot2::labs(x = "X-Axis", y = "Y-Axis")

  #XZ plot
  xz_plot <- ggplot2::ggplot(atom_rcrd, ggplot2::aes(atom_rcrd$x_ortho_coord,
                                                     atom_rcrd$z_ortho_coord,
                                            color = atom_rcrd$y_ortho_coord)) +
    ggplot2::geom_point() +
    ggplot2::geom_smooth(color = "red") +
    ggplot2::labs(x = "X-Axis", y = "Z-Axis")

  #YZ plot
  yz_plot <- ggplot2::ggplot(atom_rcrd, ggplot2::aes(atom_rcrd$y_ortho_coord,
                                                     atom_rcrd$z_ortho_coord,
                                            color = atom_rcrd$x_ortho_coord)) +
    ggplot2::geom_point() +
    ggplot2::geom_smooth(color = "red") +
    ggplot2::labs(x = "Y-Axis", y = "Z-Axis")

  #If plotting as one, make single visual with all 3 plots
  if(separate == FALSE) {
    #Clean the plots up for arragning in grid
    xy_plot <- xy_plot + ggplot2::theme(legend.position = "none")
    xz_plot <- xz_plot + ggplot2::theme(legend.position = "none")
    yz_plot <- yz_plot + ggplot2::theme(legend.position = "none")

    #Create text grob to hold protein name and ID code
    header <- getTitleSection(protein)
    title_text <- paste("PDB: ", header$header_line$idCode)
    titleGrob <- grid::textGrob(title_text)

    #Put it all together
    gridExtra::grid.arrange(xy_plot, yz_plot, xz_plot, titleGrob, ncol = 2)
  }

  #If plotting individually, have user press enter key to plot
  if(separate == TRUE) {
    cat("plotModels(separate = TRUE) is currently not supported")
  }
}
