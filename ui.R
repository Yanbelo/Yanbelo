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
