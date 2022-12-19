#' rain_pattern UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_rain_pattern_ui <- function(id){
  ns <- NS(id)
  tagList(

    # Description
    tags$strong('General description:'),
    'Map of the average, variance and trend of cumulated rain during the Kharif (rainy) season in
             selected districts for a selected time range.',
    tags$br(),
    tags$br(),

    # Input
    input_district(ns('s_dist')), year_input(ns('y_range')),

    hr(),
    splitLayout(plotOutput(ns('p_R_av'), width = '350px', height = '350px'),
                plotOutput(ns('p_R_var'), width = '350px', height = '350px'),
                plotOutput(ns('p_R_tr'), width = '350px', height = '350px'),
                cellWidths = c("33%", "33%", "34%")),

    tags$br(),
    tableOutput(ns('res_tab_rain'))

  )
}

#' rain_pattern Server Functions
#'
#' @noRd
mod_rain_pattern_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # get the input
    sel_dist <- reactive({  unique(unlist(dist_list[input$s_dist]))  })
    y_r <- reactive({input$y_range})

    p_rain <- reactive({plot_rain(data = PM_prod, d_poly = d_poly,
                                  dist_sel = sel_dist(),
                                  y_range = y_r())})

    output$p_R_av <- renderPlot({p_rain()$p_av})
    output$p_R_var <- renderPlot({p_rain()$p_var})
    output$p_R_tr <- renderPlot({p_rain()$p_tr})
    output$res_tab_rain <- renderTable({p_rain()$tab})

  })
}

## To be copied in the UI
# mod_rain_pattern_ui("rain_pattern_1")

## To be copied in the server
# mod_rain_pattern_server("rain_pattern_1")
