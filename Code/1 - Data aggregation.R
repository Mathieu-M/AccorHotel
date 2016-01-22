
# Packages ----------------------------------------------------------------

library("dplyr")
source("Code/Functions.R")


# Standardized data -------------------------------------------------------

# roomrevenue
roomrevenuenorm <- as.data.frame(apply(roomrevenue[,-1],2,fnormalize))
roomrevenuenorm <- roomrevenuenorm %>% mutate("Date"=roomrevenue$Date)

date_week <- as.Date(cut(roomrevenuenorm$Date,
                         breaks = "week",
                         start.on.monday = FALSE))

roomrevenuenorm <- roomrevenuenorm %>% mutate(Week=date_week)

roomrevenue_norm_week <- roomrevenuenorm %>% group_by(Week) %>%
  summarise_each(funs(mean(., na.rm=TRUE)), -c(Date,Week))

names(roomrevenue_norm_week)[1] <- "Date"

# soldrooms
soldroomsnorm <- as.data.frame(apply(soldrooms[,-1],2,fnormalize))
soldroomsnorm <- soldroomsnorm %>% mutate("Date"=soldrooms$Date)

soldroomsnorm <- soldroomsnorm %>% mutate(Week=date_week)

soldrooms_norm_week <- soldroomsnorm %>% group_by(Week) %>%
  summarise_each(funs(mean(., na.rm=TRUE)), -c(Date,Week))

names(soldrooms_norm_week)[1] <- "Date"


# Accor by city ----------------------------------------------------------

# Lausanne
accorlausanne <- faggregate(roomrevenuenorm,city=TRUE,name=Lausanne)
length(overview[overview$Place=="Lausanne",1])

# Bern
accorbern <- faggregate(roomrevenuenorm,city=TRUE,name=Bern)
length(overview[overview$Place=="Bern",1])

# Luzern
accorluzern <- faggregate(roomrevenuenorm,city=TRUE,name=Lucerne)
length(overview[overview$Place=="Lucerne",1])

# Basel
accorbasel <- faggregate(roomrevenuenorm,city=TRUE,name=Basel)
length(overview[overview$Place=="Basel",1])

# Lugano
accorlugano <- faggregate(roomrevenuenorm,city=TRUE,name=Lugano)
length(overview[overview$Place=="Lugano",1])

# Zurich
accorzurich <- faggregate(roomrevenuenorm,city=TRUE,name=Zurich)
length(overview[overview$Place=="Zurich",1])

# Geneva
accorgeneva <- faggregate(roomrevenuenorm,city=TRUE,name=Geneva)
length(overview[overview$Place=="Geneva",1])

# Winterthur
accorwinterthur <- faggregate(roomrevenuenorm,city=TRUE,name=Winterthur)
length(overview[overview$Place=="Winterthur",1])


# Weekly city data -------------------------------------------------------------

# Lausanne
accorlausanne <- faggregate(roomrevenue_norm_week,city=TRUE,name=Lausanne)
length(overview[overview$Place=="Lausanne",1])

# Bern
accorbern <- faggregate(roomrevenue_norm_week,city=TRUE,name=Bern)
length(overview[overview$Place=="Bern",1])

# Luzern
accorluzern <- faggregate(roomrevenue_norm_week,city=TRUE,name=Lucerne)
length(overview[overview$Place=="Lucerne",1])

# Basel
accorbasel <- faggregate(roomrevenue_norm_week,city=TRUE,name=Basel)
length(overview[overview$Place=="Basel",1])

# Lugano
accorlugano <- faggregate(roomrevenue_norm_week,city=TRUE,name=Lugano)
length(overview[overview$Place=="Lugano",1])

# Zurich
accorzurich <- faggregate(roomrevenue_norm_week,city=TRUE,name=Zurich)
length(overview[overview$Place=="Zurich",1])

# Geneva
accorgeneva <- faggregate(roomrevenue_norm_week,city=TRUE,name=Geneva)
length(overview[overview$Place=="Geneva",1])

# Winterthur
accorwinterthur <- faggregate(roomrevenue_norm_week,city=TRUE,name=Winterthur)
length(overview[overview$Place=="Winterthur",1])


# Accor by place positionning ---------------------------------------------

business <- faggregate(roomrevenuenorm,position=TRUE,name=business)

mixed <- faggregate(roomrevenuenorm,position=TRUE,name=mixed)

leisure <- faggregate(roomrevenuenorm,position=TRUE,name=leisure)


# Weekly place positionning  ----------------------------------------------

business_week <- faggregate(roomrevenue_norm_week,position=TRUE,name=business)

mixed_week <- faggregate(roomrevenue_norm_week,position=TRUE,name=mixed)

leisure_week <- faggregate(roomrevenue_norm_week,position=TRUE,name=leisure)


# Accor by brand ----------------------------------------------------------

ibis <- faggregate(roomrevenuenorm,brand=TRUE,name=ibis)

ibis_budget <- faggregate(roomrevenuenorm,brand=TRUE,name=ibis_budget)

ibis_styles <- faggregate(roomrevenuenorm,brand=TRUE,name=ibis_styles)

novotel <- faggregate(roomrevenuenorm,brand=TRUE,name=Novotel)

mgallery <- faggregate(roomrevenuenorm,brand=TRUE,name=Mgallery)

mercure <- cbind(roomrevenuenorm[,c("Date","Mercure_Plaza_Biel")],
                 "mercure"=roomrevenuenorm$Mercure_Plaza_Biel)


# Weekly brand -------------------------------------------------------

ibis_week <- faggregate(roomrevenue_norm_week,brand=TRUE,name=ibis)

ibis_budget_week <- faggregate(roomrevenue_norm_week,brand=TRUE,name=ibis_budget)

ibis_styles_week <- faggregate(roomrevenue_norm_week,brand=TRUE,name=ibis_styles)

novotel_week <- faggregate(roomrevenue_norm_week,brand=TRUE,name=Novotel)

mgallery_week <- faggregate(roomrevenue_norm_week,brand=TRUE,name=Mgallery)

mercure_week <- cbind(roomrevenue_norm_week[,c("Date","Mercure_Plaza_Biel")],
                 "mercure"=roomrevenue_norm_week$Mercure_Plaza_Biel)


