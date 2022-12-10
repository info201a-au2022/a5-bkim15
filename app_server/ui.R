library(shiny)
library(shinythemes)
library(plotly)

shinyUI(navbarPage(theme = shinytheme("cosmo"),
                   title = "Page",
    tabPanel("Introduction",
             h3("Introduction and Goals"),
             p("In this report, we will be taking a closer look at CO2 emission across multiple countries. One of the main variables we will keep in mind while going through the visualizations will be the highest emitter of CO2 in the most recent years recorded. This is important because we want to see what place is contributing the most to our global warming problem, through this we can try and come up with solutions and offer a plan to hopefully keep the CO2 emission to a minimum. The other main variable to keep note of is what country had the highest growth in CO2 emission over the recorded time span. With this, we can look at which countries are experiencing extreme growth of CO2 emission. This finding is important because we want to prevent further growth from happening and to start we first need to figure out which countries are increasing their emission rate. With this in mind the values that were found and recorded consists of:"),
             p(strong(em("-The country with the highest CO2 emission per capita in the latest recorded year:", textOutput("highest_per_capita")))),
             p(strong(em("-The country with the lowest CO2 emission per capita in the latest recorded year:", textOutput("lowest_per_capita")))),
             p(strong(em("-The country with the highest recorded annual growth of CO2 emission:", textOutput("highest_annual_growth")))),
    ),
    tabPanel("CO2 Emissions Per Capita",
             sidebarLayout(
               sidebarPanel(
                 uiOutput("selectCountry"),
                # SLIDER NOT WORKING
                 sliderInput("df", 
                             "Range of Years",
                             min = 0, 
                             max = 1000, 
                             value = 500
                 )
                 ),
               mainPanel(
                 h3(strong("CO2 Emission Trend")),
                 plotlyOutput("countryPlot"),
                 p(strong("Takeaway:")),
                 p("From this visualization we can take note of what countries in the past recorded years emmit the most CO2 per capita. From this infomation, we can look further better ways of energy usage that would hopefully decrease said countries' emmition rate. Countries like China and the U.S. are notable but through this chart other we can also we countries that are major emmitors who are just under the public's radar. I think it is important to see a clear gragh that shows how much CO2 has actually grown, this will further drive home the serverity of our ongoing climate change issue.")
               )
             ))
))
