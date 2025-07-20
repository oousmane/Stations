library(tmap)
library(tidyverse)
library(sf)

#----- read file

tmap_mode("view")
 
data <- read_csv2("all_station.csv",locale = locale(encoding = "latin1"))

 data_sf <- data %>% 
  drop_na() %>% 
  filter(station !="Bazega", station != "Vallée-Du-Kou") %>% 
  st_as_sf(coords = c("lon","lat"), crs=4326) %>% 
  st_filter(bvn)

 
 bvn <- read_sf("shape_ec_aen/EC_AEN.shp") %>% 
   st_transform(crs = 4326)
 reclim <- read_sf("zone_reclim.shp")
 tm_shape(bvn) +
   tm_polygons(alpha = 0.3, border.col = "blue",fill = "yellow")+
   tm_shape(reclim)+
   tm_polygons(alpha = .1, borders.col = "red")+
   
   tm_shape(data_sf) +
   tm_dots(size= 0.5)
