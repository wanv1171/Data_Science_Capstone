#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  miniPred <- readRDS("miniDict.rds")
  
  ngram2 <- function(data, ngramFlag) {
    strParts <- strsplit(data," ", fixed=TRUE)[[1]]
    
    length <- length(strParts)
    model <- miniPred[[ngramFlag]]
    
    if(ngramFlag == 1) {
      predicted <- model
    }
    else if(ngramFlag == 2) {
      predicted <- model[model$Pred1 == strParts[length],"Predicted"]
    }
    else if(ngramFlag == 3) {
      predicted <- model[model$Pred1 == strParts[length-1] & model$Pred2 == strParts[length],"Predicted"]
    }
    else if(ngramFlag == 4) {
      predicted <- model[model$Pred1 == strParts[length-2] & model$Pred2 == strParts[length-1] & model$Pred3 == strParts[length],"Predicted"]
    }
    else {
      predicted <- model[model$Pred1 == strParts[length-3] & model$Pred2 == strParts[length-2] & model$Pred3 == strParts[length-1] & model$Pred4 == strParts[length],"Predicted"]
    }
    
    ifelse(length(predicted) == 0, return(ngram2(data, ngramFlag - 1)), return(predicted))
  }
  
  ngramPredict <- function(data) {
    strLength <- length(strsplit(data, " ", fixed = TRUE)[[1]])
    ngramFlag <- strLength + 1
    
    if (ngramFlag > 5) {
      ngramFlag <- 5
    }
    
    ngram2(data, ngramFlag)
  }
  
  output$output1 <- renderText({
    if (nchar(input$input1) == 0) {
      return("")
    }
    else {
      prediction <- ngramPredict(input$input1)
      
      returnVals <- ""
      
      for (predicted in prediction) {
        predicted <- paste(predicted, "\n", sep="", collapse = "")
        returnVals <- paste(returnVals, predicted, sep="", collapse = "")
      }
      
      returnVals
    }
  })
  
})
