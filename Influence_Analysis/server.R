#Load Libraries
library(shiny)



shinyServer(function(input, output) {
        
        xyCoord<-reactive({
                set.seed(1523)
                n <- 100
                x1 <- c(rnorm(n))
                y1 <- c(rnorm(n))
                
                xy<-c(input$pointx,input$pointy)
                as.numeric(xy)
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
        
        output$RegPlot<-renderPlot({
                dat<-data.frame(X=c(xyCoord()[1],x1),
                                Y=c(xyCoord()[1],y1))
                ggplot(dat,aes(X,Y))+
                        geom_point()+
                        geom_smooth(method = "lm", se = FALSE)+
                        coord_cartesian(xlim=c(-10,10),
                                        ylim=c(-10,10))+
                        geom_point(
                                   aes(x=xyCoord()[1],y=xyCoord()[2]),
                                   colour="red")
        })
        
        
})