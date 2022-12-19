#' comp_yield UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_comp_yield_ui <- function(id){
  ns <- NS(id)
  tagList(

    # Description
    tags$strong('General description:'),
    'Comparison yield between pearl millet and other crops. The N competitor
    crop are either the one with the largest cultivated area or the largest
    production over the selected period.',
    tags$br(),
    tags$br(),

    # Input
    input_district(ns('s_dist')), year_input(ns('y_range'), max = 2015),

    'Select the number of competitors.',
    sliderInput(ns("N_crop"), label = 'Number of crops', min = 2,
                max = 8, value = 6, step = 1, ticks = FALSE),


    'Select the criteria to select the competitors',
    radioButtons(inputId = ns('criteria'), label = 'Selection critieria',
                 choices = list('area' = 'area', 'production' = 'prod')),


    hr(),
    plotOutput(ns('plot_bar'),  width = '600px', height = '500px'),
    hr(),
    tableOutput(ns('res_tab'))

  )
}

#' comp_yield Server Functions
#'
#' @noRd
mod_comp_yield_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # get the input
    s_dist <- reactive({  unique(unlist(dist_list[input$s_dist]))  })
    y_r <- reactive({input$y_range})
    N_crop <- reactive({input$N_crop})
    criteria <- reactive({input$criteria})

    res <- reactive({plot_comp_yield(data_yld = d_cr_yield, data_area = d_cr_area,
                                     data_prod = d_cr_prod, N_crop = N_crop(),
                                     dist_sel = s_dist(), y_range = y_r(),
                                     comp_criteria = criteria())})

    output$plot_bar <- renderPlot({res()$p})
    output$res_tab <- renderTable({res()$d})

  })
}

## To be copied in the UI
# mod_comp_yield_ui("comp_yield_1")

## To be copied in the server
# mod_comp_yield_server("comp_yield_1")
