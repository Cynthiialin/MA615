#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(ggmap)

library(maptools)
library(maps)
library(ggplot2)
library(mapproj)

mapWorld <- map_data("world")

mp1 <- ggplot(mapWorld, aes(x=long, y=lat, group=group))+
  geom_polygon(fill="white", color="black") +
  coord_map(xlim=c(-160,160), ylim=c(-60, 90))

mp2 <- mp1 + coord_map("cylindrical",xlim=c(-180,180), ylim=c(-60, 90))
mp3 <- mp1 + coord_map("sinusoidal", xlim=c(-180,180), ylim=c(-60, 90))
mp4 <- mp1 + coord_map("mercator",xlim=c(-180,180), ylim=c(-60, 90))
mp5 <- mp1 + coord_map("gnomonic", xlim=c(-180,180), ylim=c(-60, 90))

mp6 <- mp1 + coord_map("rectangular", parameters = 0, xlim=c(-180,180), ylim=c(-60, 90))
mp7 <- mp1 + coord_map("cylequalarea", parameters = 0, xlim=c(-180,180), ylim=c(-60, 90))

shinyApp(
  ui = fluidPage(
    selectInput("Projection","Different World Map Projection",
                choices = c("sinusoidal",
                            "cylindrica", "mercator","gnomonic","rectangular","cylequalarea")),
    conditionalPanel("input.Projection =='sinusoidal'",
                     plotOutput("sinusoidal")),
    conditionalPanel("input.Projection =='cylindrica'",
                     plotOutput("cylindrica")),
    conditionalPanel("input.Projection =='mercator'",
                     plotOutput("mercator")),
    conditionalPanel("input.Projection =='gnomonic'",
                     plotOutput("gnomonic")),
    conditionalPanel("input.Projection =='rectangular'",
                     plotOutput("rectangular")),
    conditionalPanel("input.Projection =='cylequalarea'",
                     plotOutput("cylequalarea"))
    
  ),
  server = function(input, output) {
    
    output$sinusoidal <- renderPlot({mp3
      
    })
    output$cylindrica <- renderPlot({mp2
      
    })
    output$mercator <- renderPlot({mp4
    
    })
    output$gnomonic <- renderPlot({mp5
      
    })
    output$rectangular <- renderPlot({mp6
      
    })
    output$cylequalarea <- renderPlot({mp7
      
    })
    
  }
)


