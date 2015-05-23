## Creates linear model using features and polynomial order chosen by user and computes model coefficients 
## Linear model of gas mileage is built on these features, their statistical relevance, and a graphical 
## representation of goodness of fit using the mtcars data set are returned through ui.R

## feature options on which mtcars$mpg will be modeled
##    - mtcars$cyl  - # cylinders
##    - mtcars$hp   - horsepower
##    - mtcars$wt   - weight

## features will be fit with either first or first and second order polynomial terms depending on
## user input

## Basic instruction on how to use the app and what the outputs are is included in the app itself

require(ggplot2)
data(mtcars)
shinyServer( 
  function(input, output, session) {
    
    output$text1 <- renderText({ 
      ## Verify user input
      paste("You have selected feature ", input$features,". ")
    })
    
    output$text2 <- renderText({ 
      ## Verify user input
      paste("You have selected polynomial of order ", input$order,".")
    })
    ## Create reactive function to generate model
    mdl <- reactive({
      
      if (input$order==1) {
        ## linear model formula with first order terms for input features
        mdlFormula <- as.formula(paste("mpg ~ ", paste(input$features, collapse="+")))
                                 
      }  else if (input$order==2) {
        ## first order terms for input features
        firstOrder <- paste("mpg ~ ", paste(input$features, collapse="+"))
        
        n <- length(input$features)
        secondOrder <- c("")
        
        for (i in 1:n) {
          ## second order terms for input features
          secondOrder <- paste(secondOrder,"+ I(", input$features[i],"^2)")
          
        }
        ## linear model formula with first and second order terms for input features
        mdlFormula <- as.formula(paste(firstOrder, secondOrder))
      
      }
      ## compute linear model
      lm(mdlFormula, data=mtcars)
      
    })
    
    output$mdlTable <- renderTable({
      if(!is.null(input$features)){
        ## output summary of model coefficients, values, stdevs, t-statistics and p values
        summary(mdl())$coefficients
      } else {
        print(data.frame(Warning="Please select Model Features."))
      }
    })
    
    output$myPlot <- renderPlot({
      if(!is.null(input$features)) {
        ## once features have been selected, output a plot of predicted values from model vs
        ## actual values from mtcars data set - include dotted red line to indicate
        ## where the predicted values would equal the observed values
        x <- data.frame(mtcars$mpg, mdl()$fitted.values)
        names(x) <- c("mpg","pred")
       g <- ggplot(aes(x=mpg, y=pred), data=x) + geom_point() + ylab("Predicted MPG") + xlab("Observed MPG") 
       g1 <- g + geom_abline(intercept=0,slope=1,colour="red",linetype=2)
       g1 + geom_text(aes(30, 35, label="Predicted = Observed", color="red")) + guides(colour=FALSE)
      }
  })
 } 
)

