
##Required Libraries####

suppressPackageStartupMessages({
  if (!require(udpipe)){install.packages("udpipe")}
  if (!require(textrank)){install.packages("textrank")}
  if (!require(lattice)){install.packages("lattice")}
  if (!require(igraph)){install.packages("igraph")}
  if (!require(ggraph)){install.packages("ggraph")}
  if (!require(wordcloud)){install.packages("wordcloud")}
  if (!require(gutenbergr)){install.packages("gutenbergr")}
  if (!require(gutenbergr)){install.packages("topicmodels")}
  if (!require(gutenbergr)){install.packages("ldatunings")}
  
  library(udpipe)
  library(textrank)
  library(lattice)
  library(igraph)
  library(ggraph)
  library(ggplot2)
  library(wordcloud)
  library(stringr)
})
