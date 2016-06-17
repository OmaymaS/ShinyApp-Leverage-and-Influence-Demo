#Load Libraries
library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
        
        #generate normally distributed 100 points
        set.seed(1523)
        n <- 100
        x1 <- rnorm(n) ; x1<-x1-mean(x1) #center the data
        y1 <- rnorm(n) ; y1<-y1-mean(y1)
        
        #get slider inputs (x,y)
        xyCoord<-reactive({
                
                xy<-c(input$xx,input$yy)
                as.numeric(xy)
        })
        
        #create a dataframe with (x,y) and the 100 points
        datxy<-reactive({
                #add the selected point to the data frame
                datX<-c(xyCoord()[1],x1)
                datY<-c(xyCoord()[2],y1)
                data.frame(X=datX,Y=datY)
                
        })
        
        #plot the points and the regression line
        output$RegPlot<-renderPlot({
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
        
        #fit a linear regression model 
        fitModel<-reactive({
                lm(Y~X, data=datxy())
        })
        
        #get the coeff of the model
        fitCoef<-reactive({
                data.frame(Coefficient=c("Intercept",
                                  "Slope"),
                           Value=as.character(c(round(coef(fitModel())[1],5),
                                                round(coef(fitModel())[2],5))
                           )
                )
        })
        
       #create a dataframe with the influence measures
        measures<-reactive({
                #hatvalue for the selected point
                hv1<-reactive({
                        hatvalues(fitModel())[1]
                })
                
                resid1<-reactive({
                        resid(fitModel())[1]
                })
                
                #dfbeta for the slope
                dfb1<-reactive({
                        dfbetas(fitModel())[,1][1] 
                })
                
                #dfbeta for the slope
                dfbx<-reactive({
                        dfbetas(fitModel())[,2][1] 
                })
                        
                data.frame(
                        Measure=c("hatvalue",
                                  "residual",
                                  "dfbeta.1",
                                  "dfbeta.x"),
                        Value=as.character(c(round(hv1(),5),
                                             round(resid1(),5),
                                             round(dfb1(),5),
                                             round(dfbx(),5))
                                           )
                )
                
        })
        
         
        #title before the coeff table
        output$CoefTitle<-renderText({
                paste("Linear regression model coefficients")
        })
        
        #coeff table
        output$coef<-renderTable({
                fitCoef()
                
        })
        
        #title beforethe influence measures table
        output$measTitle <- renderText({
                paste("Influence measures for the adjustable point")
        })
        
        #influence measure table
        output$meas<-renderTable({
                measures()
                
        })
})