library(shiny)
library(tidyverse)
library(DT)
library(leaflet)


# read in and prep data  --------------------------------------------------

students_big <- read_csv("data/students_big.csv")
handed_choices <- students_big %>% 
  distinct(handed) %>% 
  pull

regions <- unique(students_big$region)

genders <- unique(students_big$gender)

colours <- c("steel blue", "red")
# ui ---------------------------------------------------

ui <- fluidPage(
  
  fluidRow(
    column(3,
           radioButtons("handed_input",
                        "Handedness",
                        choices = handed_choices,
                        inline = TRUE)),
    
    column(3,
           selectInput(inputId = "region_select",
                       label = "What region?",
                       choices = regions)),
    column(3,
           selectInput(inputId = "gender_select",
                       label = "What gender",
                       choices = genders)),
    
    column(3,
           radioButtons("colour_input",
                        "Colour",
                        choices = colours))
  ),
  
  #ADD IN ACTION BUTTON
  actionButton("update",
               "Update dashboard"), 
  
  
  fluidRow(
    column(6,
           plotOutput("travel_barplot")),
    column(6,
           plotOutput("spoken_barplot"))
  ),
  
  DT::dataTableOutput("table_output"))


#server -------------------------------------------

server <- function(input, output){
  
  filtered_data <- eventReactive(input$update, {
    students_big %>% 
      filter(handed == input$handed_input,
             region == input$region_select,
             gender == input$gender_select)
  })
  
  output$table_output <- DT::renderDataTable({
    filtered_data()
  })
  
  output$travel_barplot <- renderPlot({
    filtered_data() %>% 
      ggplot(aes(x = travel_to_school))+
      geom_bar(fill = input$colour_input)
  })
  
  output$spoken_barplot <- renderPlot({
    filtered_data() %>% 
      ggplot(aes(x = languages_spoken))+
      geom_bar(fill = input$colour_input)
  })
  
  
}

#run app ---------------------------------------

shinyApp(ui = ui,
         server = server)