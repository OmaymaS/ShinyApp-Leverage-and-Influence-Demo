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
                        selectInput("pointx", "Choose x coordinate:", 
                                    choices = c(-10,0,10)
                                    ),
                        selectInput("pointy", "Choose y coordinate:", 
                                    choices = c(-10,0,10)
                        )
                ),
                
                
                mainPanel(
                        h4(textOutput("point")),
                        htmlOutput("text"),
                        plotOutput("RegPlot")
                )
        )
))
