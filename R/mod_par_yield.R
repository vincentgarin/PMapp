#' par_yield UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_par_yield_ui <- function(id){
  ns <- NS(id)
  tagList(

    # Description
    tags$strong('General description:'),
    'Plots, map and descriptive statistics about pearl millet yield in selected districts for a certain time range.',
    tags$br(),
    tags$br(),

    # Input
    input_district(ns('s_dist')), year_input(ns("y_range")),

    'Select among the following options the statistic that will be ploted on the map below:',
    tags$br(),
    tags$br(),
    'A) average: average yield [kg/ha] over the selected years', tags$br(),
    'B) trend: linear trend or rate of change of the pearl millet yield
               [kg/ha/year] over the selected years', tags$br(),

    selectInput(inputId = ns('s_var'), label = '',
                choices = list(average = 'av', trend = 'tr'), selected = 'tr'),

    hr(),
    tags$strong('Scatter plot of the averaged yield [kg/ha] over years with linear trend.'),
    tags$br(),
    plotOutput(ns('plot'), width = '500px'),
    hr(),
    plotOutput(ns('p_map'), width = '400px', height = '400px'),
    hr(),

    'Descriptive statistics of pearl millet yield per districts. For the definition of each column see
               the above descriptions of each statistics.',
    tags$br(),

    tableOutput(ns('res_tab'))

  )
}

#' par_yield Server Functions
#'
#' @noRd
mod_par_yield_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # get the input
    sel_dist <- reactive({unique(unlist(dist_list[input$s_dist]))  })
    y_r <- reactive({input$y_range})

    # abs average and trend
    s1 <- reactive({average_trend(data = PM_prod, dist_sel = sel_dist(), y_range = y_r(), s_var = 'yield')})

    # Absolute trend plot
    dY <- reactive({d_trend(data = PM_prod, dist_sel = sel_dist(), y_range = y_r(), s_var = 'yield')})
    pY <- reactive({scatplot_reg(d = dY(), ylab = 'yield [kg/ha]', main = 'yield trend')})

    output$plot <- renderPlot({pY()})

    # map plot
    p_map <- reactive({plot_map_av_sh_tr(ptype = input$s_var, d_poly = d_poly,
                                           p_val_av = s1()$av,
                                           dist_code_av = s1()$dist_code,
                                           col_high_av = 'chocolate4',
                                           v_name_av = 'yield [kg/ha]',
                                           main_av = 'Average yield',
                                           p_val_tr = s1()$tr,
                                           dist_code_tr = s1()$dist_code,
                                           col_low_tr = 'red',
                                           col_mid_tr = 'white',
                                           v_name_tr = 'trend [Kg/ha/y]',
                                           main_tr = 'Yield trend')})

    output$p_map <- renderPlot({p_map()})

    # table
    res_tab <- reactive({ s1() %>% select(state_name, dist_name, av, tr) %>%
        rename(state = state_name, district = dist_name, `average [kg/ha]` = av,
               `trend [kg/ha/y]` = tr)})

    output$res_tab <- renderTable({res_tab()})

  })
}

## To be copied in the UI
# mod_par_yield_ui("par_yield_1")

## To be copied in the server
# mod_par_yield_server("par_yield_1")
