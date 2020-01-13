library(plyr)

mean_by_class <- function(dataset,
                 factors,
                 response) {
  
  #INPUT: dataset
  #       classes
  #       response
  #OUTPUT
  
  output <- plyr::ddply(.data = dataset,
                       .variables = factors,
                       .fun = summarise,
                           mean_response = mean(get(reponse),na.rm = T),
                           no_obs = length(get(reponse))
  )
  
  output <- output %>% 
    dplyr::mutate_if(is.numeric,
                      )
              
  
  
}