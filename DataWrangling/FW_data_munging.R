#Food web experiment
#data munging of herbivory & growth data
#created by HSR 9July2015, updated 19 sept 2016

library(readxl)
library(ggplot2)
library(dplyr)
library(lubridate)

#for excel files, check out readxl
#fwherb<-read_excel(path="FW_master_2015analysis.xlsx", sheet="AllData", na="na")

fwherb <- read.csv("Data/raw/FW_master_2016_foranalysis.csv", na.strings=c("NA", "na", ""), as.is=T)

summary(fwherb)
str(fwherb)

#change to lower case
fwherb$island<-tolower(fwherb$island)
fwherb$site<-tolower(fwherb$site)
fwherb$row<-tolower(fwherb$row)
fwherb$col<-tolower(fwherb$col)
fwherb$trt<-tolower(fwherb$trt)
fwherb$spp<-tolower(fwherb$spp)
fwherb$primdam<-tolower(fwherb$primdam)
fwherb$wilt<-tolower(fwherb$wilt)

#note- if you wanted to change to a factor, use this
#fwherb$wilt<-as.factor(fwherb$wilt)

#make sure date reads in consistently as a date
#fwherb$date<-as.Date(fwherb$date, "%d-%b-%y")
fwherb$date<-dmy(fwherb$date)
class(fwherb$date)
summary(fwherb$date)

#fix some typos within categories
unique(fwherb$trt)
unique(fwherb$island)
unique(fwherb$primdam)

fwherb$trt<-as.factor(fwherb$trt)
fwherb$island<-as.factor(fwherb$island)
fwherb$primdam<-as.factor(fwherb$primdam)

levels(fwherb$trt)<-gsub("ecl", "excl", levels(fwherb$trt))
levels(fwherb$island)<-gsub("guam ", "guam", levels(fwherb$island))
levels(fwherb$primdam)<-gsub(" dis", "dis", levels(fwherb$primdam))
levels(fwherb$primdam)<-gsub(" ds", "dis", levels(fwherb$primdam))
levels(fwherb$primdam)<-gsub("h ", "h", levels(fwherb$primdam))
levels(fwherb$primdam)<-gsub("ds", "dis", levels(fwherb$primdam))

summary(fwherb$primdam) #still have one 25-oct which is a data entry error- that should be in a different column. 

subset(fwherb, primdam=="25-oct") #need to go back to raw data, figure out what primdam should be, and replace 25-oct with that value. Still not clear - need to check further. For now, omit. 
#fwherb2<-filter(fwherb, primdam!="25-oct") not working- 

#fix levels of damclass
fwherb$damclass<-as.factor(fwherb$damclass)
levels(fwherb2$damclass2)
fwherb2<-mutate(fwherb, damclass2=factor(damclass, levels = c("<2", "<2", "<2", "0", "10-25", "5-10", "100", "100", "100", "100", "100", "2-5", "25-50", "25-50", "10-25", "5-10", "2-5", "50-75", "75-99"))) #not working quite right yet

# levels(fwherb$damclass)<-gsub("<2 ", "<2", levels(fwherb$damclass))
# levels(fwherb$damclass)<-gsub("<3", "<2", levels(fwherb$damclass))
# levels(fwherb$damclass)<-gsub("10-25%", "10-25", levels(fwherb$damclass))
# levels(fwherb$damclass)<-gsub("2-5%", "2-5", levels(fwherb$damclass))
# levels(fwherb$damclass)<-gsub("5-10%", "5-10", levels(fwherb$damclass))

#change order of the levels in this factor
#fwherb$damclass<-factor(fwherb$damclass, levels=c("0", "<2", "2-5", "5-10", "10-25", "25-50", "50-75", "75-99", "100"))

#make variable to classify herbivory into three categories
# fwherb$herbcat<-"NA"
# fwherb[(fwherb$damclass=="0" | fwherb$damclass=="<2" | fwherb$damclass=="2-5") & !is.na(fwherb$damclass),]$herbcat<-"low"
# fwherb[(fwherb$damclass=="5-10" | fwherb$damclass=="10-25") & !is.na(fwherb$damclass),]$herbcat<-"medium"
# fwherb[(fwherb$damclass=="25-50" | fwherb$damclass=="50-75" | fwherb$damclass=="75-99"| fwherb$damclass=="100") & !is.na(fwherb$damclass),]$herbcat<-"high"
# fwherb$herbcat<-factor(fwherb$herbcat, levels=c("low", "medium", "high"))

summary(fwherb)

#remove incomplete data
fwherb<-fwherb[!is.na(fwherb$trt),] #remove all 34 rows with na for trt
fwherb<-fwherb[!is.na(as.factor(fwherb$spp)),] #remove all 2296 rows with na for spp - can't use the data if no species. plants are probably dead ones
fwherb<-fwherb[fwherb$spp != "??",] #remove all with unknown for spp
fwherb<-fwherb[fwherb$ht>0 | is.na(fwherb$ht),] #remove all with ht of 0 = dead

#make unique ID for each plant
fwherb$uniqueid<-paste(fwherb$site, fwherb$row, fwherb$col, fwherb$trt, sep="")

#check to see if database still has all info


with(fwherbleaf[!is.na(fwherbleaf$primdam),], ftable(spp, island, primdam)) 



