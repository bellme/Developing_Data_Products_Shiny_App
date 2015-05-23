shinyUI(fluidPage( 
  titlePanel("Simple Linear Models of Gas Mileage"), 
  
  fluidRow(
    column(4,
           h4("Please select features on which to model gas mileage using the mtcars dataset."),
           wellPanel(
             checkboxGroupInput("features", "Feature options",
                              c("# Cylinders" = "cyl",
                                "Horsepower" = "hp",
                                "Weight" = "wt"))
       )
    ),
    
    column(4,
           h4("Please select order of polynomial terms to include for chosen features."),
           wellPanel(
              radioButtons("order", label = h3("Order of Polynomial"),
                choices = list("1" = 1, "2" = 2))
                 )
      ),
  
    column(8,
         textOutput("text1")
),

    column(8,
         textOutput("text2")
    )

),

    column(6,
           h4("Model coefficents and significance levels"),
           wellPanel(
              tableOutput('mdlTable')
            )
           ),

    column(8,
           h4("Goodness of model fit: Predicted vs Observed Values of MPG"),
         plotOutput('myPlot')
  ) 
 )
)