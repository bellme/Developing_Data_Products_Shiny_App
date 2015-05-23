## Creates UI that takes features and polynomial order chosen by user and outputs model coefficients 
## of a linear model of gas mileage on these features, their statistical relevance, and a graphical 
## representation of goodness of fit using the mtcars data set

## feature options on which mtcars$mpg will be modeled
##    - mtcars$cyl  - # cylinders
##    - mtcars$hp   - horsepower
##    - mtcars$wt   - weight

## features will be fit with either first or first and second order polynomial terms depending on
## user input

## Basic instruction on how to use the app and what the outputs are is included in the app itself


shinyUI(fluidPage( 
  titlePanel("Simple Linear Models of Gas Mileage"), 
  
  fluidRow(
    column(4,
           ## Instructions on choosing features
           h4("Please select features on which to model gas mileage using the mtcars dataset."),
           wellPanel(
             checkboxGroupInput("features", "Feature options", ## creates check box in which user
                              c("# Cylinders" = "cyl",         ## selects model features
                                "Horsepower" = "hp",
                                "Weight" = "wt"))
       )
    ),
    
    column(4,
           ## Instructions on choosing order of polynomial
           h4("Please select order of polynomial terms to include for chosen features."),
           wellPanel(
              radioButtons("order", label = h3("Order of Polynomial"), ## creates radio button box
                choices = list("1" = 1, "2" = 2))                      ## in which user selects order
                 )                                                     ## of polynomial terms
      ),
  
    column(8,
           ## returns user input for verification
         textOutput("text1")
),

    column(8,
           ## returns user input for verification
         textOutput("text2")
    )

),

    column(8,
           ## Explanation of table output
           h4("Model coefficents, standard errors, t-statistics, and p-values"),
           wellPanel(
              tableOutput('mdlTable')
            )
           ),

    column(8,
           ## Explanation of graphical output
           h4("Goodness of model fit: Predicted vs Observed Values of MPG"), 
           h5("(Dotted line indicates where predicted values would equal observed values of MPG)"),
         plotOutput('myPlot')
  ) 
 )
)