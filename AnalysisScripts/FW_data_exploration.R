#FW project
##Data exploration

#Questions: 
#Does the amount of herbivory differ between islands and/or between treatments on islands with birds? 
#Does the type of herbivory differ between treatments and/or between islands and/or between species? 


####dataset doesn't have a whole lot of Guam data- latest date for Guam data is 02Sept2010, and that is only for three sites
#rest of data ends in Feb 2011. very little aglaia, premna data, no psychotria data. 


ggplot(fwherbleaf[!is.na(fwherbleaf$primdam) & fwherbleaf$spp!="aglaia" & fwherbleaf$spp!= "unknown" & fwherbleaf$spp!= "premna",], aes(island))+

geom_bar()+
  facet_grid(spp~primdam) 

damage<-ddply(fwherbleaf, .(island, date, site, spp, trt, damclass), summarize, herbcatnum=length(damclass))

damage<-ddply(fwherbleaf, .(island, date, site, spp, trt, herbcat), summarize, herbcatnum=length(herbcat))

damagetotleaves<-ddply(damage, .(island, date, site, spp, trt), summarize, totleaves= sum(herbcatnum))

damage2<-merge(damage, damagetotleaves, by=c("island", "date", "site", "spp", "trt"), all.x=T)

damage2$prop<-damage2$herbcatnum/damage2$totleaves

ggplot(damage2[damage2$spp!="aglaia" & damage2$spp!= "unknown" & damage2$spp!= "premna" & !is.na(damage2$spp) & damage2$island!="guam",], aes(trt, prop))+
  geom_boxplot()+
  facet_grid(spp~herbcat)
#maybe difference in variance? 

ggplot(damage2[damage2$spp!="aglaia" & damage2$spp!= "unknown" & damage2$spp!= "premna" & !is.na(damage2$spp) & damage2$island=="rota",], aes(trt, prop))+
  geom_boxplot()+
  facet_grid(spp~herbcat)

ggplot(damage2[damage2$trt!="excl" & damage2$spp!= "unknown" & !is.na(damage2$spp),], aes(island, prop))+
  geom_boxplot()+
  facet_grid(spp~herbcat)

#subset by date

with(damage2[damage2$date>"2010-09-01",], ftable(island, date, spp))

## 
ggplot(fwherb[fwherb$spp!="unknown" & fwherb$spp!="" & fwherb$trt!="" & !is.na(fwherb$spp) & fwherb$spp!="??" & fwherb$trt=="open",], aes(island, ht))+
  geom_boxplot()+
  ylim(0,10)+
  facet_grid(spp~., scales="free")