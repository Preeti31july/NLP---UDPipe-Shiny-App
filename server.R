#Kushagra Saxena (11915063) Preeti Sharma (11915023) Ujjwal Hadial (11915031)#


#---------------------------------------------------------------------#
#               NLP in R with UDpipe                                  #
#---------------------------------------------------------------------#


# Define Server function

# setup working dir
require(stringr)

setwd('E:\\cba\\taba assign');  getwd()

server <- shinyServer(function(input, output) {
  
  Dataset <- reactive({
    if (is.null(input$file)) { return(NULL) }
    else{
      Data <- readLines(input$file$datapath)
      Encoding(Data) <- "latin1"
      z <- iconv(Data,"latin1","UTF-8",sub=' ')
      x = str_replace_all(z, "<.*?>", "")
      z = z[z!= ""]
      str(z)
      return(z)
    }
  })
  
  english_model = reactive({
    english_model = udpipe_load_model("english-ewt-ud-2.4-190531.udpipe")
    return(english_model)
  })
  
  annotate_doc = reactive({
    x <- udpipe_annotate(english_model(),x = Dataset())
    x <- as.data.frame(x)
    return(x)
  })
  
  output$datatableOutput = renderDataTable({
    if(is.null(input$file)){return(NULL)}
    else{
      table = annotate_doc()[,-4]
      return(table)
    }
  })
  
  output$downloadData <- downloadHandler(
    filename = function(){
      "annotate_doc.csv"
    },
    content = function(file){
      write.csv(annotate_doc()[,-4],file,row.names = FALSE)
    }
  )
  
  
  output$wcplot1 = renderPlot({
    if(is.null(input$file)){return(NULL)}
    else{
      all_nouns = annotate_doc() %>% subset(., upos %in% "NOUN") 
      top_nouns = txt_freq(all_nouns$lemma)  # txt_freq() calcs noun freqs in desc order
      
      wordcloud(words = top_nouns$key, 
                freq = top_nouns$freq, 
                min.freq = 2, 
                max.words = 100,
                random.order = FALSE, 
                colors = brewer.pal(6, "Dark2") )
    }
  })
  
  output$wcplot2 = renderPlot({
    if(is.null(input$file)){return(NULL)}
    else{
      all_verbs = annotate_doc() %>% subset(., upos %in% "VERB") 
      top_verbs = txt_freq(all_verbs$lemma)
      
      wordcloud(words = top_verbs$key, 
                freq = top_verbs$freq, 
                min.freq = 2, 
                max.words = 100,
                random.order = FALSE, 
                colors = brewer.pal(6, "Dark2") )
    }
  })
  
  output$Cooc_graph = renderPlot({
    if(is.null(input$file)){return(NULL)}
    else{
      doc_cooc <- cooccurrence(   	# try `?cooccurrence` for parm options
        x = subset(annotate_doc(), upos %in% input$upos), 
        term = "lemma", 
        group = c("doc_id", "paragraph_id", "sentence_id"))
      
      wordnetwork <- head(doc_cooc, 50)
      wordnetwork <- igraph::graph_from_data_frame(wordnetwork) # needs edgelist in first 2 colms.
      
      ggraph(wordnetwork, layout = "fr") +  
        
        geom_edge_link(aes(width = cooc, edge_alpha = cooc), edge_colour = "orange") +  
        geom_node_text(aes(label = name), col = "darkgreen", size = 6) +
        
        theme_graph(base_family = "Arial Narrow") +  
        theme(legend.position = "none") +
        
        labs(title = "Cooccurrences within 3 words distance", subtitle = "Nouns & Adjective")
    }
  })
})

# Now call shinyApp function

shinyApp(ui = ui, server = server)

```

