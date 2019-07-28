
#install.packages("shiny")
library("shiny")

ui <- shinyUI(
  fluidPage(
    
    titlePanel("NLP with UDpipe"),
    
    sidebarLayout( 
      
      sidebarPanel(  
        
        fileInput("file", "Upload data (Text file)"),
        
        checkboxGroupInput('upos', 'Select Universal part-of-speech tags (upos) for plotting co-occurrences',
                           c("Adjective (ADJ)" = "ADJ",
                             "Noun(NOUN)" = "NOUN",
                             "Proper Noun (PROPN)" = "PROPN",
                             "Adverb (ADV)" = "ADV",
                             "verb (VERB)" = "VERB"),
                           selected = c("ADJ","NOUN","PROPN"))     
      ),   # end of sidebar panel
      
      
      mainPanel(
        
        tabsetPanel(type = "tabs",
                    
                    tabPanel("Overview",
                             h4(p("Data input")),
                             p("This app supports text file.",align="justify"),
                             p("Please refer to the link below for sample text file."),
                             a(href="https://raw.githubusercontent.com/sudhir-voleti/sample-data-sets/master/text%20analysis%20data/amazon%20nokia%20lumia%20reviews.txt"
                               ,"Sample data input file"),   
                             br(),
                             h4('How to use this App'),
                             p('To use this app, click on', 
                               span(strong("Upload data (text file)")),
                               'and uppload the text file. You can also change select the list of Universal part-of-speech tags (upos) using check box for plotting co-occurrences')),
                    tabPanel("Table of Annotated Documents ", 
                             dataTableOutput('datatableOutput')),
                    downloadButton("download","Download Annotated Data"),
                    
                    tabPanel("wordclouds",
                             h3("Noun WordCloud"),
                             plotOutput('wcplot1'),
                             h3("Verb Wordcloud"),
                             plotOutput('wcplot2')),
                    
                    tabPanel("Co-occurrences - Plot",
                             plotOutput('Cooc_graph'))
                    
        ) # end of tabsetPanel
      )# end of main panel
    ) # end of sidebarLayout
  )  # end if fluidPage
) # end of UI