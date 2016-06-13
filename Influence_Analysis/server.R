#Load Libraries
library(shiny)

set.seed(1523)
n <- 100
x1 <- c(rnorm(n))
y1 <- c(rnorm(n))

shinyServer(function(input, output) {
        
        xyCoord<-reactive({
                xy<-c(input$pointx,input$pointy)
        })
        
        # output$point <- renderText({
        #         paste0("x=",xyCoord()[1],sep="")
        #         # paste0("y=",xyCoord()[2],sep="")
        # })
        
        output$text <- renderUI({
                str1 <- paste("x=",xyCoord()[1])
                str2 <- paste("y=",xyCoord()[2])
                HTML(paste(str1, str2))
        })
        
        
})