#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(markdown)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Next Word Predictor"),
  
  # Input for predictors
  sidebarLayout(
    sidebarPanel(
       textInput("input1", label = "Enter text to begin", "")
    ),
    
    # Show predicted words
    mainPanel(
      tabsetPanel(
        tabPanel("Prediction", verbatimTextOutput("output1")),
        tabPanel("Instructions", includeMarkdown("README.MD"))
      )
    )
  )
))
