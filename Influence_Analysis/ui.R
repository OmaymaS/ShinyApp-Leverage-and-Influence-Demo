#Load Libraries
library(shiny)
library(ggplot2)


# Define UI for miles per gallon application
shinyUI(fluidPage(
        
        # Application title
        titlePanel("Influence Analysis"),
        
        # Sidebar with controls to select the variable to plot against
        # mpg and to specify whether outliers should be included
        sidebarLayout(
                sidebarPanel(
                        
                        # Simple integer interval
                        sliderInput("xx", "X",
                                    min=-10, max=10, value=0),
                        
                        sliderInput("yy", "Y",
                                    min=-10, max=10, value=0)
                ),
                
                
                mainPanel(
                       
                        # h4(htmlOutput("text")),
                        plotOutput("RegPlot"),
                        tableOutput("coef"),
                        h4(htmlOutput("text"))
                )
        )
))
