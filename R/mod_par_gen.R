#' par_gen UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_par_gen_ui <- function(id){
  ns <- NS(id)
  tagList(

    # Description
    tags$strong('General description:'),
    'Plots, map and descriptive statistics about pearl millet cultivated area in selected districts for a certain time range.',
    tags$br(),
    tags$br(),

    # Inputs
    input_district(ns('s_dist')), year_input(ns("y_range")),
    year_input(ns("y_range_sh"), label = 'Select year range for share statistics', max = 2015),

    'Select among the following options the statistic that will be ploted on the map below:',
    tags$br(),
    tags$br(),
    'A) average: average area [1000*ha - Kha] over the selected years', tags$br(),
    'B) average share: proportion of area allocated to pearl millet [%] compared
    to other crops averaged over the selected years', tags$br(),
    'C) trend: linear trend or rate of change of the cultivated pearl
    millet area [Kha/year] over the selected years', tags$br(),
    'D) share trend: linear trend or rate of change of the pearl millet share
    area [%/year] over the selected years', tags$br(),
    tags$br(),

    # Input
    map_stat_input(ns('s_var')),

    hr(),
    tags$strong('Scatter plot of the averaged area [Kha] over year with linear trend.'),
    tags$br(),
    plotOutput(ns('plot_1'), width = '500px'),
    hr(),
    hr(),
    tags$strong('Scatter plot of the averaged proportion of pearl millet area [%] over year with linear trend.'),
    tags$br(),
    plotOutput(ns('plot_2'), width = '500px'),
    hr(),
    plotOutput(ns('p_map'), width = '400px', height = '400px'),
    hr(),
    'Descriptive statistics of pearl millet cultivated area per district. For the definition of each column see
    the above descriptions of each statistics.',
    tags$br(),
    tableOutput(ns('res_tab'))

  )
}

#' par_gen Server Functions
#'
#' @noRd
mod_par_gen_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # get the input
    sel_dist <- reactive({  unique(unlist(dist_list[input$s_dist]))  })
    y_r <- reactive({input$y_range})
    y_r_cr <- reactive({input$y_range_sh})

    # abs average and trend + share and trend
    s1 <- reactive({average_trend(data = PM_prod, dist_sel = sel_dist(), y_range = y_r())})
    s2 <- reactive({share_trend(data = d_cr_area, dist_sel = sel_dist(), y_range = y_r())})

    # Absolute trend plot
    dA <- reactive({d_trend(data = PM_prod, dist_sel = sel_dist(), y_range = y_r())})
    pA <- reactive({scatplot_reg(d = dA(), ylab = 'area [Kha]', main = 'area trend')})

    # share plot
    dA2 <- reactive({d_share(data = d_cr_area, dist_sel = sel_dist(), y_range = y_r_cr())})
    pA2 <- reactive({scatplot_reg(d = dA2(), ylab = 'PM area share [%]', main = 'share trend')})

    # map plot
    p_map <- reactive({plot_map_av_sh_tr(ptype = input$s_var, d_poly = d_poly,
                                           p_val_av = s1()$av,
                                           dist_code_av = s1()$dist_code,
                                           col_high_av = 'darkgreen',
                                           v_name_av = 'area [Kha]',
                                           main_av = 'Average area',
                                           p_val_tr = s1()$tr,
                                           dist_code_tr = s1()$dist_code,
                                           col_low_tr = 'red',
                                           col_mid_tr = 'white',
                                           v_name_tr = 'trend [Kha/y]',
                                           main_tr = 'Area trend',
                                           p_val_as = s2()$av,
                                           dist_code_as = s2()$dist_code,
                                           col_high_as = "darkgreen",
                                           v_name_as = 'area share [%]',
                                           main_as = 'Area share',
                                           p_val_st = s2()$tr,
                                           dist_code_st = s2()$dist_code,
                                           col_low_st = 'red',
                                           col_mid_st = 'white',
                                           v_name_st = 'trend [%/y]',
                                           main_st = 'Area share trend')})

    # plot
    output$plot_1 <- renderPlot({pA()})
    output$plot_2 <- renderPlot({pA2()})
    output$p_map <- renderPlot({p_map()})

    # table
    res_tab <- reactive({tab_av_sh(d1 = s1(), d2 = s2())})
    output$res_tab <- renderTable({res_tab()})

  })
}

## To be copied in the UI
# mod_par_gen_ui("par_gen_area")

## To be copied in the server
# mod_par_gen_server("par_gen_area")
