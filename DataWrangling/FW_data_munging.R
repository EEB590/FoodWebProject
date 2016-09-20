#Food web experiment
#data munging of herbivory & growth data
#created by HSR 9July2015, updated 19 sept 2016

library(readxl)
library(ggplot2)
library(plyr)
library(lubridate)

#for excel files, check out readxl
#fwherb<-read_excel(path="FW_master_2015analysis.xlsx", sheet="AllData", na="na")

fwherb<-read.csv("FW_master_2016_foranalysis.csv", header=T)

#change to lower case
fwherb$island<-as.factor(tolower(fwherb$island))
fwherb$site<-as.factor(tolower(fwherb$site))
fwherb$row<-as.factor(tolower(fwherb$row))
fwherb$col<-as.factor(tolower(fwherb$col))
fwherb$trt<-as.factor(tolower(fwherb$trt))
fwherb$spp<-as.factor(tolower(fwherb$spp))
fwherb$primdam<-as.factor(tolower(fwherb$primdam))
fwherb$wilt<-as.factor(tolower(fwherb$wilt))

#make sure date reads in consistently as a date
fwherb$date<-as.Date(fwherb$date, "%d-%b-%y")

#fix some typos within categories
levels(fwherb$trt)<-gsub("ecl", "excl", levels(fwherb$trt))
levels(fwherb$island)<-gsub("guam ", "guam", levels(fwherb$island))
levels(fwherb$primdam)<-gsub(" dis", "dis", levels(fwherb$primdam))
levels(fwherb$primdam)<-gsub(" ds", "dis", levels(fwherb$primdam))

levels(fwherb$primdam)<-gsub("na", "NA", levels(fwherb$primdam))
levels(fwherb$wilt)<-gsub("na", "NA", levels(fwherb$wilt))


#fix levels of damclass
fwherb$damclass<-as.factor(fwherb$damclass) 
fwherb$damclass<-factor(fwherb$damclass, levels=c("0", "<2", "2-5", "5-10", "10-25", "25-50", "50-75", "75-99", "100"))

#make variable to classify herbivory into three categories
fwherb$herbcat<-"NA"
fwherb[(fwherb$damclass=="0" | fwherb$damclass=="<2" | fwherb$damclass=="2-5") & !is.na(fwherb$damclass),]$herbcat<-"low"
fwherb[(fwherb$damclass=="5-10" | fwherb$damclass=="10-25") & !is.na(fwherb$damclass),]$herbcat<-"medium"
fwherb[(fwherb$damclass=="25-50" | fwherb$damclass=="50-75" | fwherb$damclass=="75-99"| fwherb$damclass=="100") & !is.na(fwherb$damclass),]$herbcat<-"high"
fwherb$herbcat<-factor(fwherb$herbcat, levels=c("low", "medium", "high"))

summary(fwherb)

#remove incomplete data
fwherb<-fwherb[!is.na(fwherb$trt),] #remove all with na for trt
fwherb<-fwherb[!is.na(fwherb$spp),] #remove all with na for spp - can't use the data if no species. plants are probably dead ones
#fwherb2<-fwherb[fwherb$spp != "unknown",] #remove all with unknown for spp
fwherb<-fwherb[fwherb$ht>0 | is.na(fwherb$ht),] #remove all with ht of 0 = dead

#remove rows without damage class data because plants didn't have herb data taken
fwherbleaf<-fwherb[!is.na(fwherb$damclass),] #remove NA's in damage class 

#make unique ID for each plant
fwherb$uniqueid<-paste(fwherb$site, fwherb$row, fwherb$col, fwherb$trt, sep="")

#check to see if database still has all info

with(fwherbleaf[!is.na(fwherbleaf$primdam),], ftable(spp, island, primdam)) 



