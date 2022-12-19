#' soil_type UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_soil_type_ui <- function(id){
  ns <- NS(id)
  tagList(

    # Description
    tags$strong('General description:'),
    'Map of the majority type of soil per district. For some districts the information is not available.',
    tags$br(),
    tags$br(),

    # Input
    input_district(ns('s_dist')),

    hr(),
    plotOutput(ns('p_soil'), width = '470px', height = '450px')

  )
}

#' soil_type Server Functions
#'
#' @noRd
mod_soil_type_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # get the input
    sel_dist_soil <- reactive({  unique(unlist(dist_list[input$s_dist]))  })

    p_soil <- reactive({plot_soil_maj(data = PM_prod, d_poly = d_poly,
                                      sel_dist = sel_dist_soil())})

    output$p_soil <- renderPlot({p_soil()})

  })
}

## To be copied in the UI
# mod_soil_type_ui("soil_type_1")

## To be copied in the server
# mod_soil_type_server("soil_type_1")
