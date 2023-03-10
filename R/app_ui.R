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
        "General description",

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

               'For the crop model prediction part, please downoload the version of application available on githut to be used on your own machine (offline)',
              tags$a('Github', href = 'https://github.com/vincentgarin/PMapp'),

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

      #### General-area ####
      tabPanel("Area",

      mod_par_gen_ui("par_gen_area")

      ),
      #### General-production ####
      tabPanel("Production",

      mod_par_gen_ui("par_gen_prod", par_nm = 'production', unit_nm = 'tons')

               ),
      #### General-production ####
      tabPanel("Yield",
                mod_par_yield_ui("par_yield")
      ),
      ##### Area share #####
      "Comparison other crops",
      tabPanel("Area share",
               mod_par_share_ui("par_share_area")
               ),
      #### Production share ####
      tabPanel("Production share",
               mod_par_share_ui("par_share_prod", par_nm = 'production')
      ),
      #### Yield competitors ####
      tabPanel("Yield vs competitors",
               mod_comp_yield_ui("comp_yield")
      ),
      #### Area competitors ####
      tabPanel("Area trend competitors",
               mod_par_comp_ui("par_comp_area")
               ),
      #### Production competitors ####
      tabPanel("Production trend competitors",
               mod_par_comp_ui("par_comp_prod")
      ),
      #### Soil type ####
      "Environment",
      tabPanel("Soil type",
               mod_soil_type_ui("soil_type")
      ),
      tabPanel("Rain pattern",
               mod_rain_pattern_ui("rain_pattern")
      ),
      #### Mgt practice - irrigation ####
      "Management practices",
      tabPanel("Irrigation",
               mod_mgt_param_ui("mgt_param_irrig")
      ),
      #### Mgt practice - fertilisation ####
      tabPanel("Fertilisation",
               mod_mgt_param_ui("mgt_param_fert", var_title = 'kharif surface N fertilization (all crops).')
      ),
      #### Economics - price ####
      "Economics",
      tabPanel("Price",
               mod_mgt_param_ui("mgt_param_price", var_title = 'pearl millet price per quintal at harvest.')
      ),
      #### Test site ####
      "Testing sites visualisation",
      tabPanel("Testing sites",
       mod_test_site_ui("test_site")
      ),
      #### Crop model comparison ####
      "Crop model Prediction",
      tabPanel("Predicted yield and income comparison",

               mod_CM_prediction_ui("CM_prediction")

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
