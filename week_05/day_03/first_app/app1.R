library(tidyverse)
library(shiny)
library(ggplot2)
library(bslib)
olympics_overall_medals <- read.csv("data/olympics_overall_medals.csv") %>% 
  mutate(medal = factor(medal, c("Gold", "Silver", "Bronze")))

all_teams <- unique(olympics_overall_medals$team)
season <- unique(olympics_overall_medals$season)

ui <- fluidPage(
  
  theme = bs_theme(bootswatch = "flatly"),
  
  titlePanel(tags$h1("Olympic Medals")),
  
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      p("Sidebar"),
      p("Some other text in the side bar"),
      radioButtons(inputId = "season_input",
                   label = tags$i("Summer or Winter Olympics?"
                                  ),
                   choices = season
                   ),
      
      selectInput(inputId = "team_input",
                  label = "Which team?",
                  choices = all_teams
                  )
    ), 
    
    mainPanel = mainPanel(
      "Main panel",
      br(),
      br(),
      "Some other text in the main section",
      plotOutput("medal_plot"),
      
      tags$a("The Olympics website", href = "https://www.olympic.org")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$medal_plot <- renderPlot({
    olympics_overall_medals %>% 
      filter(team == input$team_input,
             season == input$season_input) %>%
      ggplot(aes(x = medal, y = count, fill = medal)) +
      geom_col()
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
