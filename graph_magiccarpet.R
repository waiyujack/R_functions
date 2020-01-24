
dataset <- dummy_data
x_factor<-"X1"
y_factor<- "X2"

temp <- dataset %>%
  dplyr::group_by_at(c(x_factor,y_factor)) %>% #group by factors
  dplyr::summarise(no_obs = dplyr::n()) %>% #count
  dplyr::mutate(exposure_by_x = no_obs / sum(no_obs), #by first group exposure
                cum_exposure_by_x = cumsum(exposure_by_x)) %>% #cumulative exposure
  dplyr::ungroup() %>% 
  dplyr::group_by_at(c(y_factor)) %>% 
  dplyr::mutate(exposure_by_y = no_obs / sum(no_obs), #by first group exposure
                cum_exposure_by_y = cumsum(exposure_by_y))

p <- plotly::plot_ly(x = temp[[x_factor]],
                    y = temp[["exposure_by_x"]],
                    type = "bar",
                    color = temp[[y_factor]]) %>%
  plot_ly()
  layout(barmode = "stack")
p
