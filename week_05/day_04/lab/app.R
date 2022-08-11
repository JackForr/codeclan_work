library(tidyverse)
library(shiny)
library(ggplot2)

students_big <- read_csv("data/students_big.csv")

ages <- c(10:18)

ui <- fluidPage(
  radioButtons("age_input",
               "Age",
               choices = ages,
               inline = T),
  
  fluidRow(
    column(6,
           plotOutput("height_barplot")),
    column(6,
           plotOutput("arm_barplot"))
  ),
)

server <- function(input, output){
  
  output$height_barplot <- renderPlot({
    students_big %>% 
      filter(ageyears == input$age_input) %>% 
      ggplot(aes(x = height))+
      geom_histogram()+
      theme_linedraw()
  })
  
  output$arm_barplot <- renderPlot({
    students_big %>% 
      filter(ageyears == input$age_input) %>% 
      ggplot(aes(x = arm_span))+
      geom_histogram()+
      theme_linedraw()
  }) 
}

shinyApp(ui = ui,
         server = server)
