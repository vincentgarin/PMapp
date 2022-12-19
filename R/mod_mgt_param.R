#' mgt_param UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_mgt_param_ui <- function(id, var_title = ' pearl millet surface under irrigation.'){
  ns <- NS(id)
  tagList(

    # Description
    tags$strong('General description:'),
    paste('Map of the avarage and trend of', var_title),
    tags$br(),
    tags$br(),

    # Input
    input_district(ns('s_dist')), year_input(ns('y_range')),

    hr(),
    splitLayout(plotOutput(ns('p_av'), width = '450px', height = '450px'),
                plotOutput(ns('p_tr'), width = '450px', height = '450px'),
                cellWidths = c("50%", "50%")),

    tags$br(),
    tableOutput(ns('res_tab'))

  )
}

#' mgt_param Server Functions
#'
#' @noRd
mod_mgt_param_server <- function(id, s_var = 'irrig', var_nm = 'Irrig.',
                                 pb_dist = "SAMBHAL",
                                 col_high = 'darkblue', unit_nm = '%'){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # get the input
    sel_dist <- reactive({  unique(unlist(dist_list[input$s_dist]))  })
    y_r <- reactive({input$y_range})

    p <- reactive({plot_mgt_pract(data = PM_prod, d_poly = d_poly,
                                  dist_sel = sel_dist(),
                                  y_range = y_r(), s_var = s_var,
                                  var_nm = var_nm, pb_dist = pb_dist,
                                  col_high = col_high, unit_nm = unit_nm)})

    output$p_av <- renderPlot({p()$p_av})
    output$p_tr <- renderPlot({p()$p_tr})
    output$res_tab <- renderTable({p()$tab})

  })
}

## To be copied in the UI
# mod_mgt_param_ui("mgt_param_1")

## To be copied in the server
# mod_mgt_param_server("mgt_param_1")
