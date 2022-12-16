#' CM_options_panel
#'
#' @description Input values for crop model prediction
#'
#' @return parameter values for the crop model predictions
#'
#' @noRd
CM_options_panel <- function(id = NULL, pan_id, var_id = '1'){

  ns <- NS(id)

  opt_nm <- paste0(c('s_text', 's_depth', 'variety', 'sow_d', 'dens', 'irrig', 'fert'), var_id)

  wellPanel(pan_id,

            sliderTextInput(inputId = ns(opt_nm[1]), label = 'Soil water content [Wat. mm/cm soil depth]',
                            choices = c('0.6 (~sandy)', '0.9 (~loam)', '1.3 (~clay)'), selected = '0.9 (~loam)'),

            sliderTextInput(inputId = ns(opt_nm[2]), label = 'Soil depth',
                            choices = c('60 cm (shallow)', '120 cm (medium)',
                                        '180 cm (deep)'), selected = '120 cm (medium)'),

            radioButtons(inputId = ns(opt_nm[3]), label = 'Variety',
                         choices = list(landrace = 'wrajpop', `commerical hybrid (9444)` = 'PM9444')),

            sliderTextInput(inputId = ns(opt_nm[4]), label = 'Sowing date',
                            choices = c('early (16-30 June)', 'average (1-15 July)', 'late (16-30 July)'),
                            selected = 'average (1-15 July)'),

            sliderTextInput(inputId = ns(opt_nm[5]), label = 'Plant density [plant/m2]',
                            choices = c('12', '18', '24'),
                            selected = '18'),

            sliderTextInput(inputId = ns(opt_nm[6]), label = 'Irrigation',
                            choices = c('no irrigation', 'partial irrigation',
                                        'full irrigation'), selected = 'partial irrigation'),

            sliderTextInput(inputId = ns(opt_nm[7]), label = 'Fertilisation',
                            choices = c('no fertilisation', '30/30 kg N', '50/50 kg N'),
                            selected = '30/30 kg N')

  )

}
