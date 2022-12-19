#' par_comp UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_par_comp_ui <- function(id, par_nm = 'area'){
  ns <- NS(id)
  tagList(

    # Description
    tags$strong('General description:'),
    paste('Time series plot of the main crop', par_nm,  'compared to pearl
             millet in selected districts for selected time frame.'),
    tags$br(),
    tags$br(),

    # Input
    input_district(ns('s_dist')), year_input(ns('y_range'), max = 2015),

    sliderInput(ns("crop_N"), label = 'Number of crops', min = 2,
                max = 6, value = 6, step = 1, ticks = FALSE),

    hr(),
    plotOutput(ns('facet')),
    hr(),
    plotOutput(ns('p_dist'), width = '210px', height = '250px')

  )
}

#' par_comp Server Functions
#'
#' @noRd
mod_par_comp_server <- function(id, data = d_cr_area, par_nm = 'area'){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # get the input
    sel_dist <- reactive({  unique(unlist(dist_list[input$s_dist]))  })
    y_r <- reactive({input$y_range})
    n_cr_plot <- reactive({input$crop_N})

    facet <- reactive({comp_trend_plot(data = data, dist_sel = sel_dist(),
                                          y_range = y_r(), N_crop = n_cr_plot(),
                                       main = paste(par_nm, 'trend'))})

    p_dist <- reactive({plot_sel_dist(d_poly = d_poly, sel_dist = sel_dist())})

    output$facet <- renderPlot({facet()})
    output$p_dist <- renderPlot({p_dist()})

  })
}

## To be copied in the UI
# mod_par_comp_ui("par_comp_1")

## To be copied in the server
# mod_par_comp_server("par_comp_1")
