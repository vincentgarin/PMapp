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

      navlistPanel(
        "Description",

      #### App description ####

        tabPanel("Content",

             'This app provides interactive statistics and crop model predictions
             about pearl millet production in India.',

                 tags$br(),
                 tags$br(),

             'All data are related to Kharif (rainy) season (June-September) for a
             selection of 62 districts representing 90% of the total cultivated area over the period 1998-2017.',

                 tags$br(),
                 tags$br(),

             'It uses data from the ICRISAT district level data (DLD) database',
              tags$a('ICRISAT DLD', href = 'http://data.icrisat.org/dld/'),

              'The crop model predictions were calculated using the APSIM software',

               tags$a('APSIM', href = 'https://www.apsim.info/'),

               tags$br(),
               tags$br(),
               tags$strong('The app is distributed with absolutely no warranty.'),
               tags$br(),
               tags$br(),

      tags$img(height = 300, width = 300, src = 'www/hex-PMapp.png'),
      tags$img(height = 300, width = 500, src = 'www/PM_field_1.jpg'),
      tags$br(),
      tags$br(),

      'Copyright - Vincent Garin - ICRISAT GEMS team'

        ),
      "General",
      tabPanel("Area",

      #### General-area ####
      mod_par_gen_ui("par_gen_area")

      ),
      tabPanel("Production",

      #### General-production ####
      mod_par_gen_ui("par_gen_prod", par_nm = 'production', unit_nm = 'tons')

               )
      ) # end of the last tabPanel and navlistPanel

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
