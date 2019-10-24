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
library(rgdal)
library(sp)
library(rgeos)
library(ggthemes)

#s.sf <- readOGR(dsn=".",layer ="Colleges_and_Universities")
#College<-readOGR("/Users/yuanyuanlin/Desktop/mssp/MA615/615/mapping_homework/Colleges_and_Universities.shp")

Public_Schools<-readOGR("/Users/yuanyuanlin/Desktop/mssp/MA615/615/mapping_homework/Public_Schools.shp")
Public_Schools<-as.data.frame(Public_Schools)




Boston<-subset(Public_Schools,Public_Schools$CITY=="Boston")

Roxbury<-subset(Public_Schools,Public_Schools$CITY=="Roxbury")

#s.sf<-as.data.frame(s.sf)
#college<-read.csv("Colleges.csv")
leaflet(options = leafletOptions(minZoom = 0, maxZoom = 18))


m1 <- leaflet() %>%
  addTiles() %>% 
  addMarkers(lng=-71.0724610662797, lat=42.3407376, popup="Blackstone Elementary")%>% 
  addMarkers(lng=-71.03048029238417, lat=42.3785452983998, popup="Kennedy Patrick Elem")
m1


m4<-qmplot(coords.x1, coords.x2, data = Boston, 
           color = I("black"), size = I(2.5))
m4


m6<-qmplot(coords.x1, coords.x2, data = Public_Schools, 
           color = I("black"), size = I(2.5))
m6

m5<-qmplot(coords.x1, coords.x2, data = Roxbury)
m5


ui <- dashboardPage(
  dashboardHeader(title = "Boston Public Schools "),
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
            print("The dataset in coming from https://data.boston.gov/dataset/public-schools. ")
            )
            ),
        fluidRow(
          box(
            title = "Variable Selection",
            width = 12,
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            print("There are 131 observations in the dataset with 18 variables. Major variables that I have chosen is 
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
            print("The goal of mapping is to find the location of Public Schools at Boston.
                  ")
            
            )),
       
        
        fluidPage(
        selectInput("Maps","Maps",
                    choices = c("Boston",
                                "Public_Schools in all area","Roxbury")),
        conditionalPanel("input.Maps =='Boston'",
                         plotOutput("Map1")),
        conditionalPanel("input.Maps =='Public_Schools in all area'",
                         plotOutput("Map2")),
        conditionalPanel("input.Maps =='Roxbury'",
                         plotOutput("Map3"))
             )
      
      ), 
      
      
     
      tabItem(
        tabName = "explain",
        
      
        fluidRow(
          box(
            title = "Location of Public Schools",
            width = 12,
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            leafletOutput("map1")))
        
          )
      
        )  
        )
      )


server <- function(input, output) {
  output$map1 <- renderLeaflet({
    leaflet() %>%
      addTiles() %>% 
      addMarkers(lng=-71.0724610662797, lat=42.3407376, popup="Blackstone Elementary")%>% 
      addMarkers(lng=-71.03048029238417, lat=42.3785452983998, popup="Kennedy Patrick Elem")
  })
  output$Map1 <- renderPlot({m4
  })
  output$Map2 <- renderPlot({m6
  })
  output$Map3 <- renderPlot({m5
  })
  
}

app <- shinyApp(ui, server)

