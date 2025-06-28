library("Seurat")
library("ShinyCell2")

input_folder <- Sys.getenv("SHINY_INPUT_DIR")
output_folder <- Sys.getenv("SHINY_OUTPUT_DIR")




# run app
out <- shiny::runApp(shinycell2, launch.browser = FALSE, port = 3838, host = "0.0.0.0")

