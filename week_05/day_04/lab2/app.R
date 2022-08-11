library(tidyverse)
library(shiny)
library(ggplot2)

students_big <- read_csv("data/students_big.csv")

colours <- c(Blue = "#3891A6", Yellow = "#FDE74C", Red = "#E3655B")

shapes <- c("square", "circle", "triangle")

ui <- fluidPage(
  
  titlePanel(tags$h1("Reaction Time vs Memory Game")),
  
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      p("Reaction Time vs Memory Game"),
      radioButtons(inputId = "colour_input",
                   label = "Colour of points",
                   choices = colours),
      
      sliderInput(inputId = "slider_input",
                  label = "Transparency of points",
                  min = 0,
                  max = 1,
                  value = 0.5),
      
      selectInput(inputId = "shape_input",
                  label = "Shape of points",
                  choices = shapes)
    )),
  
  mainPanel = mainPanel(
    "Reaction Time vs Memory",
    br(),
    plotOutput("reaction_memory_plot"),
  )
)

server <- function(input, output){
  
  
}


shinyApp(ui = ui,
         server = server)