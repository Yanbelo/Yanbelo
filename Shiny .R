# Import libraries
library(shiny)
library(data.table)
library(randomForest)

# Read in the RF model
model <- readRDS("model2.rds")

####################################
# User interface                   #
####################################

ui <- pageWithSidebar(
  
  # Page header
  headerPanel('WQI Predictor'),
  
  # Input values
  sidebarPanel(
    #HTML("<h3>Input parameters</h3>"),
    tags$label(h3('Input parameters')),
    numericInput("Ca", 
                 label = "Ca", 
                 value = 23),
    numericInput("Mg", 
                 label = "Mg", 
                 value = 3.6),
    numericInput("K", 
                 label = "K", 
                 value = 1.4),
    numericInput("Na", 
                 label = "Na", 
                 value = 0.2),
    numericInput("Fl", 
                 label = "Fl", 
                 value = 0.2),
    numericInput("SO4",
                 label ="SO4",
                 value = 2.4),
    numericInput("Cl",
                 label = "Cl",
                 value = 3.6),
    numericInput("NO3",
                 label ="NO3",
                 value = 4.6),
    numericInput("TH",
                 label ="TH",
                 value = 5.7),
    numericInput("pH",
                 label ="pH",
                 value = 6.9),
    numericInput("EC",
                 label = "EC",
                 value = 34.67),
    numericInput("TDS",
                 label = "TDS",
                 value = 5.67),
    actionButton("submitbutton", "Submit", 
                 class = "btn btn-primary")
  ),
  
  mainPanel(
    tags$label(h3('Status/Output')), # Status/Output Text Box
    verbatimTextOutput('contents'),
    tableOutput('tabledata') # Prediction results table
    
  )
)

####################################
# Server                           #
####################################
str(data)

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

####################################
# Create the shiny app             #
####################################
shinyApp(ui = ui, server = server)
