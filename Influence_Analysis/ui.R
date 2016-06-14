#Load Libraries
library(shiny)
library(ggplot2)


# Define UI for miles per gallon application
shinyUI(fluidPage(
        
        # Application title
        titlePanel("Influence Analysis"),
        
        # Sidebar with controls to select the coordinates of the additional point
        sidebarLayout(
                
                
                
                sidebarPanel(
                        helpText("This simple Shiny app demonstrates the leverage and influence of an adjustable point 
                                 that is part of a dataset with 101 points; 100 of which are normally distributed. You can 
                                 select the X-Y coordinates of the adjustable point using the following sliders with ranges from
                                 [-10,10] for both X and Y. The adjustable point appears in red on the graph. "),
                        #X value
                        sliderInput("xx", "X",
                                    min=-10, max=10, value=0),
                        #Y value
                        sliderInput("yy", "Y",
                                    min=-10, max=10, value=0)
                ),
                
                
                mainPanel(
                        plotOutput("RegPlot"),
                        h4(htmlOutput("CoefTitle")),
                        tableOutput("coef"),
                        h4(htmlOutput("measTitle")),
                        tableOutput("meas")
                )
        )
))
