################################################################################
##                ui                                                          ##
################################################################################

library(shiny)

shinyUI(
        pageWithSidebar(
        # Application Title
        headerPanel("Simple Model for MPG Prediction"),
        
        sidebarPanel(
                p("This application allows the user to obtain a mileage
                  consumption prediction based on a basic set of features."),
                h4("Model Specification"),
                p("The predictions are based on a linear regression model
                  specified with transmission type, horsepower, weight, and the
                  interactions between horsepower and transmission, and weight
                  and transmission."),
                h4("Power:"),
                p("Enter a number of horsepower for the vehicle."),
                numericInput("hp", "Gross Horsepower", 150, min=50, max=500, step=5),
                h4("Weight:"),
                p("Enter the weight of the vehicle in pounds."),
                numericInput("wt", "Weight (lb)", 3200, min=1000, max=8000, step=100),
                h4("Transmission type:"),
                p("Select the type of transmission."),
                radioButtons("trans", "Transmission",
                             c("Automatic" = "Auto", "Manual" = "Manual")),
                submitButton("Predict MPG for this Car!")
        ),
        mainPanel(
                h3("Results of prediction"),
                h4("Based on the input you entered:"),
                verbatimTextOutput("prediction"),
                h4("Mileage per Gallon comparison"),
                p("The following plot shows the distribution of MPG based on the
                  data from the 1974 Motor Trend US magazine. The dashed black
                  line corresponds to the mean MPG for the 32 cars in the dataset,
                  and the red line corresponds to the prediction based on the
                  input you entered."),
                plotOutput("newHist")
        )
))