library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

df <- read.csv("owid-co2-data.csv", stringsAsFactors = FALSE)
df2 <- df %>%
  filter(!country %in% c('World')) %>%
  na.omit(df)

df <- df %>%
  summarise(
    country,
    year,
    co2_per_capita
  ) %>%
  na.omit(df)

highest_per_capita <- df %>%
  filter(year == max(year)) %>%
  filter(co2_per_capita == max(co2_per_capita)) %>%
  select(country)

lowest_per_capita <- df %>%
  filter(year == max(year)) %>%
  filter(co2_per_capita == min(co2_per_capita)) %>%
  select(country)

highest_annual_growth <- df2 %>%
  filter(year == max(year)) %>%
  filter(co2_growth_abs == max(co2_growth_abs)) %>%
  select(country)


shinyServer(function(input, output) {
  output$selectCountry <- renderUI({
    selectInput("country", "Choose a country:", choices = unique(df$country))
  })

  
  df_plot <- reactive({
    df <- df %>%
      filter(country %in% input$country)
    ggplot(df, aes(x = year, y = co2_per_capita)) +
      geom_line(color = 2) +
      geom_point(color = 2) +
      scale_y_continuous() +
      labs(x = "Year", y = "Tonnes")
  })
  output$countryPlot <- renderPlotly({
    ggplotly(df_plot())
  })
  
  
  output$highest_per_capita <- renderText(paste(highest_per_capita))
  
  output$lowest_per_capita <- renderText(paste(lowest_per_capita))
  
  output$highest_annual_growth <- renderText(paste(highest_annual_growth))
  
})
  





