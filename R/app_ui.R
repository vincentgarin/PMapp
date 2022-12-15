#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    fluidPage(
      titlePanel("Pearl millet agronomy and crop model prediction in India"),

      tags$img(height = 300, width = 300, src = 'www/hex-PMapp.png'),
      tags$img(height = 300, width = 500, src = 'www/PM_field_1.jpg'),
      tags$br(),
      tags$br(),

      # General area
      mod_par_gen_ui("par_gen_area")

    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "PMapp"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
