#'plot3DInteractive
#'
#'Opens a viewer for exploratory and interactive analysis of a protein structure.
#'
#'@param protein Protein object to use in plotting
#'
#'@export Protein3D
#'

Protein3D <- function(protein) {
  #Create the UI
  ui <- shiny::fluidPage(
    shiny::sidebarLayout(
      #Sidebar panel to control the plot and additional actions
      shiny::sidebarPanel(
        #Set Z axis rotation
        shiny::sliderInput(inputId = "z_rot", label = "Rotate Z-Axis",
                           min = -360, max = 360, value = -30),
        #Set X axis rotation
        shiny::sliderInput(inputId = "x_rot", label = "Rotate X-Axis",
                           min = -360, max = 360, value = -60),
        #Set Y axis rotation
        shiny::sliderInput(inputId = "y_rot", label = "Rotate Y-Axis",
                           min = -360, max = 360, value = 0),
        #Set point type
        shiny::selectInput(inputId = "type", label = "Point Type",
                           choices = c("p", "l", "b", "h"), selected = "p"),
        #Set grouping variable
        shiny::selectInput(inputId = "group", label = "Grouping",
                           choices = c("NULL", "record_type","atom_name","residue_name",
                                       "residue_seq_num","temp_factor","element_symbol"),
                           selected = "NULL"),
        #Button to save the current view as an image
        shiny::actionButton(inputId = "save_image", label = "Save Image")
      ),
      #Holds the main plot
      shiny::mainPanel(shiny::plotOutput(outputId = "plot"))
    )
  )

  #Create the backend to generate the plot
  server <- function(input, output) {
    output$plot <- shiny::renderPlot({
      #If grouping input is set to NULL, do not assign that variable, else do assign
      if(input$group != "NULL") {
        plot3D(protein, type = input$type,
               groups = rlang::eval_tidy(rlang::parse_expr(input$group)),
               screen = list(z = input$z_rot, x = input$x_rot, y = input$y_rot),
               image_width = 1000, image_height = 1000)
      } else {
        plot3D(protein, type = input$type,
               screen = list(z = input$z_rot, x = input$x_rot, y = input$y_rot),
               image_width = 1000, image_height = 1000)
      }
    }
    )

    #If save_image button is pressed, save current view to working directory.
    shiny::observeEvent(input$save_image, {
      header <- getTitleSection(protein)
      #If grouping input is set to NULL, do not assign that variable, else do assign
      if(input$group != "NULL") {
        viz <- plot3D(protein, type = input$type,
                      groups = rlang::eval_tidy(rlang::parse_expr(input$group)),
                      screen = list(z = input$z_rot, x = input$x_rot, y = input$y_rot),
                      image_width = 1000, image_height = 1000)
      } else {
        viz <- plot3D(protein, type = input$type,
                      screen = list(z = input$z_rot, x = input$x_rot, y = input$y_rot),
                      image_width = 1000, image_height = 1000)
      }

      #Write the visual to the working directory
      write_viz(viz, path = header$header_line$idCode, format = "png")
    })
  }

  #Build and run the Shiny App
  shiny::runApp(shiny::shinyApp(ui = ui, server = server))
}
