################################################################################
##                server.R                                                    ##
################################################################################

library(shiny)
library(ggplot2)

## Fit Linear Model
mtcars$trans <- factor(mtcars$am, levels=c(0,1), labels=c("Auto","Manual"))
noout <- mtcars[-c(17,18,20),c("mpg","hp","wt","trans")]
fitMod <- lm(mpg~trans*hp+trans*wt, data=noout)

shinyServer(
        function(input, output) {
                output$prediction <- renderPrint({
                        # Create data frame with input data
                        newData <- data.frame(hp=input$hp,
                                              wt=(input$wt)/1000,
                                              trans=input$trans)
                        # Make prediction
                        preds <- predict(fitMod,newData)
                        paste("The expected MPG for this car is ",
                              toString(round(preds,digits=2)), sep='')
                        })
                output$newHist <- renderPlot({
                        # Create data frame with input data
                        newData <- data.frame(hp=input$hp,
                                              wt=(input$wt)/1000,
                                              trans=input$trans)
                        # Make prediction
                        preds <- predict(fitMod,newData)
                        # Make plot
                        gp1 <- ggplot(noout,aes(x=mpg))
                        gp1 <- gp1 + geom_density(fill="lightblue")
                        gp1 <- gp1 + geom_vline(xintercept = preds, colour="red")
                        gp1 <- gp1 + ggtitle("Density Plot for MPG (predicted value in red)")
                        gp1 <- gp1 + geom_vline(aes(xintercept = mean(mpg)), linetype="longdash")
                        gp1
                })
        }
)