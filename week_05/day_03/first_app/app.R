library(tidyverse)
library(shiny)
library(ggplot2)
library(bslib)
olympics_overall_medals <- read.csv("data/olympics_overall_medals.csv") %>% 
  mutate(medal = factor(medal, c("Gold", "Silver", "Bronze")))

all_teams <- unique(olympics_overall_medals$team)
season <- unique(olympics_overall_medals$season)

ui <- fluidPage(
  
  # theme = bs_theme(bootswatch = 'flatly'),
  # theme = 'path_to/my_stylesheet.css',
  
  titlePanel(tags$h1("Olympic Medals")),
  
  tabsetPanel(
    
    
    tabPanel(  "Plot",
               plotOutput('medal_plot')
    ),
    
    tabPanel("Which season?",
             radioButtons(inputId = 'season_input',
                          label = tags$i('Summer or Winter Olympics?'),
                          choices = season
             )
             
    ),
    tabPanel("Which team?",
             selectInput(inputId = 'team_input',
                         label = 'Which team?',
                         choices = all_teams
             )
             
    )
    
  ),
  
  # HTML: HyperText Markup Language
  tags$a('The Olympics website', href = 'https://www.Olympic.org')
  
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