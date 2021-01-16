# Attach packages
library(shiny)
library(tidyverse)
library(palmerpenguins)


#Create the user interface
ui <-fluidPage(
    titlePanel("I am adding a TITLE!"),
    sidebarLayout(
        sidebarPanel("put my widgets here",
                     radioButtons(inputId = "penguin_species",
                                 label = "Choose penguin species:",
                                 choices = c("Adelie", "COOL Chinstrap Penguins" = "Chinstrap", "Gentoo")
                     )), # user can choose which species to show the graph for
        mainPanel("Here's my graph",
                  plotOutput(outputId = "penguin_plot")) #makes graph show up
    )
)


# Create the server function
server <- function(input, output) {

    penguin_select <- reactive({
        penguins %>%
            filter(species == input$penguin_species) # penguin_select will be the data frame we put into the ggplot,
    })

    output$penguin_plot <- renderPlot({

        ggplot(data = penguin_select(), aes(x=flipper_length_mm, y= body_mass_g)) +
            geom_point() #need () after data because it is a reactive data set
    })
}


# Combine into an app
shinyApp(ui = ui, server = server)
