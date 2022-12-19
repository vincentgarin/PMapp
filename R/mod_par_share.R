#' par_share UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_par_share_ui <- function(id, par_nm = 'area'){
  ns <- NS(id)
  tagList(

    # Description
    tags$strong('General description:'),
    paste('Pie chart of pearl millet', par_nm, 'proportion with other crops for selected districts over a selected period of time.'),
    tags$br(),
    tags$br(),

    # Input
    input_district(ns('s_dist')), year_input(ns('y_range'), max = 2015),

    sliderInput(ns("min_sh"), label = 'Select crop min. share [%]', min = 1,
                max = 20, value = 3, step = 1, ticks = FALSE),

    hr(),
    splitLayout(plotOutput(ns('p_dist'), width = '210px', height = '250px'),
                plotOutput(ns('pie'), width = '350px', height = '250px'),
                cellWidths = c("40%", "60%"))

  )
}

#' par_share Server Functions
#'
#' @noRd
mod_par_share_server <- function(id,  data = d_cr_area, par_nm = 'area'){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # get the input
    sel_dist <- reactive({  unique(unlist(dist_list[input$s_dist]))  })
    y_r <- reactive({input$y_range})
    min_share <- reactive({input$min_sh})

    pie <- reactive({
      pie_chart(data = data, dist_sel = sel_dist(),
                y_range = y_r(), min = min_share(), main = paste(par_nm, 'share'))
    })

    p_dist <- reactive({plot_sel_dist(d_poly = d_poly, sel_dist = sel_dist())})

    output$pie <- renderPlot({pie()})
    output$p_dist <- renderPlot({p_dist()})


  })
}

## To be copied in the UI
# mod_par_share_ui("par_share_1")

## To be copied in the server
# mod_par_share_server("par_share_1")
