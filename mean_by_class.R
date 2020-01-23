mean_by_class <- function(dataset,
                 factors,
                 response) {
  
  ##########################################################
  # INPUT: 
  #   dataset
  #   classes
  #   response
  # OUTPUT:
  #   
  ##########################################################
  
  ## Find mean response by class
  
  output <- dataset %>%
    dplyr::group_by_at(factors) %>% 
    dplyr::summarise(no_obs = n(),
                     mean_response = mean(get(response))) %>%
                       dplyr::mutate(exposure_by_group = no_obs / sum(no_obs)) %>% 
    dplyr::ungroup()%>%
    dplyr::mutate(exposure = no_obs / sum(no_obs))
                     
  ## Find exposure
  
  output <- output %>%
    dplyr::mutate_if(is.numeric,round,4)
  
  ## Return output as dataframe
  
  return(output)
  
}

