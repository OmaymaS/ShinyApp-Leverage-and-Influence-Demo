#Load Libraries
library(shiny)



shinyServer(function(input, output) {
        
        
        set.seed(1523)
        n <- 100
        x1 <- c(rnorm(n))
        y1 <- c(rnorm(n))
        
        xyCoord<-reactive({
                
                xy<-c(input$xx,input$yy)
                as.numeric(xy)
        })
        
        # output$point <- renderText({
        #         paste0("x=",xyCoord()[1],sep="")
        #         # paste0("y=",xyCoord()[2],sep="")
        # })
        
        # output$text <- renderUI({
        #         str1 <- paste("x=",xyCoord()[1])
        #         str2 <- paste("y=",xyCoord()[2])
        #         HTML(paste(str1, str2))
        # })
        
        
        # dat<-data.frame(X=c(xyCoord()[1],x1), 
        #                 Y=c(xyCoord()[2],y1)
        # )
        # makeReactiveBinding("dat")
        
        datxy<-reactive({
                #add the selected point to the data frame
                datX<-c(xyCoord()[1],x1)
                datY<-c(xyCoord()[2],y1)
                data.frame(X=datX,Y=datY)
                
        })
        
        
        output$RegPlot<-renderPlot({
                #add the selected point to the data frame
                # dat<-data.frame(X=c(xyCoord()[1],x1), 
                #                 Y=c(xyCoord()[2],y1)
                #                 )
                
                #plot the points and the regression line
                ggplot(datxy(),aes(x=X,y=Y))+
                        geom_point(aes(colour=(X==xyCoord()[1]& Y==xyCoord()[2])),
                                   size=3,
                                   alpha=0.5
                                   )+
                        geom_smooth(method = "lm", se = FALSE)+
                        coord_cartesian(xlim=c(-10,10),
                                        ylim=c(-10,10))+
                        scale_colour_manual(name = '',
                                            values = c('black','red'))+
                        guides(colour=F)
        })

        fitModel<-reactive({
                lm(Y~X, data=datxy())
        })
        
        fitCoef<-reactive({
                data.frame(Coefficient=c("Intercept",
                                  "Slope"),
                           Value=as.character(c(round(coef(fitModel())[1],5),
                                                round(coef(fitModel())[2],5))
                           )
                )
        })

        
        hv1<-reactive({
                hatvalues(fitModel())[1]
        })
        
        dfb1<-reactive({
                dfbetas(fitModel())[,2][1] #dfbeta for the slope
        })
        
        
        
        output$text <- renderUI({
                str0<-paste("Influence measures for the adjustable point:")
                str1 <- paste("hatvalue=",round(hv1(),5)) 
                str2 <- paste("dfbeta.x=",round(dfb1(),5)) 
                HTML(paste(str0,str1, str2,sep='<br/>'))
        })
        
        
        output$coef<-renderTable({
                fitCoef()
                
        })
        
        output$hv <- renderText({
              paste("hatvalue=",round(hv1(),5)) 
                
        })
        
        output$dfb <- renderText({
                paste("dfbeta.x=",round(dfb1(),5)) 
                
        })
        
})