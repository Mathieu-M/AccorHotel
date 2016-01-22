
# Data import ----------------------------------------------------------

any.na <- function(x){
  return(any(is.na(x)))
}


# Data treatment -------------------------------------------------------------

#' 
#' This function normalize a vector.
#' @param x: thevector to be normalized.
#' @return (x-mean(x))/sd(x).
#' 
fnormalize <- function(x){
  return((x-sum(x,na.rm=TRUE)/length(x))/sd(x,na.rm=TRUE))
}


#' 
#' This function aggregate hotels by either city, brand or place positionning. The hotels are selected
#' from the overview dataset.
#' @param data: the dataset where to find the hotels.
#' @param city: logical, indicates whether the aggregation is done by city.
#' @param position: logical, indicates whether the aggregation is done by place positionning.
#' @param brand: logical, indicates whether the aggregation is done by brand.
#' @param name: the name of the city, the position or the brand.
#' @return the aggregated data frame.
#' 
faggregate <- function(data,city=FALSE,position=FALSE,brand=FALSE,name){
  name <- deparse(substitute(name))
  if(city==TRUE){
    if(position==TRUE || brand==TRUE){
      stop("Only one of the three 'city', 'position' and 'brand' can be set to TRUE.")
    }
    listhotel <- overview[overview$Place==name,]$Hotel
  }
  if(position==TRUE){
    if(city==TRUE || brand==TRUE){
      stop("Only one of the three 'city', 'position' and 'brand' can be set to TRUE.")
    }
    listhotel <- overview[overview$Place_positioning==name,]$Hotel
  }
  if(brand==TRUE){
    if(city==TRUE || position==TRUE){
      stop("Only one of the three 'city', 'position' and 'brand' can be set to TRUE.")
    }
    listhotel <- overview[overview$Brand==name,]$Hotel
  }
  global <- rowSums(data[,names(data)%in%listhotel],na.rm=TRUE)
  res <- cbind("Date"=data$Date,data[,names(data)%in%listhotel],global)
  return(res)
}

