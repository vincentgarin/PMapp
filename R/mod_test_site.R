#' test_site UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_test_site_ui <- function(id){
  ns <- NS(id)
  tagList(

    # Description
    tags$strong('General description:'),
    paste('Map of the pearl millet testing sites.'),
    tags$br(),
    tags$br(),

    'Select testing sites to be plotted on the map',
    input_district(ns('s_site'), label = 'Selected site(s)',
                   choices = d_site_nm, default = 'all'),
    tags$br(),

    'Select how many zones of the TPE will be represented',
    radioButtons(inputId = ns('n_zone'), label = 'N. zones',
                 choices = list(`3` = 3, `4` = 4, `5` = 5)),

    hr(),
    plotOutput(ns('p_site'), width = '650px', height = '600px')


  )
}

#' test_site Server Functions
#'
#' @noRd
mod_test_site_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # get the input
    s_site <- reactive({  unique(unlist(site_list[input$s_site]))  })
    n_zone <- reactive({input$n_zone})

    p_site <- reactive({plot_site(d_poly = d_poly, d_clu = d_clu,
                                  d_site = d_site, s_site = s_site(),
                                  n_env = as.numeric(n_zone()))})

    output$p_site <- renderPlot({p_site()})

  })
}

## To be copied in the UI
# mod_test_site_ui("test_site_1")

## To be copied in the server
# mod_test_site_server("test_site_1")
