#' CM_prediction UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_CM_prediction_ui <- function(id){
  ns <- NS(id)
  tagList(

    # Description
    tags$strong('General description:'),
    'Comparison of crop model prediction outputs (yield or expected income) for a selection of
    districts averaged over a selected period of time. The results presented are an
    average between two crop models: the reference crop model from APSIM and an updated
    version that integrates more recent biological knowledge about leaf area development and tillering.',
    tags$br(),
    tags$br(),

    'The user can constrast two scenarios. For each scenario, he/she can select
    among the following parameters options:',
    tags$br(),
    tags$br(),
    'A) Soil water content in mm of water per cm of soil depth: 0.6 (~sandy), 0.9 (~loam), or 1.3 (~clay)', tags$br(),
    'B) Soil depth in cm: 60 (shallow), 120 (medium), or 180 (deep)', tags$br(),
    'C) Type of plant variety used: landrace type or commercial hybrid type', tags$br(),
    'D) Sowing date window: 16-30 June (early), 1-15 July (average), 16-30 July (late)', tags$br(),
    'E) Plant density in plant/m2: 12, 18, or 24', tags$br(),
    'F) Irrigation: automatic, intermediate, no irrigation', tags$br(),
    'G) Fertilisation basal dose/20 days after sowing [kg N/ha]:, 0/0, 30/30, 50/50',
    tags$br(),
    tags$br(),
    'The user can also select with crop model output should be ploted on the map:',
    tags$br(),
    tags$br(),
    'A) Expected yield [kg/ha]', tags$br(),
    'B) Expected income [INR/ha]. The expected income is the multiplication of the
    expected yield and the average price per 100 kg at harvest for the five most
    recent years where information is available [2013-2017].
    For some district the price information is not available.', tags$br(),
    tags$br(),
    tags$br(),

    # input
    wellPanel('General parameters',

        # Input
        input_district(ns('s_dist')), year_input(ns("y_range")),

        selectInput(inputId = ns('s_var'), label = 'Select parameter to plot on the map',
                    choices = list(`Expected yield` = 'exp_yield', `Expected income` = 'exp_income'),
                    selected = 'exp_yield')


    ),

    # CM options selection
    splitLayout(CM_options_panel(id = id, pan_id = 'Option1'),
                CM_options_panel(id = id, pan_id = 'Option2', var_id = '2')),

    # output
    splitLayout(plotOutput(ns('p_map_CM_o1'), width = '300px', height = '300px'),
                plotOutput(ns('p_map_CM_o2'), width = '300px', height = '300px')),
    hr(),
    plotOutput(ns('p_map_CM_diff'), width = '300px', height = '300px'),
    tableOutput(ns("pred_tab"))

  )
}

#' CM_prediction Server Functions
#'
#' @noRd
mod_CM_prediction_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # get the input
    sel_dist <- reactive({ unique(unlist(dist_list[input$s_dist]))})
    y_r <- reactive({input$y_range})
    last_year = 2013:2017

    output$sel_dist <- renderText({sel_dist()})

    # expected yield option 1 and 2
    y_p_opt1 <- reactive({CM_get_input(data_CM = data_CM, PM_prod = PM_prod,
                                       sel_dist = sel_dist(),
                                       year_range = y_r(),
                                       last_year = last_year,
                                       s_text_inp = input$s_text1,
                                       s_depth_inp = input$s_depth1,
                                       irrig_inp = input$irrig1,
                                       variety_inp = input$variety1,
                                       fert_inp = input$fert1,
                                       sow_d_inp = input$sow_d1,
                                       dens_inp = input$dens1)})

    y_p_opt2 <- reactive({CM_get_input(data_CM = data_CM, PM_prod = PM_prod,
                                       sel_dist = sel_dist(),
                                       year_range = y_r(),
                                       last_year = last_year,
                                       s_text_inp = input$s_text2,
                                       s_depth_inp = input$s_depth2,
                                       irrig_inp = input$irrig2,
                                       variety_inp = input$variety2,
                                       fert_inp = input$fert2,
                                       sow_d_inp = input$sow_d2,
                                       dens_inp = input$dens2)})

    # Combine the two table
    CM_tab <- reactive({form_CM_res_tab(data = PM_prod, d1 = y_p_opt1(), d2 = y_p_opt2())})

    output$pred_tab <- renderTable({CM_tab()$res_tab})


    # map plot
    p_map_CM <- reactive({plot_CM_map(ptype = input$s_var, d_poly = d_poly,
                                      dist_code = CM_tab()$r_tab$dist_code,
                                      p_val_yld_o1 = CM_tab()$r_tab$exp_yld.x,
                                      p_val_yld_o2 = CM_tab()$r_tab$exp_yld.y,
                                      p_val_yld_diff = CM_tab()$r_tab$yld_diff,
                                      p_val_inc_o1 = CM_tab()$r_tab$exp_inc.x,
                                      p_val_inc_o2 = CM_tab()$r_tab$exp_inc.y,
                                      p_val_inc_diff = CM_tab()$r_tab$inc_diff)})


    output$p_map_CM_o1 <- renderPlot({p_map_CM()$p_o1})
    output$p_map_CM_o2 <- renderPlot({p_map_CM()$p_o2})
    output$p_map_CM_diff <- renderPlot({p_map_CM()$p_diff})

  })
}

## To be copied in the UI
# mod_CM_prediction_ui("CM_prediction_1")

## To be copied in the server
# mod_CM_prediction_server("CM_prediction_1")
