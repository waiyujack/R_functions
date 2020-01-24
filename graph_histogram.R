graph_histogram <- function(dataset,
                            factors){
  
  ##########################################################
  # INPUT: 
  #
  # OUTPUT:
  #   
  ##########################################################
  
  ## Summarise data using count, exposure, exposure split by second factor
  
  temp <- dataset %>%
    dplyr::group_by_at(factors) %>% 
    dplyr::summarise(no_obs = n()) %>%
    dplyr::mutate(exposure_by_group = no_obs / sum(no_obs),
                  cum_exposure_by_group = cumsum(exposure_by_group)) %>% 
    dplyr::ungroup()%>%
    dplyr::mutate(exposure = no_obs / sum(no_obs))%>%
    dplyr::mutate_if(is.numeric,round,4)
  
  
  ## Plot histogram or histogram split by group
  
  if (length(factors) ==1){
    
    p <- plotly::plot_ly(x = temp[[factors[1]]],
                         y = temp[["exposure_by_group"]],
                         type = "bar",
                         hoverinfo = 'text',
                         text = paste('</br> Factor: ', temp[[factors[1]]],
                                      '</br> Count: ', temp[["no_obs"]],
                                      '</br> Exposure: ', temp[["exposure"]]                         )
    )
    
  }else if(length(factors) ==2){
    
    p <- plotly::plot_ly(x = temp[[factors[1]]],
                         y = temp[["exposure_by_group"]],
                         type = "bar",
                         color = as.factor(temp[[factors[2]]]),
                         hoverinfo = 'text',
                         text = paste('</br> Factor: ', temp[[factors[1]]],
                                      '</br> Secondary Factor: ', temp[[factors[2]]],
                                      '</br> Count: ', temp[["no_obs"]],
                                      '</br> Exposure: ', temp[["exposure"]],
                                      '</br> Exposure by group: ', temp[["exposure_by_group"]]
                         )
    )
    
  }
  
  return(p)
  
}
