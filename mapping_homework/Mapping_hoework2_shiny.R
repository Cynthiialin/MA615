#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(classInt)
library(tmap)
library(ggplot2)
library(maps)
library(mapdata)
library(mapview)
library(leaflet)
library(knitr)
library(maptools)
library(maps)
library(ggmap)

library(mapproj)
library(shiny)


library(readxl)
library(nlme)
library(tidyverse)
library(ggfortify)
library(lubridate)
library(grid)
library(gridExtra)
library(plotly)
library(devtools)
library(stringr)
library(grid)
library(shinydashboard)
library(tidyverse)
library(ggthemes)
library(psych)
library(sf)

#s.sf <- readOGR(dsn=".",layer ="Colleges_and_Universities")

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
  addMarkers(lng=-71.12006, lat=42.36523, popup="Harvard Business School")%>%
  addMarkers(lng=-71.061, lat=42.35, popup="Tufts University School of Medicine")%>%
  addMarkers(lng=-71.089011, lat=42.346689, popup="Berklee College of Music")%>%
  addMarkers(lng=-71.088892, lat=42.3400479, popup="Northeastern University")
m1

m3<-qmplot(Longitude, Latitude, data = college, maptype = "watercolor", zoom = 3,
           color = I("red"), size = I(2.5))
m3



m4<-qmplot(Longitude, Latitude, data = college, 
           color = I("red"), size = I(2.5))

m4

ui <- dashboardPage(
  dashboardHeader(title = "Boston Universities and colleges"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("About the Dataset ", tabName = "about", icon = icon("info")),
      menuItem("Mapping I", tabName = "data", icon = icon("info")),
      menuItem("Mapping II", tabName = "explain", icon = icon("file"))
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "about",
        fluidRow(
          box(
            title = "About the Dataset",
            width = 12,
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            print("The dataset in coming from https://data.boston.gov/dataset/colleges-and-universities. ")
            )
            ),
        fluidRow(
          box(
            title = "Variable Selection",
            width = 12,
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            print("There are 60 observations in the dataset with 28 variables. Major variables that I have chosen is 
                  Longitude and Latitude. Based on geometric locations of universities and colleges, I choose latitude and longitude variables to analyze.")
            )
            )
            ),
      tabItem(
        tabName = "data",
        fluidRow(
          box(
            title = "Mapping Goal",
            width = 12,
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            print("The goal of mapping is to find the location of Boston University and some other schools at Boston, such as Harvard Business School,
           Tufts Univerisity School of Medicine, Berklee College of Music, Northeastern Univeristy.
                  ")
            
            )),
        fluidRow(
          box(
            title = "Location of Boston University",
            width = 12,
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
        leafletOutput("map1"))),
        
        fluidPage(
        selectInput("Maps","Maps",
                    choices = c("Map1",
                                "Map2")),
        conditionalPanel("input.Maps =='Map1'",
                         plotOutput("Map1")),
        conditionalPanel("input.Maps =='Map2'",
                         plotOutput("Map2"))
             )
      
      ), 
      
      
     
      tabItem(
        tabName = "explain",
        
        fluidRow(
              box(
                title = "Location of different Schools",
                width = 12,
                solidHeader = TRUE,
                status = "primary",
                collapsible = TRUE,
                leafletOutput("map2")))
        
          )
      
        )  
        )
      )


server <- function(input, output) {
  output$map1 <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      addMarkers(lng=-71.09971, lat=42.34956, popup="Boston University")%>%
      addMarkers(lng=-71.12006, lat=42.36523, popup="Harvard Business School")%>%
      addCircles(data = s.sf, lat = ~Latitude, lng = ~Longitude, weight = 3)
  
  })
  output$map2 <- renderLeaflet({
    leaflet() %>%
      addTiles() %>% 
      addMarkers(lng=-71.09971, lat=42.34956, popup="Boston University")%>%
      addMarkers(lng=-71.12006, lat=42.36523, popup="Harvard Business School")%>%
      addMarkers(lng=-71.061, lat=42.35, popup="Tufts University School of Medicine")%>%
      addMarkers(lng=-71.089011, lat=42.346689, popup="Berklee College of Music")%>%
      addMarkers(lng=-71.088892, lat=42.3400479, popup="Northeastern University")
    
  })
  output$Map1 <- renderPlot({m3
  })
  output$Map2 <- renderPlot({m4
  })
  
  
}

app <- shinyApp(ui, server)

