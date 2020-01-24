graph_histogram <- function(factor1,factor2=NULL){
  
  ##########################################################
  # INPUT: 
  # factor1 - a vector of numerics
  # factor2 - a vector of numerics
  # OUTPUT:
  # A plotly chart of histogram (if factor 2 is not null then histogram split by 
  # factor2)
  ##########################################################
  
  if(is.null(factor2)){
    
    dataset <- data.frame(factor1 = factor1)
    
  }else{
    
    dataset <- data.frame(factor1 = factor1,
                          factor2 = factor2
                          )
    
  }
  
  factors <- ifelse(is.null(factor2),"factor1",c("factor1","factor2"))
  
  temp <- dataset %>%
    dplyr::group_by_at(factors) %>% #group by factors
    dplyr::summarise(no_obs = dplyr::n()) %>% #count
    dplyr::mutate(exposure_by_group = no_obs / sum(no_obs), #by first group exposure
                  cum_exposure_by_group = cumsum(exposure_by_group)) %>% #cumulative exposure
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
                                      '</br> Exposure: ', temp[["exposure"]] ,
                                      '</br> Cum Exposure: ', temp[["cum_exposure_by_group"]])
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

