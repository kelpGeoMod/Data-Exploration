rm(list = ls())

library(dplyr)
library(ncdf4)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

ncin <- nc_open("LandsatKelpBiomass_2021_v2_withmetadata.nc")

year <-ncvar_get(ncin,"year")
quarter <- ncvar_get(ncin,"quarter")

lon <- ncvar_get(ncin,"longitude")
lat <- ncvar_get(ncin,"latitude")
biomass<-ncvar_get(ncin,"biomass") 
biomass_se<-ncvar_get(ncin,"biomass_se")

time<-data.frame(year,quarter)

# the 3rd quater of 2018 is the 147th time stamp
df<-data.frame(lat,lon,biomass=data.frame(biomass)[,147],biomass_se=data.frame(biomass_se)[,147]) %>%
  filter(!is.na(biomass)) %>%
  filter(lat>=33.847062&lat<=34.100458&lon>=-120.291726&lon<=-119.924374)

#write.csv(df,"kelp_biomass_santaRosa_2018fall.csv",row.names = F)

library(rworldmap)
newmap <- getMap(resolution = "low")
plot(newmap, xlim = c(-122, -116), ylim = c(32, 37), asp = 1)
rbPal <- colorRampPalette(c('red','blue'))
col_bio <- rbPal(10)[as.numeric(cut(as.numeric(df$biomass),breaks = 10))]
points(df$lon, df$lat, col = col_bio, pch=16,cex = .4)

