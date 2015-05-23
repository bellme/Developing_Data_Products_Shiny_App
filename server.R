require(ggplot2)
data(mtcars)
shinyServer( 
  function(input, output, session) {
    
    output$text1 <- renderText({ 
      paste("You have selected feature ", input$features,". ")
    })
    
    output$text2 <- renderText({ 
      paste("You have selected polynomial of order ", input$order,".")
    })
    
    mdl <- reactive({
      
      if (input$order==1) {
        
        mdlFormula <- as.formula(paste("mpg ~ ", paste(input$features, collapse="+")))
                                 
      }  else if (input$order==2) {
        
        firstOrder <- paste("mpg ~ ", paste(input$features, collapse="+"))
        
        n <- length(input$features)
        secondOrder <- c("")
        
        for (i in 1:n) {
          
          secondOrder <- paste(secondOrder,"+ I(", input$features[i],"^2)")
          
        }
      
        mdlFormula <- as.formula(paste(firstOrder, secondOrder))
      
      }
      
      lm(mdlFormula, data=mtcars)
      
    })
    
    output$mdlTable <- renderTable({
      if(!is.null(input$features)){
        summary(mdl())$coefficients
      } else {
        print(data.frame(Warning="Please select Model Features."))
      }
    })
    
    output$myPlot <- renderPlot({
      if(!is.null(input$features)) {
        x <- data.frame(mtcars$mpg, mdl()$fitted.values)
        names(x) <- c("mpg","pred")
       g <- ggplot(aes(x=mpg, y=pred), data=x) + geom_point() + ylab("Predicted MPG") + xlab("Observed MPG") 
       g1 <- g + geom_abline(intercept=0,slope=1,colour="red",linetype=2)
       g1 + geom_text(aes(30, 35, label="Predicted = Observed", color="red")) + guides(colour=FALSE)
      }
  })
 } 
)

