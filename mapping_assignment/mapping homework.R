library(classInt)
library(tmap)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(mapview)
library(leaflet)
library(knitr)
library(esquisse)
library(sf)
library(spdep)
library(rgdal)

library(sp)
library(tidyverse)
library(rgeos)

s.sf <- readOGR(dsn=".",layer ="Colleges_and_Universities")

s.sf<-as.data.frame(s.sf)
college<-read.csv("Colleges.csv")
leaflet(options = leafletOptions(minZoom = 0, maxZoom = 18))
m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=-71.09971, lat=42.34956, popup="Boston University")%>%
  addMarkers(lng=-71.12006, lat=42.36523, popup="Harvard Business School")%>%
  addCircles(data = s.sf, lat = ~Latitude, lng = ~Longitude, weight = 3)
m  # Print the map

m1 <- leaflet() %>%
  addTiles() %>% 
  addMarkers(lng=-71.09971, lat=42.34956, popup="Boston University")%>%
  addMarkers(lng=-71.12006, lat=42.36523, popup="Harvard Business School")
m1

head(s.sf)
glimpse(s.sf)



p <- ggplot() +  geom_polygon(data=s.sf, aes(x=Longitude, y=Latitude), 
                              color="blue", lwd = .25)

p

ggplot() + geom_polygon(data=s.sf, aes(x=Longitude, y=Latitude,group=City))


ggplot() + geom_point(data=s.sf, aes(x=Longitude, y=Latitude), color="red")


ggplot() + geom_polygon(data = college, aes(x=Longitude, y = Latitude)) + 
  coord_fixed(1.3)


library(ggmap)
library(ggplot2)
m3<-qmplot(Longitude, Latitude, data = college, maptype = "watercolor", zoom = 3,
       color = I("red"), size = I(2.5))
m3

m4<-qmplot(Longitude, Latitude, data = college, 
           color = I("red"), size = I(2.5))
m4

