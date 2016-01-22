
# Packages ----------------------------------------------------------------

library("data.table")
library("dplyr")


# Exchange rate -------------------------------------------------------------

change <- as.data.frame(fread("Data/CHFEUR.csv"))

change <- select(change,Date,Rate)

change$Date <- as.Date(change$Date, "%d/%m/%Y")

change <- change %>% filter(Date>"2012-12-24")


# Accor -------------------------------------------------------------------

# Sold rooms
soldrooms <- as.data.frame(fread("Data/Sold rooms.csv"))
soldrooms$Date <- as.Date(soldrooms$Date,"%d/%m/%Y")
names(soldrooms) <- gsub(" ","_",names(soldrooms))

# Room revenue
roomrevenue <- as.data.frame(fread("Data/roomrevenue.csv"))
roomrevenue <- roomrevenue %>% select(-Date) 
roomrevenue <- as.data.frame(cbind("Date"=soldrooms$Date,roomrevenue))
names(roomrevenue) <- gsub(" ","_",names(roomrevenue))
names(roomrevenue)[2] <- paste(names(roomrevenue)[2],"Geneve",sep="_")
names(roomrevenue)[32] <- paste(names(roomrevenue)[32],"Geneve",sep="_")

# Overview
overview <- as.data.frame(fread("Data/Overview.csv"))
overview$Hotel <- gsub(" ","_",overview$Hotel)
names(overview) <- gsub(" ","_",names(overview))
overview$Brand <- gsub(" ","_",overview$Brand)


# Competitors -------------------------------------------------------------

# Lausanne
lausanne <- as.data.frame(fread("Data/Lausanne.csv"))

datecomp <- paste("01/",lausanne$Date,sep="")
datecomp <- gsub(" ","/",datecomp)
datecomp <- as.Date(datecomp, "%d/%m/%Y")

lausanne <- lausanne %>% select(-Date) %>% mutate("Date"=datecomp)

# Zurich
zurich <- as.data.frame(fread("Data/Zurich.csv"))
zurich <- zurich %>% select(-Date) %>% mutate("Date"=datecomp)

# Lucern
lucern <- as.data.frame(fread("Data/Lucern.csv"))
lucern <- lucern %>% select(-Date) %>% mutate("Date"=datecomp)

# Bern
bern <- as.data.frame(fread("Data/Bern.csv"))
bern <- bern %>% select(-Date) %>% mutate("Date"=datecomp)

# Geneva
geneva <- as.data.frame(fread("Data/Geneve.csv"))
geneva <- geneva %>% select(-Date) %>% mutate("Date"=datecomp)

# Global
compset <- as.data.frame(fread("Data/CompSet.csv"))
compset <- compset %>% select(-Date) %>% mutate("Date"=datecomp)


