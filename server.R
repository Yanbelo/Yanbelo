library(data.table)
library(randomForest)

# Read in the RF model
model <- readRDS("model.rds")

server<- function(input, output, session) {
  
  # Input Data
  datasetInput <- reactive({  
    df <- data.frame(
      Name =c("Ca","Mg","K","Na","Fl","SO4","Cl","NO3",
              "TH","pH","EC","TDS"),
      Value = as.character(c(input$Ca, 
                             input$Mg, 
                             input$K, 
                             input$Na,
                             input$Fl,  
                             input$SO4,
                             input$Cl, 
                             input$NO3,
                             input$TH, 
                             input$pH, 
                             input$EC, 
                             input$TDS)),
      stringsAsFactors = FALSE)
    WQI <-"WQI"
    df <- rbind(df, WQI)
    input <- transpose(df)
    write.table(input,"input.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)
    test <- read.csv(paste("input", ".csv", sep=""), header = TRUE)
    Output <- data.frame(Prediction=predict(model,test), 3)
    print(Output)
    
  })
  
  # Status/Output Text Box
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("Calculation complete.") 
    } else {
      return("Server is ready for calculation.")
    }
  })
  
  # Prediction results table
  output$tabledata <- renderTable({
    if (input$submitbutton>0) { 
      isolate(datasetInput()) 
    } 
  })
}
  