library(tidyverse)
library(shiny)
library(ggplot2)

students_big <- read_csv("data/students_big.csv")

colours <- c(Blue = "#3891A6", Yellow = "#FDE74C", Red = "#E3655B")

shapes <- c("square" = "12", "circle" = "16", "triangle" = "17")

ui <- fluidPage(
  
  titlePanel(tags$h1("Reaction Time vs Memory Game")),
  
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      radioButtons(inputId = "colour_input",
                   label = "Colour of points",
                   choices = colours),
      
      sliderInput(inputId = "slider_input",
                  label = "Transparency of points",
                  min = 0,
                  max = 1,
                  step = 0.1,
                  value = 0.5),
      
      selectInput(inputId = "shape_input",
                  label = "Shape of points",
                  choices = shapes),
      
      textInput(inputId = "title_input",
                label = "Title of Graph",
                value = "Enter text..." )
    ),
    
    mainPanel = mainPanel(
      "Reaction Time vs Memory",
      br(),
      plotOutput("reaction_plot"),
    )
  )
)
  
  server <- function(input, output){
    
    output$reaction_plot <- renderPlot({
      students_big %>% 
        ggplot(aes(x = reaction_time,
                   y = score_in_memory_game))+
        geom_point(shape = as.integer(input$shape_input),
                   colour = input$colour_input,
                   alpha = input$slider_input,
                   show.legend = F,
                   size = 0.5)+
        theme_linedraw()
    })
    
  }
  
  
  shinyApp(ui = ui,
           server = server)