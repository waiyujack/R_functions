#dataprep_binning

library(fancycut)

fn_binning<-function(x,bin_range,bin_no,do_bin=TRUE){
  
  if (do_bin==TRUE){
    
    bin_width<-diff(bin_range)/bin_no
    
    if(is.factor(x)){
      x<-levels(x)[as.numeric(x)]
    }
    
    bin_cut_point<-seq(bin_range[1],bin_range[2],by=bin_width)
    
    bin_interval<-c(paste0("(-Inf,",bin_range[1],"]"),
                    sapply(bin_cut_point[-c(bin_no+1)],function(y){paste0("(",y,",",y+bin_width,"]")}),
                    paste0("(",bin_range[2],",Inf]")
    )
    
    out<-wafflecut(x,intervals = bin_interval,buckets = bin_interval,na.bucket = "<NA>")
    
  }else{
    
    out<-x
    
  }
  
  return(out)
  
}
